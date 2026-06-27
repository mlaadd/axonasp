# Round a Duration to a Multiple

## Overview

Rounds a duration to the nearest multiple of the specified rounding duration.

## Syntax

```asp
result = g3date.DurationRound(duration, roundDuration)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **duration** | Integer | Yes | Duration to round in nanoseconds. |
| **roundDuration** | Integer | Yes | Rounding unit in nanoseconds. |

## Return Value

Returns an **Integer** representing the rounded duration in nanoseconds.

## Example

```asp
<%
Option Explicit
Dim dt, dur
Set dt = Server.CreateObject("G3DATE")
dur = dt.ParseDuration("1h17m")
' Round to nearest 15 minutes (900000000000 ns)
Response.Write "Rounded: " & dt.DurationRound(dur, 900000000000) & " ns"
Set dt = Nothing
%>
```
