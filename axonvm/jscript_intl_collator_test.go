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

func TestJScriptIntlCollator(t *testing.T) {
	tests := []struct {
		name     string
		script   string
		expected string
	}{
		{
			"Basic sort",
			`
			var collator = new Intl.Collator();
			var arr = ["b", "a", "c"];
			arr.sort(collator.compare);
			Response.Write(arr.join(","));
			`,
			"a,b,c",
		},
		{
			"Case sensitivity",
			`
			var cDefault = new Intl.Collator();
			var cBase = new Intl.Collator("en", { sensitivity: "base" });
			Response.Write(cDefault.compare("a", "A") !== 0 ? "yes" : "no");
			Response.Write(cBase.compare("a", "A") === 0 ? "yes" : "no");
			`,
			"yesyes",
		},
		{
			"Accent sensitivity",
			`
			var cBase = new Intl.Collator("en", { sensitivity: "base" });
			var cAccent = new Intl.Collator("en", { sensitivity: "accent" });
			Response.Write(cBase.compare("a", "á") === 0 ? "yes" : "no");
			Response.Write(cAccent.compare("a", "á") !== 0 ? "yes" : "no");
			`,
			"yesyes",
		},
		{
			"Numeric sort",
			`
			var cNumeric = new Intl.Collator("en", { numeric: true });
			// "10" > "2" numerically
			Response.Write(cNumeric.compare("10", "2") > 0 ? "yes" : "no");
			`,
			"yes",
		},
		{
			"Ignore punctuation",
			`
			var cPunct = new Intl.Collator("en", { ignorePunctuation: true });
			Response.Write(cPunct.compare("a-b", "ab") === 0 ? "yes" : "no");
			`,
			"yes",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			output, err := runJScript2(t, jscriptSrc(tt.script))
			if err != nil {
				t.Fatalf("run error: %v", err)
			}
			if output != tt.expected {
				t.Errorf("expected %q, got %q", tt.expected, output)
			}
		})
	}
}
