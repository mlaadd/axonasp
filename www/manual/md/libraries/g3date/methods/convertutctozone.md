# Convert UTC Date to Target Timezone

## Overview

Converts a UTC date value to the specified target timezone.

## Syntax

```asp
result = g3date.ConvertUTCtoZone(date, targetZone)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | A date value in UTC. |
| **targetZone** | String | Yes | IANA timezone identifier (e.g., "America/New_York"). |

## Return Value

Returns a **Date** value representing the same instant expressed in the target timezone.

## Remarks

- The input date is assumed to be in UTC.
- Invalid timezone names cause a fallback to the system default timezone.

## Example

```asp
<%
Option Explicit
Dim dt, utcNow, nyTime
Set dt = Server.CreateObject("G3DATE")
utcNow = dt.UTCNow()
nyTime = dt.ConvertUTCtoZone(utcNow, "America/New_York")
Response.Write "New York time: " & nyTime
Set dt = Nothing
%>
```
