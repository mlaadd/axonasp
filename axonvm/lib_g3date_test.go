//go:build !wasm && !lib_g3date_disabled

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
	"time"
)

func TestG3DateNewObject(t *testing.T) {
	vm := NewVM(nil, nil, 0)
	vm.host = NewMockHost()

	dateLib := vm.newG3DateObject()
	if dateLib.Type != VTNativeObject {
		t.Fatalf("expected VTNativeObject, got %v", dateLib.Type)
	}

	obj := vm.g3dateItems[dateLib.Num]
	if obj == nil {
		t.Fatal("expected object in vm items")
	}
}

func TestG3DateNow(t *testing.T) {
	vm := NewVM(nil, nil, 0)
	vm.host = NewMockHost()
	obj := vm.g3dateItems[vm.newG3DateObject().Num]

	now := obj.DispatchMethod("Now", nil)
	if now.Type != VTDate {
		t.Fatalf("expected VTDate, got %v", now.Type)
	}
	nowTime := time.Unix(0, now.Num).UTC()
	if nowTime.IsZero() {
		t.Fatal("expected non-zero time")
	}
}

func TestG3DateUTCNow(t *testing.T) {
	vm := NewVM(nil, nil, 0)
	vm.host = NewMockHost()
	obj := vm.g3dateItems[vm.newG3DateObject().Num]

	now := obj.DispatchMethod("UTCNow", nil)
	if now.Type != VTDate {
		t.Fatalf("expected VTDate, got %v", now.Type)
	}
}

func TestG3DateParse(t *testing.T) {
	vm := NewVM(nil, nil, 0)
	vm.host = NewMockHost()
	obj := vm.g3dateItems[vm.newG3DateObject().Num]

	parsed := obj.DispatchMethod("Parse", []Value{
		NewString("2006-01-02"),
		NewString("2026-12-25"),
	})
	if parsed.Type != VTDate {
		t.Fatalf("expected VTDate, got %v", parsed.Type)
	}
	tm := time.Unix(0, parsed.Num).UTC()
	if tm.Year() != 2026 || tm.Month() != 12 || tm.Day() != 25 {
		t.Errorf("unexpected date: %v", tm)
	}
}

func TestG3DateParseDuration(t *testing.T) {
	vm := NewVM(nil, nil, 0)
	vm.host = NewMockHost()
	obj := vm.g3dateItems[vm.newG3DateObject().Num]

	dur := obj.DispatchMethod("ParseDuration", []Value{NewString("2h30m")})
	if dur.Type != VTInteger {
		t.Fatalf("expected VTInteger, got %v", dur.Type)
	}
	expected := int64(2*time.Hour + 30*time.Minute)
	if dur.Num != expected {
		t.Errorf("expected %d ns, got %d", expected, dur.Num)
	}
}

func TestG3DateYearMonthDay(t *testing.T) {
	vm := NewVM(nil, nil, 0)
	vm.host = NewMockHost()
	obj := vm.g3dateItems[vm.newG3DateObject().Num]

	date := NewDate(time.Date(2026, 6, 15, 10, 30, 0, 0, time.UTC))

	year := obj.DispatchMethod("Year", []Value{date})
	if year.Num != 2026 {
		t.Errorf("expected year 2026, got %d", year.Num)
	}

	month := obj.DispatchMethod("Month", []Value{date})
	if month.Num != 6 {
		t.Errorf("expected month 6, got %d", month.Num)
	}

	day := obj.DispatchMethod("Day", []Value{date})
	if day.Num != 15 {
		t.Errorf("expected day 15, got %d", day.Num)
	}
}

func TestG3DateAddDate(t *testing.T) {
	vm := NewVM(nil, nil, 0)
	vm.host = NewMockHost()
	obj := vm.g3dateItems[vm.newG3DateObject().Num]

	base := NewDate(time.Date(2026, 1, 1, 0, 0, 0, 0, time.UTC))
	result := obj.DispatchMethod("AddDate", []Value{base, NewInteger(1), NewInteger(2), NewInteger(10)})
	if result.Type != VTDate {
		t.Fatalf("expected VTDate, got %v", result.Type)
	}
	tm := time.Unix(0, result.Num).UTC()
	if tm.Year() != 2027 || tm.Month() != 3 || tm.Day() != 11 {
		t.Errorf("expected 2027-03-11, got %v", tm)
	}
}

func TestG3DateConvertUTCtoZone(t *testing.T) {
	vm := NewVM(nil, nil, 0)
	vm.host = NewMockHost()
	obj := vm.g3dateItems[vm.newG3DateObject().Num]

	// Create a fixed UTC date
	utcDate := NewDate(time.Date(2026, 6, 15, 12, 0, 0, 0, time.UTC))
	result := obj.DispatchMethod("ConvertUTCtoZone", []Value{utcDate, NewString("America/New_York")})
	if result.Type != VTDate {
		t.Fatalf("expected VTDate, got %v", result.Type)
	}
	// The result should be the same instant as the input (VTDate is always UTC instant)
	tm := time.Unix(0, result.Num).UTC()
	if !tm.Equal(time.Date(2026, 6, 15, 12, 0, 0, 0, time.UTC)) {
		t.Errorf("expected same instant, got %v", tm)
	}
	// Verify the instant is preserved
	iso := obj.DispatchMethod("ISOFormat", []Value{result})
	if iso.Str != "2026-06-15T12:00:00Z" {
		t.Errorf("expected 2026-06-15T12:00:00Z, got '%s'", iso.Str)
	}
}

func TestG3DateFormat(t *testing.T) {
	vm := NewVM(nil, nil, 0)
	vm.host = NewMockHost()
	obj := vm.g3dateItems[vm.newG3DateObject().Num]

	date := NewDate(time.Date(2026, 6, 15, 10, 30, 45, 0, time.UTC))
	result := obj.DispatchMethod("Format", []Value{date, NewString("2006-01-02 15:04:05")})
	if result.Type != VTString {
		t.Fatalf("expected VTString, got %v", result.Type)
	}
	if result.Str != "2026-06-15 10:30:45" {
		t.Errorf("expected '2026-06-15 10:30:45', got '%s'", result.Str)
	}
}

func TestG3DateISOFormat(t *testing.T) {
	vm := NewVM(nil, nil, 0)
	vm.host = NewMockHost()
	obj := vm.g3dateItems[vm.newG3DateObject().Num]

	date := NewDate(time.Date(2026, 6, 15, 10, 30, 45, 0, time.UTC))
	result := obj.DispatchMethod("ISOFormat", []Value{date})
	if result.Type != VTString {
		t.Fatalf("expected VTString, got %v", result.Type)
	}
	if result.Str != "2026-06-15T10:30:45Z" {
		t.Errorf("expected '2026-06-15T10:30:45Z', got '%s'", result.Str)
	}
}

func TestG3DateUnixTimestamp(t *testing.T) {
	vm := NewVM(nil, nil, 0)
	vm.host = NewMockHost()
	obj := vm.g3dateItems[vm.newG3DateObject().Num]

	// Create a date from Unix timestamp
	ts := int64(1763257845) // some test timestamp
	date := obj.DispatchMethod("Unix", []Value{NewInteger(ts), NewInteger(0)})
	if date.Type != VTDate {
		t.Fatalf("expected VTDate, got %v", date.Type)
	}

	// Convert back to Unix
	back := obj.DispatchMethod("TimeUnix", []Value{date})
	if back.Type != VTInteger {
		t.Fatalf("expected VTInteger, got %v", back.Type)
	}
	if back.Num != ts {
		t.Errorf("expected %d, got %d", ts, back.Num)
	}
}

func TestG3DateSub(t *testing.T) {
	vm := NewVM(nil, nil, 0)
	vm.host = NewMockHost()
	obj := vm.g3dateItems[vm.newG3DateObject().Num]

	t1 := NewDate(time.Date(2026, 6, 15, 12, 0, 0, 0, time.UTC))
	t2 := NewDate(time.Date(2026, 6, 14, 12, 0, 0, 0, time.UTC))

	diff := obj.DispatchMethod("DateDiff", []Value{t1, t2})
	if diff.Type != VTInteger {
		t.Fatalf("expected VTInteger, got %v", diff.Type)
	}
	expected := int64(24 * time.Hour)
	if diff.Num != expected {
		t.Errorf("expected %d ns, got %d", expected, diff.Num)
	}
}

func TestG3DateAfterBefore(t *testing.T) {
	vm := NewVM(nil, nil, 0)
	vm.host = NewMockHost()
	obj := vm.g3dateItems[vm.newG3DateObject().Num]

	t1 := NewDate(time.Date(2026, 6, 15, 12, 0, 0, 0, time.UTC))
	t2 := NewDate(time.Date(2026, 6, 14, 12, 0, 0, 0, time.UTC))

	after := obj.DispatchMethod("After", []Value{t1, t2})
	if after.Type != VTBool || after.Num != 1 {
		t.Errorf("expected true (1), got %v", after)
	}

	before := obj.DispatchMethod("Before", []Value{t1, t2})
	if before.Type != VTBool || before.Num != 0 {
		t.Errorf("expected false (0), got %v", before)
	}
}

func TestG3DateDurationMethods(t *testing.T) {
	vm := NewVM(nil, nil, 0)
	vm.host = NewMockHost()
	obj := vm.g3dateItems[vm.newG3DateObject().Num]

	durNS := int64(2*time.Hour + 30*time.Minute) // 2h30m in nanoseconds

	hours := obj.DispatchMethod("DurationHours", []Value{NewInteger(durNS)})
	if hours.Type != VTDouble {
		t.Fatalf("expected VTDouble, got %v", hours.Type)
	}
	if hours.Flt != 2.5 {
		t.Errorf("expected 2.5, got %f", hours.Flt)
	}

	mins := obj.DispatchMethod("DurationMinutes", []Value{NewInteger(durNS)})
	if mins.Type != VTDouble || mins.Flt != 150.0 {
		t.Errorf("expected 150 minutes, got %f", mins.Flt)
	}

	durStr := obj.DispatchMethod("DurationString", []Value{NewInteger(durNS)})
	if durStr.Type != VTString {
		t.Fatalf("expected VTString, got %v", durStr.Type)
	}
	if durStr.Str != "2h30m0s" {
		t.Errorf("expected '2h30m0s', got '%s'", durStr.Str)
	}
}

func TestG3DateZone(t *testing.T) {
	vm := NewVM(nil, nil, 0)
	vm.host = NewMockHost()
	obj := vm.g3dateItems[vm.newG3DateObject().Num]

	date := NewDate(time.Date(2026, 6, 15, 12, 0, 0, 0, time.UTC))
	zone := obj.DispatchMethod("Zone", []Value{date})
	if zone.Type != VTArray {
		t.Fatalf("expected VTArray, got %v", zone.Type)
	}
	if zone.Arr == nil || len(zone.Arr.Values) < 2 {
		t.Fatal("expected array with 2 elements")
	}
	if zone.Arr.Values[0].Str != "UTC" {
		t.Errorf("expected 'UTC', got '%s'", zone.Arr.Values[0].Str)
	}
}

func TestG3DateIsDST(t *testing.T) {
	vm := NewVM(nil, nil, 0)
	vm.host = NewMockHost()
	obj := vm.g3dateItems[vm.newG3DateObject().Num]

	// UTC has no DST
	utcDate := NewDate(time.Date(2026, 6, 15, 12, 0, 0, 0, time.UTC))
	dst := obj.DispatchMethod("IsDST", []Value{utcDate})
	// In UTC, janOffset == julOffset, so IsDST should return false
	if dst.Type != VTBool {
		t.Fatalf("expected VTBool, got %v", dst.Type)
	}
}

func TestG3DateClock(t *testing.T) {
	vm := NewVM(nil, nil, 0)
	vm.host = NewMockHost()
	obj := vm.g3dateItems[vm.newG3DateObject().Num]

	date := NewDate(time.Date(2026, 6, 15, 10, 30, 45, 0, time.UTC))
	clock := obj.DispatchMethod("Clock", []Value{date})
	if clock.Type != VTArray || clock.Arr == nil || len(clock.Arr.Values) != 3 {
		t.Fatalf("expected array with 3 elements")
	}
	if clock.Arr.Values[0].Num != 10 || clock.Arr.Values[1].Num != 30 || clock.Arr.Values[2].Num != 45 {
		t.Errorf("expected [10,30,45], got [%d,%d,%d]", clock.Arr.Values[0].Num, clock.Arr.Values[1].Num, clock.Arr.Values[2].Num)
	}
}

func TestG3DateOffsetZoneToUTC(t *testing.T) {
	vm := NewVM(nil, nil, 0)
	vm.host = NewMockHost()
	obj := vm.g3dateItems[vm.newG3DateObject().Num]

	offset := obj.DispatchMethod("OffsetZoneToUTC", []Value{NewString("UTC")})
	if offset.Type != VTInteger {
		t.Fatalf("expected VTInteger, got %v", offset.Type)
	}
	if offset.Num != 0 {
		t.Errorf("expected offset 0 for UTC, got %d", offset.Num)
	}
}

func TestG3DateInUTC(t *testing.T) {
	vm := NewVM(nil, nil, 0)
	vm.host = NewMockHost()
	obj := vm.g3dateItems[vm.newG3DateObject().Num]

	date := NewDate(time.Date(2026, 6, 15, 12, 0, 0, 0, time.UTC))
	utc := obj.DispatchMethod("UTC", []Value{date})
	if utc.Type != VTDate {
		t.Fatalf("expected VTDate, got %v", utc.Type)
	}
}

func TestG3DateIsZero(t *testing.T) {
	vm := NewVM(nil, nil, 0)
	vm.host = NewMockHost()
	obj := vm.g3dateItems[vm.newG3DateObject().Num]

	// A non-zero date should not be zero
	nonZero := NewDate(time.Now())
	isNotZero := obj.DispatchMethod("IsZero", []Value{nonZero})
	if isNotZero.Type != VTBool || isNotZero.Num != 0 {
		t.Errorf("expected false for non-zero date, got Num=%d", isNotZero.Num)
	}
}

func TestG3DateDateTimeFormat(t *testing.T) {
	vm := NewVM(nil, nil, 0)
	vm.host = NewMockHost()
	obj := vm.g3dateItems[vm.newG3DateObject().Num]

	date := NewDate(time.Date(2026, 6, 15, 10, 30, 45, 0, time.UTC))
	result := obj.DispatchMethod("DateTimeFormat", []Value{date})
	if result.Type != VTString {
		t.Fatalf("expected VTString, got %v", result.Type)
	}
	if result.Str != "2026-06-15 10:30:45" {
		t.Errorf("expected '2026-06-15 10:30:45', got '%s'", result.Str)
	}
}

func TestG3DateLoadLocation(t *testing.T) {
	vm := NewVM(nil, nil, 0)
	vm.host = NewMockHost()
	obj := vm.g3dateItems[vm.newG3DateObject().Num]

	loc := obj.DispatchMethod("LoadLocation", []Value{NewString("America/New_York")})
	if loc.Type != VTString {
		t.Fatalf("expected VTString, got %v", loc.Type)
	}
	if loc.Str != "America/New_York" {
		t.Errorf("expected 'America/New_York', got '%s'", loc.Str)
	}

	// Invalid location should return Empty
	invalid := obj.DispatchMethod("LoadLocation", []Value{NewString("Invalid/Zone")})
	if invalid.Type != VTEmpty {
		t.Errorf("expected VTEmpty for invalid location, got %v", invalid.Type)
	}
}

func TestG3DateConvertZoneToZone(t *testing.T) {
	vm := NewVM(nil, nil, 0)
	vm.host = NewMockHost()
	obj := vm.g3dateItems[vm.newG3DateObject().Num]

	date := NewDate(time.Date(2026, 6, 15, 12, 0, 0, 0, time.UTC))
	result := obj.DispatchMethod("ConvertZoneToZone", []Value{
		date,
		NewString("America/New_York"),
		NewString("Europe/London"),
	})
	if result.Type != VTDate {
		t.Fatalf("expected VTDate, got %v", result.Type)
	}
}

func TestG3DateDispatchPropertyGet(t *testing.T) {
	vm := NewVM(nil, nil, 0)
	vm.host = NewMockHost()
	obj := vm.g3dateItems[vm.newG3DateObject().Num]

	// Property get should route to method dispatch
	result := obj.DispatchPropertyGet("Now")
	if result.Type != VTDate {
		t.Fatalf("expected VTDate via property get, got %v", result.Type)
	}
}
