//go:build wasm || lib_g3mail_disabled

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
	"strings"
)

// G3Mail is the disabled stub for the G3Mail library.
type G3Mail struct{}

func (vm *VM) newG3MailObject() Value {
	panicLibraryDisabled("g3mail", "G3Mail library")
	return Value{Type: VTEmpty}
}

func (vm *VM) newG3MailObjectWithProgID(progID string) Value {
	panicLibraryDisabled("g3mail", "G3Mail library")
	return Value{Type: VTEmpty}
}

func (m *G3Mail) DispatchPropertyGet(propertyName string) Value {
	switch strings.ToLower(propertyName) {
	case "htmlbody", "remotehost", "fromaddress", "bodytext", "contenttype", "charset":
		return Value{Type: VTEmpty}
	}
	return Value{Type: VTEmpty}
}

func (m *G3Mail) DispatchPropertySet(propertyName string, args []Value) bool {
	switch strings.ToLower(propertyName) {
	case "htmlbody", "remotehost", "fromaddress", "bodytext", "contenttype", "charset":
		return false
	}
	return false
}

func (m *G3Mail) DispatchMethod(methodName string, args []Value) Value {
	switch strings.ToLower(methodName) {
	case "addrelatedbodypart", "addattachment", "addrecipient", "addreplyto", "sendmail", "clearaddresses", "clearrecipients", "clearcc", "clearccs", "clearbcc", "clearbccs", "clearattachments":
		return Value{Type: VTEmpty}
	}
	return Value{Type: VTEmpty}
}
