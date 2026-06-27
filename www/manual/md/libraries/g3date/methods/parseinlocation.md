# Parse a Date String in a Specific Timezone

## Overview

Parses a date string in the specified timezone location using a Go layout pattern.

## Syntax

```asp
result = g3date.ParseInLocation(layout, value [, timezone])
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **layout** | String | Yes | Go time layout string (e.g., "2006-01-02 15:04:05"). |
| **value** | String | Yes | The date string to parse. |
| **timezone** | String | No | IANA timezone name (default: system timezone). |

## Return Value

Returns a **Date** value representing the parsed date in the specified location.

## Remarks

- The layout uses Go reference time `Mon Jan 2 15:04:05 MST 2006`.
- Differences from Parse: the default location is the system timezone instead of UTC.
- This method is useful when the input string assumes a specific timezone context.

## Example

```asp
<%
Option Explicit
Dim dt, parsed
Set dt = Server.CreateObject("G3DATE")
parsed = dt.ParseInLocation("2006-01-02 15:04:05", "2026-12-25 10:30:00", "America/New_York")
Response.Write "Parsed date: " & parsed
Set dt = Nothing
%>
```
