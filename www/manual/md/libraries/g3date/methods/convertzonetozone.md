# Convert Between Two Timezones

## Overview

Converts a date from one source timezone to another target timezone.

## Syntax

```asp
result = g3date.ConvertZoneToZone(date, sourceZone, targetZone)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | A date value in the source timezone. |
| **sourceZone** | String | Yes | IANA timezone identifier of the source. |
| **targetZone** | String | Yes | IANA timezone identifier of the target. |

## Return Value

Returns a **Date** value representing the same instant in the target timezone.

## Remarks

- Both timezone names must be valid IANA identifiers.
- DST adjustments are automatically applied for both zones.
- The time components of the input date are interpreted as being in the source timezone.

## Example

```asp
<%
Option Explicit
Dim dt, nyTime, tokyoTime
Set dt = Server.CreateObject("G3DATE")
nyTime = dt.Now()
tokyoTime = dt.ConvertZoneToZone(nyTime, "America/New_York", "Asia/Tokyo")
Response.Write "Tokyo time: " & tokyoTime
Set dt = Nothing
%>
```
