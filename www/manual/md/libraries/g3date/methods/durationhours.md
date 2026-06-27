# Convert Duration to Hours

## Overview

Converts a duration in nanoseconds to hours as a floating-point value.

## Syntax

```asp
result = g3date.DurationHours(duration)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **duration** | Integer | Yes | Duration in nanoseconds. |

## Return Value

Returns a **Double** representing the duration in hours. May include fractional hours.

## Example

```asp
<%
Option Explicit
Dim dt, dur
Set dt = Server.CreateObject("G3DATE")
dur = dt.ParseDuration("2h30m")
Response.Write "Hours: " & dt.DurationHours(dur) ' Output: 2.5
Set dt = Nothing
%>
```
