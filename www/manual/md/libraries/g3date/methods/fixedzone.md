# Create a Fixed Offset Timezone

## Overview

Creates a timezone with a fixed offset from UTC, independent of geographic location and DST rules.

## Syntax

```asp
result = g3date.FixedZone(offset [, name])
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **offset** | Integer | Yes | Offset in seconds east of UTC (negative for west). |
| **name** | String | No | Name for the timezone (e.g., "EST"). |

## Return Value

Returns a **String** containing the fixed timezone description.

## Remarks

- A fixed zone does not observe Daylight Saving Time.
- For EST (UTC-5), use offset -18000 (-5 * 3600).
- For EDT (UTC-4), use offset -14400 (-4 * 3600).

## Example

```asp
<%
Option Explicit
Dim dt, fz
Set dt = Server.CreateObject("G3DATE")
fz = dt.FixedZone(-18000, "EST")
Response.Write "Fixed zone: " & fz
Set dt = Nothing
%>
```
