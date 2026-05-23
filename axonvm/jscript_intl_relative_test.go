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

func TestJScriptIntlRelativeTimeFormat(t *testing.T) {
	tests := []struct {
		name     string
		script   string
		expected string
	}{
		{
			"English basic past",
			`
			var rtf = new Intl.RelativeTimeFormat("en");
			Response.Write(rtf.format(-1, "day") + "," + rtf.format(-2, "day"));
			`,
			"1 day ago,2 days ago",
		},
		{
			"English basic future",
			`
			var rtf = new Intl.RelativeTimeFormat("en");
			Response.Write(rtf.format(1, "day") + "," + rtf.format(2, "day"));
			`,
			"in 1 day,in 2 days",
		},
		{
			"Portuguese basic past",
			`
			var rtf = new Intl.RelativeTimeFormat("pt");
			Response.Write(rtf.format(-1, "dia") + "," + rtf.format(-2, "dia"));
			`,
			"há 1 dia,há 2 dias",
		},
		{
			"Portuguese basic future",
			`
			var rtf = new Intl.RelativeTimeFormat("pt");
			Response.Write(rtf.format(1, "dia") + "," + rtf.format(2, "dia"));
			`,
			"em 1 dia,em 2 dias",
		},
		{
			"Numeric auto English",
			`
			var rtf = new Intl.RelativeTimeFormat("en", { numeric: "auto" });
			Response.Write(rtf.format(-1, "day") + "," + rtf.format(0, "day") + "," + rtf.format(1, "day"));
			`,
			"yesterday,now,tomorrow",
		},
		{
			"Numeric auto Portuguese",
			`
			var rtf = new Intl.RelativeTimeFormat("pt", { numeric: "auto" });
			Response.Write(rtf.format(-1, "day") + "," + rtf.format(0, "day") + "," + rtf.format(1, "day"));
			`,
			"ontem,agora,amanhã",
		},
		{
			"FormatToParts English",
			`
			var rtf = new Intl.RelativeTimeFormat("en");
			var parts = rtf.formatToParts(-1, "day");
			var res = "";
			for(var i=0; i<parts.length; i++) {
				res += parts[i].type + ":" + parts[i].value + "|";
			}
			Response.Write(res);
			`,
			"integer:1|literal: day|literal: ago|",
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
