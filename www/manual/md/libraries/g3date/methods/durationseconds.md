# Convert Duration to Seconds

## Overview

Converts a duration in nanoseconds to seconds as a floating-point value.

## Syntax

```asp
result = g3date.DurationSeconds(duration)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **duration** | Integer | Yes | Duration in nanoseconds. |

## Return Value

Returns a **Double** representing the duration in seconds. May include fractional seconds.

## Example

```asp
<%
Option Explicit
Dim dt, dur
Set dt = Server.CreateObject("G3DATE")
dur = dt.ParseDuration("45s")
Response.Write "Seconds: " & dt.DurationSeconds(dur) ' Output: 45
Set dt = Nothing
%>
```
