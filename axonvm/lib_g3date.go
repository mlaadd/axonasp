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
	"strings"
	"time"
)

// G3Date implements the G3DATE library for advanced date/time conversions,
// time zones, UTC, ISO 8601, and DST processing.
type G3Date struct {
	vm *VM
}

// newG3DateObject instantiates the G3DATE library.
func (vm *VM) newG3DateObject() Value {
	obj := &G3Date{vm: vm}
	id := vm.nextDynamicNativeID
	vm.nextDynamicNativeID++
	vm.g3dateItems[id] = obj
	return Value{Type: VTNativeObject, Num: id}
}

// DispatchPropertyGet routes property access to method aliases.
func (d *G3Date) DispatchPropertyGet(propertyName string) Value {
	return d.DispatchMethod(propertyName, nil)
}

// DispatchMethod provides O(1) string matching for all G3DATE methods.
func (d *G3Date) DispatchMethod(methodName string, args []Value) Value {
	funcLower := strings.ToLower(methodName)

	switch funcLower {

	// --- Parsing & Core Functions ---

	case "parse":
		// Go time.Parse wrapper. Expects layout + value strings.
		if len(args) < 2 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "Parse requires layout and value arguments")
		}
		layout := args[0].String()
		value := args[1].String()
		loc := time.UTC
		if len(args) >= 3 {
			loc = d.resolveLocation(args[2].String())
		}
		t, err := time.ParseInLocation(layout, value, loc)
		if err != nil {
			return d.raiseErr(ErrG3DateParseError, err.Error())
		}
		return NewDate(t)

	case "parseinlocation":
		if len(args) < 2 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "ParseInLocation requires layout, value arguments")
		}
		layout := args[0].String()
		value := args[1].String()
		loc := d.resolveLocation("")
		if len(args) >= 3 {
			loc = d.resolveLocation(args[2].String())
		}
		t, err := time.ParseInLocation(layout, value, loc)
		if err != nil {
			return d.raiseErr(ErrG3DateParseError, err.Error())
		}
		return NewDate(t)

	case "parseduration":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "ParseDuration requires a duration string")
		}
		dur, err := time.ParseDuration(args[0].String())
		if err != nil {
			return d.raiseErr(ErrG3DateInvalidDuration, err.Error())
		}
		return NewInteger(int64(dur))

	case "loadlocation":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "LoadLocation requires a timezone name")
		}
		loc, err := time.LoadLocation(args[0].String())
		if err != nil {
			return NewEmpty()
		}
		return NewString(loc.String())

	case "fixedzone":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "FixedZone requires an offset in seconds")
		}
		name := ""
		if len(args) >= 2 {
			name = args[1].String()
		}
		offset := int(d.asInt64(args[0]))
		loc := time.FixedZone(name, offset)
		return NewString(loc.String())

	case "location":
		// Returns the IANA name of the system/default location.
		return NewString(d.systemLocation().String())

	// --- Time Zone Conversions ---

	case "convertutctozone":
		if len(args) < 2 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "ConvertUTCtoZone requires date and targetZone")
		}
		t := d.toTime(args[0])
		targetZone := d.resolveLocation(args[1].String())
		return NewDate(t.In(targetZone))

	case "convertzonetoutc":
		if len(args) < 2 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "ConvertZoneToUTC requires date and sourceZone")
		}
		t := d.toTime(args[0])
		sourceZone := d.resolveLocation(args[1].String())
		// Interpret the time as being in sourceZone, then convert to UTC.
		// We need to rebuild the time in the source location.
		year, month, day := t.Date()
		hour, min, sec := t.Clock()
		locT := time.Date(year, month, day, hour, min, sec, t.Nanosecond(), sourceZone)
		return NewDate(locT.UTC())

	case "convertsystemtozone":
		if len(args) < 2 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "ConvertSystemToZone requires date and targetZone")
		}
		t := d.toTime(args[0])
		targetZone := d.resolveLocation(args[1].String())
		return NewDate(t.In(targetZone))

	case "convertzonetozone":
		if len(args) < 3 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "ConvertZoneToZone requires date, sourceZone, targetZone")
		}
		t := d.toTime(args[0])
		sourceZone := d.resolveLocation(args[1].String())
		targetZone := d.resolveLocation(args[2].String())
		// Interpret t in sourceZone and convert to targetZone.
		year, month, day := t.Date()
		hour, min, sec := t.Clock()
		locT := time.Date(year, month, day, hour, min, sec, t.Nanosecond(), sourceZone)
		return NewDate(locT.In(targetZone))

	// --- Offsets & DST ---

	case "offsetzonetoutc":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "OffsetZoneToUTC requires targetZone")
		}
		targetZone := d.resolveLocation(args[0].String())
		_, offset := time.Now().In(targetZone).Zone()
		return NewInteger(int64(offset))

	case "offsetzonetosystem":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "OffsetZoneToSystem requires targetZone")
		}
		targetZone := d.resolveLocation(args[0].String())
		sysLoc := d.systemLocation()
		now := time.Now()
		_, targetOff := now.In(targetZone).Zone()
		_, sysOff := now.In(sysLoc).Zone()
		return NewInteger(int64(sysOff - targetOff))

	case "offsetzonetozone":
		if len(args) < 2 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "OffsetZoneToZone requires sourceZone and targetZone")
		}
		sourceZone := d.resolveLocation(args[0].String())
		targetZone := d.resolveLocation(args[1].String())
		now := time.Now()
		_, srcOff := now.In(sourceZone).Zone()
		_, tgtOff := now.In(targetZone).Zone()
		return NewInteger(int64(tgtOff - srcOff))

	// --- Go Time Constructors & Accessors ---

	case "date":
		if len(args) < 3 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "Date requires year, month, day")
		}
		year := int(d.asInt64(args[0]))
		month := time.Month(d.asInt64(args[1]))
		day := int(d.asInt64(args[2]))
		hour := 0
		min := 0
		sec := 0
		nsec := 0
		if len(args) >= 4 {
			hour = int(d.asInt64(args[3]))
		}
		if len(args) >= 5 {
			min = int(d.asInt64(args[4]))
		}
		if len(args) >= 6 {
			sec = int(d.asInt64(args[5]))
		}
		if len(args) >= 7 {
			nsec = int(d.asInt64(args[6]))
		}
		loc := d.systemLocation()
		if len(args) >= 8 {
			loc = d.resolveLocation(args[7].String())
		}
		t := time.Date(year, month, day, hour, min, sec, nsec, loc)
		return NewDate(t)

	case "year":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "Year requires a date argument")
		}
		return NewInteger(int64(d.toTime(args[0]).Year()))

	case "month":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "Month requires a date argument")
		}
		return NewInteger(int64(d.toTime(args[0]).Month()))

	case "day":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "Day requires a date argument")
		}
		return NewInteger(int64(d.toTime(args[0]).Day()))

	case "hour":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "Hour requires a date argument")
		}
		return NewInteger(int64(d.toTime(args[0]).Hour()))

	case "minute":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "Minute requires a date argument")
		}
		return NewInteger(int64(d.toTime(args[0]).Minute()))

	case "second":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "Second requires a date argument")
		}
		return NewInteger(int64(d.toTime(args[0]).Second()))

	case "weekday":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "Weekday requires a date argument")
		}
		return NewInteger(int64(d.toTime(args[0]).Weekday()))

	case "yearday":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "YearDay requires a date argument")
		}
		return NewInteger(int64(d.toTime(args[0]).YearDay()))

	case "isoweek":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "ISOWeek requires a date argument")
		}
		year, week := d.toTime(args[0]).ISOWeek()
		return NewInteger(int64(year*1000 + week))

	case "clock":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "Clock requires a date argument")
		}
		h, m, s := d.toTime(args[0]).Clock()
		// Return as array [hour, minute, second]
		return Value{Type: VTArray, Arr: NewVBArrayFromValues(0, []Value{
			NewInteger(int64(h)),
			NewInteger(int64(m)),
			NewInteger(int64(s)),
		})}

	case "dateandclock":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "DateAndClock requires a date argument")
		}
		t := d.toTime(args[0])
		y, m, day := t.Date()
		h, min, s := t.Clock()
		// Return as array [year, month, day, hour, minute, second]
		return Value{Type: VTArray, Arr: NewVBArrayFromValues(0, []Value{
			NewInteger(int64(y)),
			NewInteger(int64(m)),
			NewInteger(int64(day)),
			NewInteger(int64(h)),
			NewInteger(int64(min)),
			NewInteger(int64(s)),
		})}

	// --- Time. ---

	case "add":
		if len(args) < 2 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "Add requires date and duration (in nanoseconds)")
		}
		t := d.toTime(args[0])
		dur := time.Duration(d.asInt64(args[1]))
		return NewDate(t.Add(dur))

	case "adddate":
		if len(args) < 4 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "AddDate requires date, years, months, days")
		}
		t := d.toTime(args[0])
		years := int(d.asInt64(args[1]))
		months := int(d.asInt64(args[2]))
		days := int(d.asInt64(args[3]))
		return NewDate(t.AddDate(years, months, days))

	case "datediff":
		if len(args) < 2 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "DateDiff requires two date arguments")
		}
		t1 := d.toTime(args[0])
		t2 := d.toTime(args[1])
		return NewInteger(int64(t1.Sub(t2)))

	case "since":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "Since requires a date argument")
		}
		t := d.toTime(args[0])
		return NewInteger(int64(time.Since(t)))

	case "until":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "Until requires a date argument")
		}
		t := d.toTime(args[0])
		return NewInteger(int64(time.Until(t)))

	case "after":
		if len(args) < 2 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "After requires two date arguments")
		}
		t1 := d.toTime(args[0])
		t2 := d.toTime(args[1])
		return NewBool(t1.After(t2))

	case "before":
		if len(args) < 2 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "Before requires two date arguments")
		}
		t1 := d.toTime(args[0])
		t2 := d.toTime(args[1])
		return NewBool(t1.Before(t2))

	case "equal":
		if len(args) < 2 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "Equal requires two date arguments")
		}
		t1 := d.toTime(args[0])
		t2 := d.toTime(args[1])
		return NewBool(t1.Equal(t2))

	case "truncate":
		if len(args) < 2 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "Truncate requires a date and duration (nanoseconds)")
		}
		t := d.toTime(args[0])
		dur := time.Duration(d.asInt64(args[1]))
		return NewDate(t.Truncate(dur))

	case "round":
		if len(args) < 2 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "Round requires a date and duration (nanoseconds)")
		}
		t := d.toTime(args[0])
		dur := time.Duration(d.asInt64(args[1]))
		return NewDate(t.Round(dur))

	// --- Duration Handling ---

	case "duration":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "Duration requires nanoseconds")
		}
		return NewInteger(int64(time.Duration(d.asInt64(args[0]))))

	case "durationhours":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "DurationHours requires a duration (nanoseconds)")
		}
		dur := time.Duration(d.asInt64(args[0]))
		return NewDouble(dur.Hours())

	case "durationminutes":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "DurationMinutes requires a duration (nanoseconds)")
		}
		dur := time.Duration(d.asInt64(args[0]))
		return NewDouble(dur.Minutes())

	case "durationseconds":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "DurationSeconds requires a duration (nanoseconds)")
		}
		dur := time.Duration(d.asInt64(args[0]))
		return NewDouble(dur.Seconds())

	case "durationmilliseconds":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "DurationMilliseconds requires a duration (nanoseconds)")
		}
		dur := time.Duration(d.asInt64(args[0]))
		return NewInteger(int64(dur.Milliseconds()))

	case "durationmicroseconds":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "DurationMicroseconds requires a duration (nanoseconds)")
		}
		dur := time.Duration(d.asInt64(args[0]))
		return NewInteger(int64(dur.Microseconds()))

	case "durationnanoseconds":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "DurationNanoseconds requires a duration (nanoseconds)")
		}
		dur := time.Duration(d.asInt64(args[0]))
		return NewInteger(int64(dur.Nanoseconds()))

	case "durationabs":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "DurationAbs requires a duration (nanoseconds)")
		}
		dur := time.Duration(d.asInt64(args[0]))
		return NewInteger(int64(dur.Abs()))

	case "durationstring":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "DurationString requires a duration (nanoseconds)")
		}
		dur := time.Duration(d.asInt64(args[0]))
		return NewString(dur.String())

	case "durationround":
		if len(args) < 2 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "DurationRound requires duration (nanoseconds) and rounding duration")
		}
		dur := time.Duration(d.asInt64(args[0]))
		roundDur := time.Duration(d.asInt64(args[1]))
		return NewInteger(int64(dur.Round(roundDur)))

	case "durationtruncate":
		if len(args) < 2 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "DurationTruncate requires duration (nanoseconds) and truncation duration")
		}
		dur := time.Duration(d.asInt64(args[0]))
		truncDur := time.Duration(d.asInt64(args[1]))
		return NewInteger(int64(dur.Truncate(truncDur)))

	// --- Formatting ---

	case "format":
		if len(args) < 2 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "Format requires a date and layout")
		}
		t := d.toTime(args[0])
		layout := args[1].String()
		return NewString(t.Format(layout))

	case "formatpad":
		if len(args) < 2 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "FormatPad requires a date and layout")
		}
		t := d.toTime(args[0])
		layout := args[1].String()
		return NewString(d.formatPad(t, layout))

	case "tostring":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "ToString requires a date argument")
		}
		t := d.toTime(args[0])
		return NewString(t.String())

	case "gostring":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "GoString requires a date argument")
		}
		t := d.toTime(args[0])
		return NewString(t.GoString())

	case "appendbinary":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "AppendBinary requires a date argument")
		}
		t := d.toTime(args[0])
		b, err := t.AppendBinary(make([]byte, 0, 15))
		if err != nil {
			return NewString("")
		}
		return NewString(string(b))

	case "appendformat":
		if len(args) < 2 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "AppendFormat requires a date and layout")
		}
		t := d.toTime(args[0])
		layout := args[1].String()
		b := make([]byte, 0, 64)
		b = t.AppendFormat(b, layout)
		return NewString(string(b))

	case "appendtext":
		if len(args) < 2 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "AppendText requires a date and layout")
		}
		t := d.toTime(args[0])
		layout := args[1].String()
		b, err := t.AppendText([]byte(layout))
		if err != nil {
			return NewString("")
		}
		return NewString(string(b))

	case "isoformat":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "ISOFormat requires a date argument")
		}
		t := d.toTime(args[0])
		return NewString(t.Format(time.RFC3339))

	case "rfc822format":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "RFC822Format requires a date argument")
		}
		t := d.toTime(args[0])
		return NewString(t.Format(time.RFC822))

	case "rfc850format":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "RFC850Format requires a date argument")
		}
		t := d.toTime(args[0])
		return NewString(t.Format(time.RFC850))

	case "rfc1123format":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "RFC1123Format requires a date argument")
		}
		t := d.toTime(args[0])
		return NewString(t.Format(time.RFC1123))

	case "rfc3339format":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "RFC3339Format requires a date argument")
		}
		t := d.toTime(args[0])
		return NewString(t.Format(time.RFC3339))

	case "rfc3339nanoformat":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "RFC3339NanoFormat requires a date argument")
		}
		t := d.toTime(args[0])
		return NewString(t.Format(time.RFC3339Nano))

	case "kitchenformat":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "KitchenFormat requires a date argument")
		}
		t := d.toTime(args[0])
		return NewString(t.Format(time.Kitchen))

	case "datetimeformat":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "DateTimeFormat requires a date argument")
		}
		t := d.toTime(args[0])
		return NewString(t.Format("2006-01-02 15:04:05"))

	// --- UNIX Epoch Functions ---

	case "unix":
		if len(args) < 2 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "Unix requires sec and nsec")
		}
		sec := d.asInt64(args[0])
		nsec := d.asInt64(args[1])
		return NewDate(time.Unix(sec, nsec))

	case "timeunix":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "TimeUnix requires a date argument")
		}
		t := d.toTime(args[0])
		return NewInteger(t.Unix())

	case "unixmicro":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "UnixMicro requires a date argument")
		}
		if len(args) >= 1 {
			t := d.toTime(args[0])
			return NewInteger(t.UnixMicro())
		}
		sec := d.asInt64(args[0])
		return NewDate(time.UnixMicro(sec))

	case "unixmilli":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "UnixMilli requires a date argument")
		}
		if len(args) >= 1 {
			t := d.toTime(args[0])
			return NewInteger(t.UnixMilli())
		}
		sec := d.asInt64(args[0])
		return NewDate(time.UnixMilli(sec))

	// --- Utility & Now ---

	case "now":
		return NewDate(time.Now())

	case "utcnow":
		return NewDate(time.Now().UTC())

	case "isutc":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "IsUTC requires a date argument")
		}
		t := d.toTime(args[0])
		loc := t.Location()
		if loc == nil {
			return NewBool(false)
		}
		return NewBool(loc.String() == "UTC")

	case "islocal":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "IsLocal requires a date argument")
		}
		t := d.toTime(args[0])
		loc := t.Location()
		if loc == nil {
			return NewBool(false)
		}
		return NewBool(loc.String() == "Local")

	case "iszero":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "IsZero requires a date argument")
		}
		t := d.toTime(args[0])
		return NewBool(t.IsZero())

	case "in":
		if len(args) < 2 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "In requires a date and timezone")
		}
		t := d.toTime(args[0])
		loc := d.resolveLocation(args[1].String())
		return NewDate(t.In(loc))

	case "utc":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "UTC requires a date argument")
		}
		t := d.toTime(args[0])
		return NewDate(t.UTC())

	case "local":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "Local requires a date argument")
		}
		t := d.toTime(args[0])
		return NewDate(t.Local())

	case "zone":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "Zone requires a date argument")
		}
		t := d.toTime(args[0])
		name, offset := t.Zone()
		// Return array [name, offset]
		return Value{Type: VTArray, Arr: NewVBArrayFromValues(0, []Value{
			NewString(name),
			NewInteger(int64(offset)),
		})}

	case "zonebounds":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "ZoneBounds requires a date argument")
		}
		t := d.toTime(args[0])
		start, end := t.ZoneBounds()
		return Value{Type: VTArray, Arr: NewVBArrayFromValues(0, []Value{
			NewDate(start),
			NewDate(end),
		})}

	case "isdst":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "IsDST requires a date argument")
		}
		t := d.toTime(args[0])
		_, offset := t.Zone()
		_, janOffset := time.Date(t.Year(), 1, 1, 0, 0, 0, 0, t.Location()).Zone()
		_, julOffset := time.Date(t.Year(), 7, 1, 0, 0, 0, 0, t.Location()).Zone()
		// DST is active if the offset differs between January and July.
		return NewBool(janOffset != julOffset && offset != janOffset)

	case "nanosecond":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "Nanosecond requires a date argument")
		}
		return NewInteger(int64(d.toTime(args[0]).Nanosecond()))

	case "timezoneabbreviation":
		if len(args) < 1 {
			return d.raiseErr(ErrG3DateInvalidArgCount, "TimezoneAbbreviation requires a date argument")
		}
		t := d.toTime(args[0])
		name, _ := t.Zone()
		return NewString(name)

	}

	return NewEmpty()
}

// toTime converts a VM Value to Go time.Time.
func (d *G3Date) toTime(v Value) time.Time {
	switch v.Type {
	case VTDate:
		return time.Unix(0, v.Num).UTC()
	case VTString:
		// Try common ASP date literal formats
		s := strings.TrimSpace(v.Str)
		// Try ASP #YYYY/MM/DD# or #MM/DD/YYYY# format (already stripped by lexer, but handle string input)
		formats := []string{
			"2006/01/02",
			"2006-01-02",
			"2006-01-02 15:04:05",
			"2006/01/02 15:04:05",
			time.RFC3339,
			time.RFC1123,
			"Jan 2, 2006",
			"January 2, 2006",
			"02-Jan-2006",
			"2006-01-02T15:04:05Z07:00",
		}
		for _, layout := range formats {
			if t, err := time.ParseInLocation(layout, s, d.systemLocation()); err == nil {
				return t
			}
		}
		// Try parsing as Unix timestamp (seconds or milliseconds)
		if t, err := parseUnixTimestamp(s); err == nil {
			return t
		}
		return time.Time{}
	case VTInteger:
		return time.Unix(v.Num, 0).UTC()
	case VTDouble:
		sec := int64(v.Flt)
		nsec := int64((v.Flt - float64(sec)) * 1e9)
		return time.Unix(sec, nsec).UTC()
	default:
		return time.Time{}
	}
}

// parseUnixTimestamp tries to parse a numeric string as a Unix timestamp.
func parseUnixTimestamp(s string) (time.Time, error) {
	// Try parsing as integer (seconds or milliseconds)
	var val int64
	var isMilli bool
	for _, c := range s {
		if c < '0' || c > '9' {
			return time.Time{}, nil // not a numeric string
		}
	}
	// Determine if it's seconds or milliseconds based on length
	if len(s) > 10 {
		// Likely milliseconds (13 digits) or microseconds (16 digits)
		val = 0
		for _, c := range s {
			val = val*10 + int64(c-'0')
		}
		if len(s) >= 13 {
			isMilli = true
		}
	} else {
		for _, c := range s {
			val = val*10 + int64(c-'0')
		}
	}

	if isMilli {
		return time.UnixMilli(val).UTC(), nil
	}
	return time.Unix(val, 0).UTC(), nil
}

// formatPad formats a time with zero-padded fields for consistent output.
func (d *G3Date) formatPad(t time.Time, layout string) string {
	// Replace common Go layout tokens with zero-padded equivalents
	result := layout
	result = strings.ReplaceAll(result, "1", "01")
	result = strings.ReplaceAll(result, "2", "02")
	result = strings.ReplaceAll(result, "3", "03")
	result = strings.ReplaceAll(result, "4", "04")
	result = strings.ReplaceAll(result, "5", "05")
	result = strings.ReplaceAll(result, "6", "06")
	return t.Format(result)
}

// asInt64 safely converts a VM Value to int64.
func (d *G3Date) asInt64(v Value) int64 {
	switch v.Type {
	case VTInteger:
		return v.Num
	case VTDouble:
		return int64(v.Flt)
	case VTString:
		parsed, err := g3dateParseInt64(v.Str)
		if err == nil {
			return parsed
		}
		return 0
	case VTBool:
		if v.Num != 0 {
			return 1
		}
		return 0
	case VTDate:
		return v.Num
	default:
		return 0
	}
}

// g3dateParseInt64 parses an integer string in a locale-independent way.
func g3dateParseInt64(s string) (int64, error) {
	s = strings.TrimSpace(s)
	if s == "" {
		return 0, nil
	}
	var neg bool
	if s[0] == '-' {
		neg = true
		s = s[1:]
	}
	var val int64
	for _, c := range s {
		if c < '0' || c > '9' {
			return 0, nil
		}
		val = val*10 + int64(c-'0')
	}
	if neg {
		val = -val
	}
	return val, nil
}

// resolveLocation resolves a timezone name to *time.Location.
func (d *G3Date) resolveLocation(name string) *time.Location {
	name = strings.TrimSpace(name)
	if name == "" {
		return d.systemLocation()
	}
	loc, err := time.LoadLocation(name)
	if err != nil {
		// Fallback to system location on error.
		return d.systemLocation()
	}
	return loc
}

// systemLocation returns the system default timezone from configuration.
func (d *G3Date) systemLocation() *time.Location {
	return builtinCurrentLocation(d.vm)
}

// raiseErr raises an AxonASP error with the given code and description.
func (d *G3Date) raiseErr(code AxonASPErrorCode, desc string) Value {
	if d.vm != nil {
		panic(d.vm.newMappedAxonASPError(code, nil, desc))
	}
	return Value{Type: VTEmpty}
}
