# Parse a Date String Using Go Layout

## Overview

Parses a date string using the specified Go time layout and returns a date value.

## Syntax

```asp
result = g3date.Parse(layout, value [, timezone])
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **layout** | String | Yes | Go time layout string (e.g., "2006-01-02"). |
| **value** | String | Yes | The date string to parse. |
| **timezone** | String | No | IANA timezone name for interpretation (default: UTC). |

## Return Value

Returns a **Date** value representing the parsed date, or raises an error on parse failure.

## Remarks

- The layout parameter must follow Go's reference time format: `Mon Jan 2 15:04:05 MST 2006`.
- If no timezone is specified, the string is parsed as UTC.
- Common layouts: `"2006-01-02"`, `"2006-01-02 15:04:05"`, `time.RFC3339`.

## Example

```asp
<%
Option Explicit
Dim dt, parsed
Set dt = Server.CreateObject("G3DATE")
parsed = dt.Parse("2006-01-02", "2026-12-25")
Response.Write "Parsed date: " & parsed
Set dt = Nothing
%>
```
