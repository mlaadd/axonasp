# Convert System Time to a Target Timezone

## Overview

Converts a date from the system default timezone to the specified target timezone.

## Syntax

```asp
result = g3date.ConvertSystemToZone(date, targetZone)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | A date value in the system timezone. |
| **targetZone** | String | Yes | IANA timezone identifier (e.g., "Europe/London"). |

## Return Value

Returns a **Date** value representing the same instant expressed in the target timezone.

## Remarks

- The input date is assumed to be in the system timezone configured in `axonasp.toml`.
- Invalid timezone names cause a fallback to the system default timezone.

## Example

```asp
<%
Option Explicit
Dim dt, now, londonTime
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
londonTime = dt.ConvertSystemToZone(now, "Europe/London")
Response.Write "London time: " & londonTime
Set dt = Nothing
%>
```
