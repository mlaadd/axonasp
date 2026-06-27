# Add a Duration to a Date

## Overview

Adds a duration in nanoseconds to a date value and returns the resulting date.

## Syntax

```asp
result = g3date.Add(date, nanoseconds)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The base date. |
| **nanoseconds** | Integer | Yes | Duration to add in nanoseconds (negative to subtract). |

## Return Value

Returns a **Date** value advanced (or moved back) by the specified duration.

## Remarks

- Use `ParseDuration` to convert human-readable strings like "2h30m" to nanoseconds.
- For adding calendar units (years, months, days), use `AddDate` instead.

## Example

```asp
<%
Option Explicit
Dim dt, now, later
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
' Add 2 hours (7200000000000 ns)
later = dt.Add(now, 7200000000000)
Response.Write "Two hours from now: " & later
Set dt = Nothing
%>
```
