# Get Timezone Name and Offset

## Overview

Returns the timezone name and offset for a date as a two-element array.

## Syntax

```asp
arr = g3date.Zone(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |

## Return Value

Returns an **Array** with two elements: `[timezoneName, offsetSeconds]`.

## Remarks

- The timezone name is the abbreviation (e.g., "EST", "EDT", "UTC").
- The offset is in seconds east of UTC.

## Example

```asp
<%
Option Explicit
Dim dt, arr
Set dt = Server.CreateObject("G3DATE")
arr = dt.Zone(dt.UTCNow())
Response.Write "Zone: " & arr(0) & ", Offset: " & arr(1)
Set dt = Nothing
%>
```
