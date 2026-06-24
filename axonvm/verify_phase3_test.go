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

func TestJScriptPhase3WellKnownSymbols(t *testing.T) {
	tests := []struct {
		name     string
		code     string
		expected string
	}{
		{
			"Symbol.isConcatSpreadable - Array",
			`(function(){ 
				var a = [1, 2];
				var b = [3, 4];
				b[Symbol.isConcatSpreadable] = false;
				var c = a.concat(b);
				return c.length + "|" + c[2].length;
			})()`,
			"3|2",
		},
		{
			"Symbol.isConcatSpreadable - Object",
			`(function(){
				var a = [1, 2];
				var b = { length: 2, 0: 3, 1: 4, [Symbol.isConcatSpreadable]: true };
				var c = a.concat(b);
				return c.join(",");
			})()`,
			"1,2,3,4",
		},
		{
			"Symbol.species - Subclassing",
			`(function(){
				class MyArray extends Array {
					static get [Symbol.species]() { return Array; }
				}
				var a = new MyArray(1, 2, 3);
				var b = a.map(function(x){ return x * 2; });
				var ma_proto = Object.getPrototypeOf(a);
				var b_proto = Object.getPrototypeOf(b);
				return (b instanceof MyArray) + "|" + (b instanceof Array) + "|" + (b_proto === Array.prototype);
			})()`,
			"false|true|true",
		},
		{
			"Symbol.hasInstance",
			`(function(){
				var MyChecker = {
					[Symbol.hasInstance]: function(v) { return v === 42; }
				};
				return (42 instanceof MyChecker) + "|" + (7 instanceof MyChecker);
			})()`,
			"true|false",
		},
		{
			"Symbol.unscopables",
			`(function(){
				var obj = { x: 1, y: 2 };
				obj[Symbol.unscopables] = { x: true };
				var x = 10, y = 20;
				with (obj) {
					return x + "|" + y;
				}
			})()`,
			"10|2",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			out, err := runJScript2(t, jscriptSrc(`Response.Write(`+tt.code+`);`))
			if err != nil {
				t.Fatalf("code %q failed: %v", tt.code, err)
			}
			if out != tt.expected {
				t.Errorf("expected %q, got %q", tt.expected, out)
			}
		})
	}
}
