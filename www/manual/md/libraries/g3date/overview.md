# Use the G3DATE Library

## Overview

Use **G3DATE** to perform advanced date and time operations in G3Pix AxonASP, including time zone conversions, ISO 8601 formatting, duration calculations, UNIX epoch handling, and reliable Daylight Saving Time (DST) processing. The library wraps Go's `time` package and exposes its full power through familiar Classic ASP method calls.

## Prerequisites

- Use a running G3Pix AxonASP environment.
- Create the object with the primary ProgID:

```asp
Dim dt
Set dt = Server.CreateObject("G3DATE")
```

## How It Works

- All date values are passed as VBScript Date subtypes (`#YYYY/MM/DD#`) or ISO 8601 strings. The library also accepts UNIX timestamps (seconds or milliseconds) as numeric values.
- Time zones are specified using IANA time zone identifiers (e.g., `"America/New_York"`, `"Europe/London"`, `"Asia/Tokyo"`).
- Duration values are expressed in nanoseconds when using the raw duration methods, or as human-readable strings with `ParseDuration`.
- The system default time zone is loaded from `axonasp.toml` (`global.default_timezone`), falling back to UTC if not configured.

## API Reference

### Methods

The G3DATE library exposes the following method categories:

| Category | Methods |
|---|---|
| **Parsing** | Parse, ParseInLocation, ParseDuration, LoadLocation, FixedZone, Location |
| **Time Zone Conversion** | ConvertUTCtoZone, ConvertZoneToUTC, ConvertSystemToZone, ConvertZoneToZone |
| **Offsets & DST** | OffsetZoneToUTC, OffsetZoneToSystem, OffsetZoneToZone, IsDST, Zone, ZoneBounds, TimezoneAbbreviation |
| **Constructors & Accessors** | Date, Year, Month, Day, Hour, Minute, Second, Weekday, YearDay, ISOWeek, Clock, DateAndClock, Nanosecond |
| **Arithmetic** | Add, AddDate, Sub, Since, Until, After, Before, Equal, Truncate, Round |
| **Duration** | Duration, DurationHours, DurationMinutes, DurationSeconds, DurationMilliseconds, DurationMicroseconds, DurationNanoseconds, DurationAbs, DurationString, DurationRound, DurationTruncate |
| **Formatting** | Format, FormatPad, ToString, GoString, AppendBinary, AppendFormat, AppendText, ISOFormat, RFC822Format, RFC850Format, RFC1123Format, RFC3339Format, RFC3339NanoFormat, KitchenFormat, DateTimeFormat |
| **UNIX Epoch** | Unix, TimeUnix, UnixMicro, UnixMilli |
| **Utility** | Now, UTCNow, In, UTC, Local, IsUTC, IsLocal, IsZero |

### Properties

G3DATE does not expose public properties.

## Example

```asp
<%
Option Explicit
Dim dt, now, converted, dur

Set dt = Server.CreateObject("G3DATE")

' Get current time
now = dt.Now()
Response.Write "Current time: " & now & "<br>"

' Convert UTC to a specific time zone
converted = dt.ConvertUTCtoZone(now, "America/New_York")
Response.Write "New York time: " & converted & "<br>"

' Format as ISO 8601
Response.Write "ISO 8601: " & dt.ISOFormat(now) & "<br>"

' Parse a date string
Dim parsed
parsed = dt.Parse("2006-01-02", "2026-12-25")
Response.Write "Parsed date: " & parsed & "<br>"

' Add 7 days
Dim future
future = dt.AddDate(now, 0, 0, 7)
Response.Write "7 days from now: " & future & "<br>"

' Duration between two dates
Dim durVal
durVal = dt.DateDiff(future, now)
Response.Write "Duration in nanoseconds: " & durVal & "<br>"
Response.Write "Duration in hours: " & dt.DurationHours(durVal) & "<br>"

' UNIX timestamp
Response.Write "UNIX timestamp: " & dt.TimeUnix(now) & "<br>"

Set dt = Nothing
%>
```
