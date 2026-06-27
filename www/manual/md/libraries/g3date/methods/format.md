# Format a Date Using Go Layout

## Overview

Formats a date value into a string using a Go time layout pattern.

## Syntax

```asp
result = g3date.Format(date, layout)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date to format. |
| **layout** | String | Yes | Go time layout string (e.g., "2006-01-02 15:04:05"). |

## Return Value

Returns a **String** containing the formatted date.

## Remarks

- Go uses reference time `Mon Jan 2 15:04:05 MST 2006` for layout patterns.
- Common layouts: `"2006-01-02"` (date), `"15:04:05"` (time), `"2006-01-02 15:04:05"` (datetime).
- For RFC 3339 formatting, use the ISOFormat method instead.

## Example

```asp
<%
Option Explicit
Dim dt, now
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
Response.Write dt.Format(now, "2006-01-02 15:04:05")
Set dt = Nothing
%>
```
