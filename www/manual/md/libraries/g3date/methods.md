# G3DATE Methods

## Overview

This page summarizes every method exposed by `G3DATE` in G3Pix AxonASP.

## Methods

| Method | Returns | Description |
|---|---|---|
| `Parse(layout, value [, timezone])` | Date | Parses a date string using the Go layout format. |
| `ParseInLocation(layout, value [, timezone])` | Date | Parses a date string in the specified timezone. |
| `ParseDuration(duration)` | Integer | Parses a duration string (e.g., "2h45m") to nanoseconds. |
| `LoadLocation(timezone)` | String | Validates and returns a timezone name, or Empty on failure. |
| `FixedZone(offset [, name])` | String | Creates a fixed offset timezone and returns its name. |
| `Location()` | String | Returns the IANA name of the system default timezone. |
| `ConvertUTCtoZone(date, targetZone)` | Date | Converts a UTC date to the target timezone. |
| `ConvertZoneToUTC(date, sourceZone)` | Date | Converts a date from source timezone to UTC. |
| `ConvertSystemToZone(date, targetZone)` | Date | Converts a date from system timezone to target. |
| `ConvertZoneToZone(date, sourceZone, targetZone)` | Date | Converts a date from one timezone to another. |
| `OffsetZoneToUTC(targetZone)` | Integer | Gets the offset in seconds from the timezone to UTC. |
| `OffsetZoneToSystem(targetZone)` | Integer | Gets the offset in seconds from timezone to system. |
| `OffsetZoneToZone(sourceZone, targetZone)` | Integer | Gets the offset in seconds between two timezones. |
| `IsDST(date)` | Boolean | Checks if DST is active for the given date. |
| `Zone(date)` | Array | Returns [timezoneName, offsetSeconds]. |
| `ZoneBounds(date)` | Array | Returns [start, end] of the current zone bounds. |
| `TimezoneAbbreviation(date)` | String | Returns the timezone abbreviation (e.g., "EST"). |
| `Date(year, month, day [, hour, min, sec, nsec, tz])` | Date | Constructs a date from components. |
| `Year(date)` | Integer | Returns the year component. |
| `Month(date)` | Integer | Returns the month component (1-12). |
| `Day(date)` | Integer | Returns the day component (1-31). |
| `Hour(date)` | Integer | Returns the hour component (0-23). |
| `Minute(date)` | Integer | Returns the minute component (0-59). |
| `Second(date)` | Integer | Returns the second component (0-59). |
| `Weekday(date)` | Integer | Returns the weekday (0=Sunday, 6=Saturday). |
| `YearDay(date)` | Integer | Returns the day of the year (1-366). |
| `ISOWeek(date)` | Integer | Returns year*1000 + ISO week number. |
| `Clock(date)` | Array | Returns [hour, minute, second]. |
| `DateAndClock(date)` | Array | Returns [year, month, day, hour, minute, second]. |
| `Nanosecond(date)` | Integer | Returns the nanosecond component. |
| `Add(date, nanoseconds)` | Date | Adds a duration to a date. |
| `AddDate(date, years, months, days)` | Date | Adds years, months, days to a date. |
| `DateDiff(date1, date2)` | Integer | Returns the difference in nanoseconds (date1 - date2). |
| `Since(date)` | Integer | Returns nanoseconds since the given date. |
| `Until(date)` | Integer | Returns nanoseconds until the given date. |
| `After(date1, date2)` | Boolean | True if date1 is after date2. |
| `Before(date1, date2)` | Boolean | True if date1 is before date2. |
| `Equal(date1, date2)` | Boolean | True if dates represent the same instant. |
| `Truncate(date, nanoseconds)` | Date | Truncates time to the given duration. |
| `Round(date, nanoseconds)` | Date | Rounds time to the given duration. |
| `Duration(nanoseconds)` | Integer | Creates a duration value from nanoseconds. |
| `DurationHours(duration)` | Double | Returns duration as hours. |
| `DurationMinutes(duration)` | Double | Returns duration as minutes. |
| `DurationSeconds(duration)` | Double | Returns duration as seconds. |
| `DurationMilliseconds(duration)` | Integer | Returns duration as milliseconds. |
| `DurationMicroseconds(duration)` | Integer | Returns duration as microseconds. |
| `DurationNanoseconds(duration)` | Integer | Returns duration as nanoseconds. |
| `DurationAbs(duration)` | Integer | Returns the absolute value of a duration. |
| `DurationString(duration)` | String | Returns the string representation of a duration. |
| `DurationRound(duration, roundDur)` | Integer | Rounds a duration to the given multiple. |
| `DurationTruncate(duration, truncDur)` | Integer | Truncates a duration to the given multiple. |
| `Format(date, layout)` | String | Formats a date using the Go layout. |
| `FormatPad(date, layout)` | String | Formats a date with zero-padded fields. |
| `ToString(date)` | String | Returns the default string representation. |
| `GoString(date)` | String | Returns the Go-syntax representation. |
| `AppendBinary(date)` | String | Returns binary encoding of the date. |
| `AppendFormat(date, layout)` | String | Appends formatted text to a buffer. |
| `AppendText(date, layout)` | String | Returns text representation. |
| `ISOFormat(date)` | String | Returns RFC 3339 / ISO 8601 format. |
| `RFC822Format(date)` | String | Returns RFC 822 format. |
| `RFC850Format(date)` | String | Returns RFC 850 format. |
| `RFC1123Format(date)` | String | Returns RFC 1123 format. |
| `RFC3339Format(date)` | String | Returns RFC 3339 format. |
| `RFC3339NanoFormat(date)` | String | Returns RFC 3339 with nanoseconds. |
| `KitchenFormat(date)` | String | Returns kitchen time format. |
| `DateTimeFormat(date)` | String | Returns "2006-01-02 15:04:05" format. |
| `Unix(sec, nsec)` | Date | Creates a date from UNIX timestamp. |
| `TimeUnix(date)` | Integer | Returns UNIX timestamp in seconds. |
| `UnixMicro(date)` | Integer or Date | Returns UNIX microseconds or creates date from microseconds. |
| `UnixMilli(date)` | Integer or Date | Returns UNIX milliseconds or creates date from milliseconds. |
| `Now()` | Date | Returns the current system date and time. |
| `UTCNow()` | Date | Returns the current UTC date and time. |
| `In(date, timezone)` | Date | Converts date to the specified timezone. |
| `UTC(date)` | Date | Converts date to UTC. |
| `Local(date)` | Date | Converts date to local time. |
| `IsUTC(date)` | Boolean | Checks if the date is in UTC. |
| `IsLocal(date)` | Boolean | Checks if the date is in local time. |
| `IsZero(date)` | Boolean | Checks if the date is the zero value. |

## Remarks

- Instantiate the library with `Server.CreateObject("G3DATE")`.
- Method names are case-insensitive.
- Date arguments can be VBScript Date subtype, ISO 8601 strings, or UNIX timestamps.
- Timezone names must be valid IANA time zone database identifiers.
- Duration values are in nanoseconds unless otherwise noted.
