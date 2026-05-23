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
	"testing"
)

func TestJScriptSharedArrayBuffer(t *testing.T) {
	tests := []struct {
		name     string
		script   string
		expected string
	}{
		{
			"SharedArrayBuffer creation",
			`var sab = new SharedArrayBuffer(10); Response.Write(sab.byteLength);`,
			"10",
		},
		{
			"SharedArrayBuffer slice",
			`var sab = new SharedArrayBuffer(10); 
			 var sab2 = sab.slice(2, 5); 
			 Response.Write(sab2.byteLength);`,
			"3",
		},
		{
			"Uint8Array over SharedArrayBuffer",
			`var sab = new SharedArrayBuffer(4);
			 var u8 = new Uint8Array(sab);
			 u8[0] = 42;
			 Response.Write(u8[0]);`,
			"42",
		},
		{
			"DataView over SharedArrayBuffer",
			`var sab = new SharedArrayBuffer(4);
			 var dv = new DataView(sab);
			 dv.setUint8(0, 255);
			 Response.Write(dv.getUint8(0));`,
			"255",
		},
		{
			"ArrayBuffer.isView with SharedArrayBuffer views",
			`var sab = new SharedArrayBuffer(4);
			 var u8 = new Uint8Array(sab);
			 Response.Write(ArrayBuffer.isView(u8));`,
			"True",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got, err := runJScript2(t, jscriptSrc(tt.script))
			if err != nil {
				t.Fatalf("script failed: %v", err)
			}
			if got != tt.expected {
				t.Errorf("expected %q, got %q", tt.expected, got)
			}
		})
	}
}
