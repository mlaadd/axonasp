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

func TestJScriptIntlFormatToParts(t *testing.T) {
	tests := []struct {
		name     string
		script   string
		expected string
	}{
		{
			"DateTimeFormat formatToParts",
			`
			var dtf = new Intl.DateTimeFormat("en-US", { dateStyle: "short" });
			var date = new Date(Date.UTC(2026, 0, 2, 12, 0, 0));
			var parts = dtf.formatToParts(date);
			var res = parts.map(p => p.type + ":" + p.value).join("|");
			Response.Write(res);
			`,
			"month:1|literal:/|day:2|literal:/|year:2026",
		},
		{
			"NumberFormat formatToParts decimal",
			`
			var nf = new Intl.NumberFormat("en-US", { useGrouping: true });
			var parts = nf.formatToParts(12345.67);
			var res = parts.map(p => p.type + ":" + p.value).join("|");
			Response.Write(res);
			`,
			"integer:12|group:,|integer:345|decimal:.|fraction:67",
		},
		{
			"NumberFormat formatToParts currency",
			`
			var nf = new Intl.NumberFormat("en-US", { style: "currency", currency: "USD" });
			var parts = nf.formatToParts(123.45);
			var res = parts.map(p => p.type + ":" + p.value).join("|");
			Response.Write(res);
			`,
			"currency:$|integer:123|decimal:.|fraction:45",
		},
		{
			"NumberFormat formatToParts percent",
			`
			var nf = new Intl.NumberFormat("en-US", { style: "percent", minimumFractionDigits: 2 });
			var parts = nf.formatToParts(0.1234);
			var res = parts.map(p => p.type + ":" + p.value).join("|");
			Response.Write(res);
			`,
			"integer:12|decimal:.|fraction:34|percentSymbol:%",
		},
		{
			"NumberFormat formatToParts negative",
			`
			var nf = new Intl.NumberFormat("en-US", { maximumFractionDigits: 0 });
			var parts = nf.formatToParts(-1);
			var res = parts.map(p => p.type + ":" + p.value).join("|");
			Response.Write(res);
			`,
			"minusSign:-|integer:1",
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
