/*
 * AxonASP Server
 * Copyright (C) 2026 G3pix Ltda. All rights reserved.
 *
 * Developed by Lucas Guimaraes - G3pix Ltda
 * Contact: https://g3pix.com.br
 * Project URL: https://g3pix.com.br/axonasp
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 *
 * Attribution Notice:
 * If this software is used in other projects, the name "AxonASP Server"
 * must be cited in the documentation or "About" section.
 *
 * Contribution Policy:
 * Modifications to the core source code of AxonASP Server must be
 * made available under this same license terms.
 */
package axonvm

import (
	"bytes"
	"crypto/hmac"
	"crypto/md5"
	"crypto/rand"
	"crypto/sha1"
	"crypto/sha256"
	"encoding/base64"
	"encoding/hex"
	"io"
	"net/http"
	"os"
	"path/filepath"
	"strconv"
	"strings"
	"time"
)

// jsCreateFSObject allocates the Node.js-compatible fs module object.
func (vm *VM) jsCreateFSObject() Value {
	objID := vm.allocJSID()
	obj := make(map[string]Value, 8)
	obj["__js_type"] = NewString("fs")
	vm.jsObjectItems[objID] = obj
	vm.jsPropertyItems[objID] = make(map[string]jsPropertyDescriptor, 8)
	return Value{Type: VTJSObject, Num: objID}
}

// jsCreateCryptoObject allocates the Node.js-compatible crypto module object.
func (vm *VM) jsCreateCryptoObject() Value {
	objID := vm.allocJSID()
	obj := make(map[string]Value, 8)
	obj["__js_type"] = NewString("crypto")
	vm.jsObjectItems[objID] = obj
	vm.jsPropertyItems[objID] = make(map[string]jsPropertyDescriptor, 8)
	return Value{Type: VTJSObject, Num: objID}
}

// jsCreateHTTPObject allocates the Node.js-compatible http/https module object.
func (vm *VM) jsCreateHTTPObject(moduleType string) Value {
	objID := vm.allocJSID()
	obj := make(map[string]Value, 8)
	obj["__js_type"] = NewString(moduleType)
	vm.jsObjectItems[objID] = obj
	vm.jsPropertyItems[objID] = make(map[string]jsPropertyDescriptor, 8)
	return Value{Type: VTJSObject, Num: objID}
}

// jsNodeGetObjectString returns one string field from a JS object-like value.
func (vm *VM) jsNodeGetObjectString(obj Value, key string) string {
	if obj.Type != VTJSObject && obj.Type != VTJSFunction {
		return ""
	}
	v, deferred := vm.jsMemberGet(obj, key)
	if deferred || v.Type == VTJSUndefined || v.Type == VTNull {
		return ""
	}
	return vm.valueToString(v)
}

// jsNodeGetObjectValue returns one field from a JS object-like value.
func (vm *VM) jsNodeGetObjectValue(obj Value, key string) (Value, bool) {
	if obj.Type != VTJSObject && obj.Type != VTJSFunction {
		return Value{Type: VTJSUndefined}, false
	}
	v, deferred := vm.jsMemberGet(obj, key)
	if deferred || v.Type == VTJSUndefined {
		return Value{Type: VTJSUndefined}, false
	}
	return v, true
}

// jsNodeObjectBoolProperty reads one bool-like property from a JS object.
func (vm *VM) jsNodeObjectBoolProperty(obj Value, key string) bool {
	if obj.Type != VTJSObject && obj.Type != VTJSFunction {
		return false
	}
	v, deferred := vm.jsMemberGet(obj, key)
	if deferred {
		return false
	}
	return vm.jsTruthy(v)
}

// jsNodeValueBytes converts JS data to bytes for fs/crypto/http operations.
func (vm *VM) jsNodeValueBytes(v Value, encoding string) ([]byte, bool) {
	switch v.Type {
	case VTString:
		enc := strings.ToLower(strings.TrimSpace(encoding))
		if enc == "" {
			enc = "utf8"
		}
		if enc == "utf8" || enc == "utf-8" {
			return []byte(v.Str), true
		}
		if enc == "hex" {
			decoded, err := hex.DecodeString(v.Str)
			if err != nil {
				return nil, false
			}
			return decoded, true
		}
		if enc == "base64" {
			decoded, err := base64.StdEncoding.DecodeString(v.Str)
			if err != nil {
				return nil, false
			}
			return decoded, true
		}
		return []byte(v.Str), true
	case VTArray:
		if v.Arr == nil {
			return []byte{}, true
		}
		out := make([]byte, len(v.Arr.Values))
		for i := 0; i < len(v.Arr.Values); i++ {
			out[i] = byte(int(vm.jsToNumber(v.Arr.Values[i]).Flt) & 0xFF)
		}
		return out, true
	case VTJSObject:
		if vm.jsObjectStringProperty(v, "__js_type") == "Buffer" {
			if item, ok := vm.jsBufferItems[v.Num]; ok && item != nil {
				buf := make([]byte, len(item.data))
				copy(buf, item.data)
				return buf, true
			}
		}
	}
	return []byte(vm.valueToString(v)), true
}

// jsNodeResolveSandboxPath resolves one fs path inside the server sandbox.
func (vm *VM) jsNodeResolveSandboxPath(v Value) (string, bool) {
	return vm.fsoResolvePath(vm.valueToString(v))
}

// jsNodeExtractEncoding resolves optional encoding argument for fs methods.
func (vm *VM) jsNodeExtractEncoding(args []Value, index int) string {
	if len(args) <= index {
		return ""
	}
	arg := args[index]
	if arg.Type == VTString {
		return strings.ToLower(strings.TrimSpace(arg.Str))
	}
	if arg.Type == VTJSObject || arg.Type == VTJSFunction {
		enc := vm.jsNodeGetObjectString(arg, "encoding")
		return strings.ToLower(strings.TrimSpace(enc))
	}
	return ""
}

// jsCreateFSStatsObject builds one fs.statSync result object.
func (vm *VM) jsCreateFSStatsObject(info os.FileInfo) Value {
	objID := vm.allocJSID()
	obj := make(map[string]Value, 12)
	obj["__js_type"] = NewString("fs.Stats")
	obj["size"] = NewInteger(info.Size())
	obj["mtimeMs"] = NewDouble(float64(info.ModTime().UnixNano()) / 1e6)
	obj["ctimeMs"] = NewDouble(float64(info.ModTime().UnixNano()) / 1e6)
	obj["birthtimeMs"] = NewDouble(float64(info.ModTime().UnixNano()) / 1e6)
	obj["mode"] = NewInteger(int64(info.Mode()))
	obj["_isFile"] = NewBool(!info.IsDir())
	obj["_isDirectory"] = NewBool(info.IsDir())
	vm.jsObjectItems[objID] = obj
	vm.jsPropertyItems[objID] = make(map[string]jsPropertyDescriptor, 12)
	return Value{Type: VTJSObject, Num: objID}
}

// jsCallFSMethod dispatches fs sync methods.
func (vm *VM) jsCallFSMethod(methodName string, args []Value) (Value, bool) {
	switch strings.ToLower(methodName) {
	case "existssync":
		if len(args) < 1 {
			return NewBool(false), true
		}
		resolved, ok := vm.jsNodeResolveSandboxPath(args[0])
		if !ok {
			return NewBool(false), true
		}
		_, err := os.Stat(resolved)
		return NewBool(err == nil), true
	case "readfilesync":
		if len(args) < 1 {
			vm.jsThrowTypeError("fs.readFileSync requires a path")
			return Value{Type: VTJSUndefined}, true
		}
		resolved, ok := vm.jsNodeResolveSandboxPath(args[0])
		if !ok {
			vm.jsThrowTypeError("fs.readFileSync path is outside sandbox")
			return Value{Type: VTJSUndefined}, true
		}
		data, err := os.ReadFile(resolved)
		if err != nil {
			vm.jsThrowTypeError("fs.readFileSync failed: " + err.Error())
			return Value{Type: VTJSUndefined}, true
		}
		encoding := vm.jsNodeExtractEncoding(args, 1)
		if encoding == "" {
			return vm.jsCreateBufferInstance(data), true
		}
		if encoding == "utf8" || encoding == "utf-8" {
			return NewString(string(data)), true
		}
		if encoding == "hex" {
			return NewString(hex.EncodeToString(data)), true
		}
		if encoding == "base64" {
			return NewString(base64.StdEncoding.EncodeToString(data)), true
		}
		vm.jsThrowTypeError("Unsupported encoding: " + encoding)
		return Value{Type: VTJSUndefined}, true
	case "writefilesync":
		if len(args) < 2 {
			vm.jsThrowTypeError("fs.writeFileSync requires path and data")
			return Value{Type: VTJSUndefined}, true
		}
		resolved, ok := vm.jsNodeResolveSandboxPath(args[0])
		if !ok {
			vm.jsThrowTypeError("fs.writeFileSync path is outside sandbox")
			return Value{Type: VTJSUndefined}, true
		}
		encoding := vm.jsNodeExtractEncoding(args, 2)
		data, bytesOK := vm.jsNodeValueBytes(args[1], encoding)
		if !bytesOK {
			vm.jsThrowTypeError("fs.writeFileSync failed to convert data")
			return Value{Type: VTJSUndefined}, true
		}
		if err := os.MkdirAll(filepath.Dir(resolved), 0o755); err != nil {
			vm.jsThrowTypeError("fs.writeFileSync mkdir failed: " + err.Error())
			return Value{Type: VTJSUndefined}, true
		}
		if err := os.WriteFile(resolved, data, 0o644); err != nil {
			vm.jsThrowTypeError("fs.writeFileSync failed: " + err.Error())
			return Value{Type: VTJSUndefined}, true
		}
		return Value{Type: VTJSUndefined}, true
	case "statsync":
		if len(args) < 1 {
			vm.jsThrowTypeError("fs.statSync requires a path")
			return Value{Type: VTJSUndefined}, true
		}
		resolved, ok := vm.jsNodeResolveSandboxPath(args[0])
		if !ok {
			vm.jsThrowTypeError("fs.statSync path is outside sandbox")
			return Value{Type: VTJSUndefined}, true
		}
		info, err := os.Stat(resolved)
		if err != nil {
			vm.jsThrowTypeError("fs.statSync failed: " + err.Error())
			return Value{Type: VTJSUndefined}, true
		}
		return vm.jsCreateFSStatsObject(info), true
	}
	return Value{Type: VTJSUndefined}, false
}

// jsCallFSStatsMethod dispatches fs.Stats instance methods.
func (vm *VM) jsCallFSStatsMethod(target Value, methodName string) (Value, bool) {
	if target.Type != VTJSObject {
		return Value{Type: VTJSUndefined}, false
	}
	switch strings.ToLower(methodName) {
	case "isfile":
		return NewBool(vm.jsNodeObjectBoolProperty(target, "_isFile")), true
	case "isdirectory":
		return NewBool(vm.jsNodeObjectBoolProperty(target, "_isDirectory")), true
	}
	return Value{Type: VTJSUndefined}, false
}

// jsCreateNodeHashStateObject allocates one crypto hash/hmac state object.
func (vm *VM) jsCreateNodeHashStateObject(typeName string, algorithm string, key []byte) Value {
	objID := vm.allocJSID()
	obj := make(map[string]Value, 10)
	obj["__js_type"] = NewString(typeName)
	obj["__js_crypto_algorithm"] = NewString(strings.ToLower(strings.TrimSpace(algorithm)))
	obj["__js_crypto_data"] = NewString("")
	obj["__js_crypto_finalized"] = NewBool(false)
	obj["__js_crypto_key"] = vm.jsCreateBufferInstance(key)
	vm.jsObjectItems[objID] = obj
	vm.jsPropertyItems[objID] = make(map[string]jsPropertyDescriptor, 10)
	return Value{Type: VTJSObject, Num: objID}
}

// jsNodeComputeDigest computes one digest for hash or hmac objects.
func (vm *VM) jsNodeComputeDigest(target Value) ([]byte, bool) {
	obj := vm.jsObjectItems[target.Num]
	if obj == nil {
		return nil, false
	}
	alg := strings.ToLower(strings.TrimSpace(vm.jsObjectStringProperty(target, "__js_crypto_algorithm")))
	data := []byte(vm.jsObjectStringProperty(target, "__js_crypto_data"))
	typeName := vm.jsObjectStringProperty(target, "__js_type")
	if typeName == "crypto.Hmac" {
		keyVal := obj["__js_crypto_key"]
		key, _ := vm.jsNodeValueBytes(keyVal, "")
		switch alg {
		case "sha1":
			h := hmac.New(sha1.New, key)
			_, _ = h.Write(data)
			return h.Sum(nil), true
		case "sha256", "":
			h := hmac.New(sha256.New, key)
			_, _ = h.Write(data)
			return h.Sum(nil), true
		case "md5":
			h := hmac.New(md5.New, key)
			_, _ = h.Write(data)
			return h.Sum(nil), true
		default:
			return nil, false
		}
	}
	switch alg {
	case "md5":
		sum := md5.Sum(data)
		return sum[:], true
	case "sha1":
		sum := sha1.Sum(data)
		return sum[:], true
	case "sha256", "":
		sum := sha256.Sum256(data)
		return sum[:], true
	default:
		return nil, false
	}
}

// jsCallCryptoMethod dispatches top-level crypto module methods.
func (vm *VM) jsCallCryptoMethod(methodName string, args []Value) (Value, bool) {
	switch strings.ToLower(methodName) {
	case "createhash":
		if len(args) < 1 {
			vm.jsThrowTypeError("crypto.createHash requires an algorithm")
			return Value{Type: VTJSUndefined}, true
		}
		alg := strings.ToLower(strings.TrimSpace(vm.valueToString(args[0])))
		if alg != "md5" && alg != "sha1" && alg != "sha256" {
			vm.jsThrowTypeError("Unsupported hash algorithm: " + alg)
			return Value{Type: VTJSUndefined}, true
		}
		return vm.jsCreateNodeHashStateObject("crypto.Hash", alg, nil), true
	case "createhmac":
		if len(args) < 2 {
			vm.jsThrowTypeError("crypto.createHmac requires algorithm and key")
			return Value{Type: VTJSUndefined}, true
		}
		alg := strings.ToLower(strings.TrimSpace(vm.valueToString(args[0])))
		if alg != "md5" && alg != "sha1" && alg != "sha256" {
			vm.jsThrowTypeError("Unsupported hmac algorithm: " + alg)
			return Value{Type: VTJSUndefined}, true
		}
		key, ok := vm.jsNodeValueBytes(args[1], "")
		if !ok {
			vm.jsThrowTypeError("Invalid HMAC key")
			return Value{Type: VTJSUndefined}, true
		}
		return vm.jsCreateNodeHashStateObject("crypto.Hmac", alg, key), true
	case "randombytes":
		if len(args) < 1 {
			vm.jsThrowTypeError("crypto.randomBytes requires size")
			return Value{Type: VTJSUndefined}, true
		}
		size := int(vm.jsToNumber(args[0]).Flt)
		if size < 0 {
			vm.jsThrowRangeError("randomBytes size must be non-negative")
			return Value{Type: VTJSUndefined}, true
		}
		buf := make([]byte, size)
		if _, err := rand.Read(buf); err != nil {
			vm.jsThrowTypeError("crypto.randomBytes failed: " + err.Error())
			return Value{Type: VTJSUndefined}, true
		}
		return vm.jsCreateBufferInstance(buf), true
	}
	return Value{Type: VTJSUndefined}, false
}

// jsCallCryptoHashMethod dispatches methods shared by hash and hmac state objects.
func (vm *VM) jsCallCryptoHashMethod(target Value, methodName string, args []Value) (Value, bool) {
	if target.Type != VTJSObject {
		return Value{Type: VTJSUndefined}, false
	}
	obj := vm.jsObjectItems[target.Num]
	if obj == nil {
		return Value{Type: VTJSUndefined}, false
	}
	switch strings.ToLower(methodName) {
	case "update":
		if vm.jsNodeObjectBoolProperty(target, "__js_crypto_finalized") {
			vm.jsThrowTypeError("Digest already called")
			return Value{Type: VTJSUndefined}, true
		}
		if len(args) < 1 {
			vm.jsThrowTypeError("update requires data")
			return Value{Type: VTJSUndefined}, true
		}
		encoding := ""
		if len(args) > 1 {
			encoding = vm.valueToString(args[1])
		}
		data, ok := vm.jsNodeValueBytes(args[0], encoding)
		if !ok {
			vm.jsThrowTypeError("Invalid update payload")
			return Value{Type: VTJSUndefined}, true
		}
		obj["__js_crypto_data"] = NewString(vm.jsObjectStringProperty(target, "__js_crypto_data") + string(data))
		return target, true
	case "digest":
		if vm.jsNodeObjectBoolProperty(target, "__js_crypto_finalized") {
			vm.jsThrowTypeError("Digest already called")
			return Value{Type: VTJSUndefined}, true
		}
		digest, ok := vm.jsNodeComputeDigest(target)
		if !ok {
			vm.jsThrowTypeError("Unsupported digest algorithm")
			return Value{Type: VTJSUndefined}, true
		}
		obj["__js_crypto_finalized"] = NewBool(true)
		enc := ""
		if len(args) > 0 {
			enc = strings.ToLower(strings.TrimSpace(vm.valueToString(args[0])))
		}
		if enc == "" {
			return vm.jsCreateBufferInstance(digest), true
		}
		if enc == "hex" {
			return NewString(hex.EncodeToString(digest)), true
		}
		if enc == "base64" {
			return NewString(base64.StdEncoding.EncodeToString(digest)), true
		}
		if enc == "latin1" {
			return NewString(string(digest)), true
		}
		vm.jsThrowTypeError("Unsupported digest encoding: " + enc)
		return Value{Type: VTJSUndefined}, true
	}
	return Value{Type: VTJSUndefined}, false
}

// jsNodeReadHeadersObject converts a JS headers object to an HTTP header map.
func (vm *VM) jsNodeReadHeadersObject(v Value) http.Header {
	headers := make(http.Header)
	if v.Type != VTJSObject && v.Type != VTJSFunction {
		return headers
	}
	keys := vm.jsObjectOwnPropertyNames(v)
	for i := 0; i < len(keys); i++ {
		k := keys[i]
		if strings.HasPrefix(k, "__js_") {
			continue
		}
		val, deferred := vm.jsMemberGet(v, k)
		if deferred || val.Type == VTJSUndefined || val.Type == VTNull {
			continue
		}
		headers.Set(k, vm.valueToString(val))
	}
	return headers
}

// jsNodeBuildRequestURL builds a request URL string from Node-like options.
func (vm *VM) jsNodeBuildRequestURL(moduleType string, options Value) string {
	if options.Type == VTString {
		return options.Str
	}
	urlStr := vm.jsNodeGetObjectString(options, "url")
	if urlStr == "" {
		urlStr = vm.jsNodeGetObjectString(options, "href")
	}
	if urlStr != "" {
		if strings.HasPrefix(urlStr, "//") {
			if moduleType == "https" {
				return "https:" + urlStr
			}
			return "http:" + urlStr
		}
		return urlStr
	}

	host := vm.jsNodeGetObjectString(options, "hostname")
	if host == "" {
		host = vm.jsNodeGetObjectString(options, "host")
	}
	if host == "" {
		return ""
	}
	port := vm.jsNodeGetObjectString(options, "port")
	path := vm.jsNodeGetObjectString(options, "path")
	if path == "" {
		path = "/"
	}
	protocol := vm.jsNodeGetObjectString(options, "protocol")
	if protocol == "" {
		if moduleType == "https" {
			protocol = "https:"
		} else {
			protocol = "http:"
		}
	}
	protocol = strings.TrimSuffix(protocol, ":")
	if port != "" {
		host = host + ":" + port
	}
	return protocol + "://" + host + path
}

// jsCreateHTTPResponseObject creates a Node-like incoming message object.
func (vm *VM) jsCreateHTTPResponseObject(resp *http.Response, body []byte) Value {
	headersID := vm.allocJSID()
	headersObj := make(map[string]Value, len(resp.Header)+2)
	headersObj["__js_type"] = NewString("Object")
	for key, values := range resp.Header {
		if len(values) == 0 {
			headersObj[key] = NewString("")
			continue
		}
		headersObj[key] = NewString(values[0])
	}
	vm.jsObjectItems[headersID] = headersObj
	vm.jsPropertyItems[headersID] = make(map[string]jsPropertyDescriptor, len(headersObj)+2)

	objID := vm.allocJSID()
	obj := make(map[string]Value, 12)
	obj["__js_type"] = NewString("http.IncomingMessage")
	obj["statusCode"] = NewInteger(int64(resp.StatusCode))
	obj["statusMessage"] = NewString(resp.Status)
	obj["headers"] = Value{Type: VTJSObject, Num: headersID}
	obj["ok"] = NewBool(resp.StatusCode >= 200 && resp.StatusCode < 300)
	obj["body"] = NewString(string(body))
	vm.jsObjectItems[objID] = obj
	vm.jsPropertyItems[objID] = make(map[string]jsPropertyDescriptor, 12)
	return Value{Type: VTJSObject, Num: objID}
}

// jsNodeDoHTTPRequest executes one HTTP(S) request and returns a response object.
func (vm *VM) jsNodeDoHTTPRequest(moduleType string, method string, args []Value) (Value, bool) {
	if len(args) < 1 {
		vm.jsThrowTypeError(moduleType + ".request requires URL or options")
		return Value{Type: VTJSUndefined}, true
	}

	target := args[0]
	urlStr := vm.jsNodeBuildRequestURL(moduleType, target)
	if urlStr == "" {
		vm.jsThrowTypeError(moduleType + ".request missing URL")
		return Value{Type: VTJSUndefined}, true
	}

	options := Value{Type: VTJSUndefined}
	if target.Type == VTJSObject || target.Type == VTJSFunction {
		options = target
	} else if len(args) > 1 && (args[1].Type == VTJSObject || args[1].Type == VTJSFunction) {
		options = args[1]
	}

	reqMethod := strings.ToUpper(strings.TrimSpace(method))
	if reqMethod == "" {
		reqMethod = strings.ToUpper(strings.TrimSpace(vm.jsNodeGetObjectString(options, "method")))
	}
	if reqMethod == "" {
		reqMethod = "GET"
	}

	bodyBytes := []byte(nil)
	if payload, ok := vm.jsNodeGetObjectValue(options, "body"); ok {
		data, bytesOK := vm.jsNodeValueBytes(payload, "")
		if bytesOK {
			bodyBytes = data
		}
	} else if len(args) > 1 && args[1].Type != VTJSObject && args[1].Type != VTJSFunction {
		data, bytesOK := vm.jsNodeValueBytes(args[1], "")
		if bytesOK {
			bodyBytes = data
		}
	}

	var bodyReader io.Reader
	if len(bodyBytes) > 0 {
		bodyReader = bytes.NewReader(bodyBytes)
	}

	req, err := http.NewRequest(reqMethod, urlStr, bodyReader)
	if err != nil {
		vm.jsThrowTypeError(moduleType + ".request failed: " + err.Error())
		return Value{Type: VTJSUndefined}, true
	}

	if options.Type == VTJSObject || options.Type == VTJSFunction {
		headersVal, ok := vm.jsNodeGetObjectValue(options, "headers")
		if ok {
			headers := vm.jsNodeReadHeadersObject(headersVal)
			for key, vals := range headers {
				for i := 0; i < len(vals); i++ {
					req.Header.Add(key, vals[i])
				}
			}
		}
	}

	if len(bodyBytes) > 0 && req.Header.Get("Content-Type") == "" {
		req.Header.Set("Content-Type", "application/octet-stream")
	}

	timeout := 10 * time.Second
	if options.Type == VTJSObject || options.Type == VTJSFunction {
		timeoutRaw := vm.jsNodeGetObjectString(options, "timeout")
		if timeoutRaw != "" {
			ms, parseErr := strconv.Atoi(timeoutRaw)
			if parseErr == nil && ms > 0 {
				timeout = time.Duration(ms) * time.Millisecond
			}
		}
	}

	client := &http.Client{Timeout: timeout}
	resp, err := client.Do(req)
	if err != nil {
		vm.jsThrowTypeError(moduleType + ".request failed: " + err.Error())
		return Value{Type: VTJSUndefined}, true
	}
	defer resp.Body.Close()

	respBody, err := io.ReadAll(resp.Body)
	if err != nil {
		vm.jsThrowTypeError(moduleType + ".request read failed: " + err.Error())
		return Value{Type: VTJSUndefined}, true
	}

	return vm.jsCreateHTTPResponseObject(resp, respBody), true
}

// jsCallHTTPMethod dispatches http/https module methods.
func (vm *VM) jsCallHTTPMethod(moduleType string, methodName string, args []Value) (Value, bool) {
	switch strings.ToLower(methodName) {
	case "get":
		return vm.jsNodeDoHTTPRequest(moduleType, "GET", args)
	case "request":
		return vm.jsNodeDoHTTPRequest(moduleType, "", args)
	}
	return Value{Type: VTJSUndefined}, false
}

// jsCallHTTPResponseMethod dispatches incoming-message helper methods.
func (vm *VM) jsCallHTTPResponseMethod(target Value, methodName string, _ []Value) (Value, bool) {
	if target.Type != VTJSObject {
		return Value{Type: VTJSUndefined}, false
	}
	switch strings.ToLower(methodName) {
	case "text":
		return NewString(vm.jsObjectStringProperty(target, "body")), true
	case "json":
		jsonLib := &G3JSON{vm: vm}
		parsed := jsonLib.DispatchMethod("Parse", []Value{NewString(vm.jsObjectStringProperty(target, "body"))})
		if parsed.Type == VTEmpty {
			return Value{Type: VTNull}, true
		}
		return parsed, true
	}
	return Value{Type: VTJSUndefined}, false
}
