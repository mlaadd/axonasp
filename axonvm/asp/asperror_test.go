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
package asp

import (
	"testing"
)

// TestASPErrorReset verifies that Reset clears all fields to their default state.
func TestASPErrorReset(t *testing.T) {
	err := NewASPError()
	err.ASPCode = 500
	err.Description = "Internal Error"
	err.Source = "Custom Source"
	err.Line = 10
	err.Column = 5
	err.Category = "Custom Category"

	err.Reset()

	if err.ASPCode != 0 {
		t.Errorf("expected ASPCode 0, got %d", err.ASPCode)
	}
	if err.Description != "" {
		t.Errorf("expected empty Description, got %q", err.Description)
	}
	if err.Source != "ASP" {
		t.Errorf("expected Source \"ASP\", got %q", err.Source)
	}
	if err.Line != 0 {
		t.Errorf("expected Line 0, got %d", err.Line)
	}
	if err.Category != "ASP" {
		t.Errorf("expected Category \"ASP\", got %q", err.Category)
	}
}
