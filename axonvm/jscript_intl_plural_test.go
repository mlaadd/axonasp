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
	"testing"
)

func TestJScriptIntlPluralRules(t *testing.T) {
	tests := []struct {
		name     string
		script   string
		expected string
	}{
		{
			"English cardinal",
			`
			var pr = new Intl.PluralRules("en");
			Response.Write(pr.select(0) + "," + pr.select(1) + "," + pr.select(2));
			`,
			"other,one,other",
		},
		{
			"French cardinal",
			`
			var pr = new Intl.PluralRules("fr");
			Response.Write(pr.select(0) + "," + pr.select(1) + "," + pr.select(1.5) + "," + pr.select(2));
			`,
			"one,one,one,other",
		},
		{
			"Polish cardinal",
			`
			var pr = new Intl.PluralRules("pl");
			Response.Write(pr.select(1) + "," + pr.select(2) + "," + pr.select(5));
			`,
			"one,few,many",
		},
		{
			"English ordinal",
			`
			var pr = new Intl.PluralRules("en", { type: "ordinal" });
			Response.Write(pr.select(1) + "," + pr.select(2) + "," + pr.select(3) + "," + pr.select(4) + "," + pr.select(11));
			`,
			"one,two,few,other,other",
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
