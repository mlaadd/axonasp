# Get Offset from Timezone to System Timezone

## Overview

Returns the current offset in seconds between the specified timezone and the system default timezone.

## Syntax

```asp
result = g3date.OffsetZoneToSystem(targetZone)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **targetZone** | String | Yes | IANA timezone identifier. |

## Return Value

Returns an **Integer** representing the offset in seconds (system timezone minus target timezone).

## Remarks

- A positive result means the system timezone is ahead of the target timezone.
- The offset reflects current DST status for both timezones.

## Example

```asp
<%
Option Explicit
Dim dt, offset
Set dt = Server.CreateObject("G3DATE")
offset = dt.OffsetZoneToSystem("Asia/Tokyo")
Response.Write "Offset from Tokyo to system: " & offset & " seconds"
Set dt = Nothing
%>
```
