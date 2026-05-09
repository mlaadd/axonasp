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
 */
package axonvm

import (
	"bytes"
	"testing"
)

// jscriptSrc wraps raw JScript source in the ASP server-side script tag.
func jscriptSrc(src string) string {
	return `<script runat="server" language="JScript">` + src + `</script>`
}

// runJScript2 compiles and runs a JScript ASP source string, returning
// (output, runError). Compile errors are returned as non-nil runError.
func runJScript2(t *testing.T, aspSrc string) (string, error) {
	t.Helper()

	compiler := NewASPCompiler(aspSrc)
	if err := compiler.Compile(); err != nil {
		return "", err
	}

	vm := NewVM(compiler.Bytecode(), compiler.Constants(), compiler.GlobalsCount())
	host := NewMockHost()
	var output bytes.Buffer
	host.SetOutput(&output)
	host.Response().SetBuffer(false)
	vm.SetHost(host)

	if err := vm.Run(); err != nil {
		return output.String(), err
	}

	return output.String(), nil
}
