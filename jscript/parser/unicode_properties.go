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
package parser

import (
	"fmt"
	"strings"
	"unicode"
)

// UnicodePropertyExpander expands Unicode property escapes like \p{Letter} to character classes.
type UnicodePropertyExpander struct {
	properties map[string]string
}

// NewUnicodePropertyExpander creates a new expander with built-in Unicode properties.
func NewUnicodePropertyExpander() *UnicodePropertyExpander {
	return &UnicodePropertyExpander{
		properties: getUnicodeProperties(),
	}
}

// ExpandProperty expands a Unicode property name to a character class.
func (e *UnicodePropertyExpander) ExpandProperty(propertyName string, negate bool) (string, error) {
	normalized := normalizePropertyName(propertyName)
	classContent, exists := e.properties[normalized]
	if !exists {
		return "", fmt.Errorf("unknown Unicode property: %s", propertyName)
	}

	if strings.HasPrefix(classContent, `\p{`) {
		if negate {
			return `\P{` + classContent[3:], nil
		}
		return classContent, nil
	}

	if negate {
		return "[^" + classContent + "]", nil
	}
	return "[" + classContent + "]", nil
}

// normalizePropertyName normalizes a property name.
func normalizePropertyName(name string) string {
	name = strings.ToLower(name)
	name = strings.ReplaceAll(name, "_", "")
	name = strings.ReplaceAll(name, "-", "")
	return name
}

// getUnicodeProperties returns the map of Unicode properties.
func getUnicodeProperties() map[string]string {
	props := make(map[string]string)

	// Use Unicode category shorthands so the generated patterns are compatible
	// with both RE2 and regexp2 backends.
	props["letter"] = `\p{L}`
	props["l"] = `\p{L}`

	props["uppercase"] = `\p{Lu}`
	props["lu"] = `\p{Lu}`

	props["lowercase"] = `\p{Ll}`
	props["ll"] = `\p{Ll}`

	props["mark"] = `\p{M}`
	props["m"] = `\p{M}`

	props["number"] = `\p{N}`
	props["n"] = `\p{N}`
	props["numeric"] = `\p{N}`

	props["punctuation"] = `\p{P}`
	props["p"] = `\p{P}`

	props["symbol"] = `\p{S}`
	props["s"] = `\p{S}`

	props["separator"] = `\p{Z}`
	props["space"] = `\p{Z}`
	props["z"] = `\p{Z}`
	props["zs"] = `\p{Zs}`

	props["other"] = `\p{C}`
	props["c"] = `\p{C}`

	// Derived properties
	props["ascii"] = "\\x{0}-\\x{7F}"
	props["alphabetic"] = `\p{L}`
	props["whitespace"] = buildWhitespaceClass()

	return props
}

// rangeTableToClass converts a unicode RangeTable to a regex character class.
func rangeTableToClass(table *unicode.RangeTable) string {
	if table == nil {
		return ""
	}

	var ranges []string

	// Process 16-bit ranges
	for _, r16 := range table.R16 {
		if r16.Lo == r16.Hi {
			ranges = append(ranges, escapeRune(rune(r16.Lo)))
		} else {
			ranges = append(ranges, escapeRune(rune(r16.Lo))+"-"+escapeRune(rune(r16.Hi)))
		}
	}

	// Process 32-bit ranges
	for _, r32 := range table.R32 {
		if r32.Lo == r32.Hi {
			ranges = append(ranges, escapeRune(rune(r32.Lo)))
		} else {
			ranges = append(ranges, escapeRune(rune(r32.Lo))+"-"+escapeRune(rune(r32.Hi)))
		}
	}

	return strings.Join(ranges, "")
}

// escapeRune escapes a single rune for use in a regex character class.
func escapeRune(ch rune) string {
	switch ch {
	case '\\', ']', '^', '-':
		return "\\" + string(ch)
	case '\n':
		return "\\n"
	case '\r':
		return "\\r"
	case '\t':
		return "\\t"
	default:
		if ch < 32 || ch == 127 || ch > 127 {
			return fmt.Sprintf("\\x{%X}", ch)
		}
		return string(ch)
	}
}

// buildWhitespaceClass builds a character class for whitespace.
func buildWhitespaceClass() string {
	chars := []rune{
		'\t', '\n', '\v', '\f', '\r',
		' ', 0x00A0, 0x1680, 0x2000, 0x2001,
		0x2002, 0x2003, 0x2004, 0x2005, 0x2006,
		0x2007, 0x2008, 0x2009, 0x200A, 0x202F,
		0x205F, 0x3000, 0x2028, 0x2029, 0xFEFF,
	}

	var ranges []string
	for _, ch := range chars {
		ranges = append(ranges, escapeRune(ch))
	}
	return strings.Join(ranges, "")
}
