# Get Zone Boundary Times

## Overview

Returns the start and end times of the zone's daylight saving time boundary for the year.

## Syntax

```asp
arr = g3date.ZoneBounds(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value (year is used for DST calculation). |

## Return Value

Returns an **Array** with two Date elements: `[zoneStart, zoneEnd]` representing the DST transition boundaries.

## Remarks

- The boundaries represent when DST starts and ends for the given year.
- For timezones without DST, the start and end may be the same.

## Example

```asp
<%
Option Explicit
Dim dt, arr
Set dt = Server.CreateObject("G3DATE")
arr = dt.ZoneBounds(dt.Now())
Response.Write "DST start: " & arr(0) & ", DST end: " & arr(1)
Set dt = Nothing
%>
```
