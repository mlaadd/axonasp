# Convert Duration to Minutes

## Overview

Converts a duration in nanoseconds to minutes as a floating-point value.

## Syntax

```asp
result = g3date.DurationMinutes(duration)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **duration** | Integer | Yes | Duration in nanoseconds. |

## Return Value

Returns a **Double** representing the duration in minutes. May include fractional minutes.

## Example

```asp
<%
Option Explicit
Dim dt, dur
Set dt = Server.CreateObject("G3DATE")
dur = dt.ParseDuration("1h30m")
Response.Write "Minutes: " & dt.DurationMinutes(dur) ' Output: 90
Set dt = Nothing
%>
```
