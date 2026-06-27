# Get Offset from Timezone to UTC

## Overview

Returns the current offset in seconds between the specified timezone and UTC.

## Syntax

```asp
result = g3date.OffsetZoneToUTC(targetZone)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **targetZone** | String | Yes | IANA timezone identifier (e.g., "America/New_York"). |

## Return Value

Returns an **Integer** representing the offset in seconds. Positive values are east of UTC, negative values are west.

## Remarks

- The offset reflects the current DST status of the timezone.
- For UTC, the offset is always 0.
- For EST (America/New_York in winter), the offset is -18000 (-5 hours).

## Example

```asp
<%
Option Explicit
Dim dt, offset
Set dt = Server.CreateObject("G3DATE")
offset = dt.OffsetZoneToUTC("America/New_York")
Response.Write "NY offset from UTC: " & offset & " seconds"
Set dt = Nothing
%>
```
