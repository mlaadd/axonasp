# Convert Date from Source Timezone to UTC

## Overview

Converts a date from a specified source timezone to UTC.

## Syntax

```asp
result = g3date.ConvertZoneToUTC(date, sourceZone)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | A date value in the source timezone. |
| **sourceZone** | String | Yes | IANA timezone identifier of the source (e.g., "America/New_York"). |

## Return Value

Returns a **Date** value converted to UTC.

## Remarks

- The time components of the input date are interpreted as being in the source timezone.
- DST adjustments are automatically applied.

## Example

```asp
<%
Option Explicit
Dim dt, nyTime, utcTime
Set dt = Server.CreateObject("G3DATE")
nyTime = dt.Now()
utcTime = dt.ConvertZoneToUTC(nyTime, "America/New_York")
Response.Write "UTC time: " & utcTime
Set dt = Nothing
%>
```
