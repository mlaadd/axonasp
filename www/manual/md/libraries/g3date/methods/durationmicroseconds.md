# Convert Duration to Microseconds

## Overview

Converts a duration in nanoseconds to microseconds as an integer.

## Syntax

```asp
result = g3date.DurationMicroseconds(duration)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **duration** | Integer | Yes | Duration in nanoseconds. |

## Return Value

Returns an **Integer** representing the duration in microseconds. Fractional microseconds are truncated.

## Example

```asp
<%
Option Explicit
Dim dt, dur
Set dt = Server.CreateObject("G3DATE")
dur = dt.ParseDuration("1ms")
Response.Write "Microseconds: " & dt.DurationMicroseconds(dur) ' Output: 1000
Set dt = Nothing
%>
```
