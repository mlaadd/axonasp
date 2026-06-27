# Get Offset Between Two Timezones

## Overview

Returns the current offset in seconds between two timezones.

## Syntax

```asp
result = g3date.OffsetZoneToZone(sourceZone, targetZone)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **sourceZone** | String | Yes | IANA timezone identifier for the source. |
| **targetZone** | String | Yes | IANA timezone identifier for the target. |

## Return Value

Returns an **Integer** representing the offset in seconds (target minus source).

## Remarks

- A positive result means the target timezone is ahead of the source timezone.
- The offset reflects current DST status for both timezones.
- This is equivalent to `OffsetZoneToUTC(target) - OffsetZoneToUTC(source)`.

## Example

```asp
<%
Option Explicit
Dim dt, offset
Set dt = Server.CreateObject("G3DATE")
offset = dt.OffsetZoneToZone("America/New_York", "Europe/London")
Response.Write "London minus NY offset: " & offset & " seconds"
Set dt = Nothing
%>
```
