/*
 * AxonASP Server
 * Copyright (C) 2026 G3pix Ltda. All rights reserved.
 *
 * Developed by Lucas Guimarães - G3pix Ltda
 * Contact: https://g3pix.com.br
 * Project URL: https://g3pix.com.br/axonasp
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */
package axonvm

import (
	"strings"
	"testing"
)

func TestJScriptProxyErrors(t *testing.T) {
	tests := []struct {
		name     string
		code     string
		expected string // Expected error message fragment
	}{
		{
			"Proxy target not object",
			`try { new Proxy(1, {}); } catch(e) { Response.Write(e.message); }`,
			"Proxy target or handler must be an object",
		},
		{
			"Proxy handler not object",
			`try { new Proxy({}, 1); } catch(e) { Response.Write(e.message); }`,
			"Proxy target or handler must be an object",
		},
		{
			"Reflect.get non-object",
			`try { Reflect.get(1, "a"); } catch(e) { Response.Write(e.message); }`,
			"Reflect argument must be an object",
		},
		{
			"Reflect.set non-object",
			`try { Reflect.set(1, "a", 2); } catch(e) { Response.Write(e.message); }`,
			"Reflect argument must be an object",
		},
		{
			"Reflect.has non-object",
			`try { Reflect.has(1, "a"); } catch(e) { Response.Write(e.message); }`,
			"Reflect argument must be an object",
		},
		{
			"Reflect.defineProperty non-object",
			`try { Reflect.defineProperty(1, "a", {}); } catch(e) { Response.Write(e.message); }`,
			"Reflect argument must be an object",
		},
		{
			"Reflect.getOwnPropertyDescriptor non-object",
			`try { Reflect.getOwnPropertyDescriptor(1, "a"); } catch(e) { Response.Write(e.message); }`,
			"Reflect argument must be an object",
		},
		{
			"Reflect.getPrototypeOf non-object",
			`try { Reflect.getPrototypeOf(1); } catch(e) { Response.Write(e.message); }`,
			"Reflect argument must be an object",
		},
		{
			"Reflect.setPrototypeOf non-object",
			`try { Reflect.setPrototypeOf(1, {}); } catch(e) { Response.Write(e.message); }`,
			"Reflect argument must be an object",
		},
		{
			"Reflect.isExtensible non-object",
			`try { Reflect.isExtensible(1); } catch(e) { Response.Write(e.message); }`,
			"Reflect argument must be an object",
		},
		{
			"Reflect.preventExtensions non-object",
			`try { Reflect.preventExtensions(1); } catch(e) { Response.Write(e.message); }`,
			"Reflect argument must be an object",
		},
		{
			"Reflect.ownKeys non-object",
			`try { Reflect.ownKeys(1); } catch(e) { Response.Write(e.message); }`,
			"Reflect argument must be an object",
		},
		{
			"Reflect.deleteProperty non-object",
			`try { Reflect.deleteProperty(1, "a"); } catch(e) { Response.Write(e.message); }`,
			"Reflect argument must be an object",
		},
		{
			"Proxy revoked get",
			`var r = Proxy.revocable({}, {}); r.revoke(); try { r.proxy.a; } catch(e) { Response.Write(e.message); }`,
			"Cannot perform operation on a revoked proxy",
		},
		{
			"Proxy construct invalid return",
			`var p = new Proxy(function(){}, { construct: function() { return 1; } }); try { new p(); } catch(e) { Response.Write(e.message); }`,
			"Proxy trap returned an invalid value",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			out, err := runJScript2(t, jscriptSrc(tt.code))
			if err != nil {
				t.Fatalf("unexpected error: %v", err)
			}
			if !strings.Contains(out, tt.expected) {
				t.Errorf("expected error message containing %q, got %q", tt.expected, out)
			}
		})
	}
}
