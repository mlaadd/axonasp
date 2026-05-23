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
	"os"
	"path/filepath"
	"strings"
	"testing"
)

func TestJScriptRegExpES6(t *testing.T) {
	tests := []struct {
		name     string
		script   string
		expected string
	}{
		{
			"Named Capture Groups",
			`var re = /(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})/;
			 var match = re.exec("2026-05-14");
			 Response.Write(match.groups.year + "/" + match.groups.month + "/" + match.groups.day);`,
			"2026/05/14",
		},
		{
			"Lookbehind Assertion",
			`var re = /(?<=\$)\d+/;
			 var match = re.exec("Price is $100");
			 Response.Write(match ? (match.length + ":" + match[0]) : "null");`,
			"1:100",
		},
		{
			"Sticky Flag y",
			`var re = /a/y;
			 re.lastIndex = 1;
			 var m1 = re.exec("ba");
			 Response.Write(m1 ? "match1 " : "no-match1 ");
			 var m2 = re.exec("ba");
			 Response.Write(m2 ? "match2" : "no-match2");`,
			"match1 no-match2",
		},
		{
			"Flags Property",
			`var re = /a/gimuy;
			 Response.Write(re.flags);`,
			"gimuy",
		},
		{
			"String Match Global",
			`var res = "abcabc".match(/a/g);
			 Response.Write(res.length + ":" + res[0] + res[1]);`,
			"2:aa",
		},
		{
			"String Split Regex",
			`var res = "a, b ,c".split(/\s*,\s*/);
			 Response.Write(res.join("|"));`,
			"a|b|c",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			// runJScriptModuleEntry already handles VM setup
			out, err := runJScriptModuleEntry(t, createTempJSFile(t, tt.script))
			if err != nil {
				t.Fatalf("script failed: %v", err)
			}
			if out != tt.expected {
				t.Errorf("expected %q, got %q", tt.expected, out)
			}
		})
	}
}

func createTempJSFile(t *testing.T, content string) string {
	t.Helper()
	path := strings.ReplaceAll(t.Name(), "/", "_") + ".js"
	dir := t.TempDir()
	fpath := filepath.Join(dir, path)
	os.WriteFile(fpath, []byte(content), 0644)
	return fpath
}
