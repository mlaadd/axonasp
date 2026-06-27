# Truncate a Duration to a Multiple

## Overview

Truncates (rounds down) a duration to a multiple of the specified duration.

## Syntax

```asp
result = g3date.DurationTruncate(duration, truncDuration)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **duration** | Integer | Yes | Duration to truncate in nanoseconds. |
| **truncDuration** | Integer | Yes | Truncation unit in nanoseconds. |

## Return Value

Returns an **Integer** representing the truncated duration in nanoseconds.

## Example

```asp
<%
Option Explicit
Dim dt, dur
Set dt = Server.CreateObject("G3DATE")
dur = dt.ParseDuration("1h47m")
' Truncate to nearest hour (3600000000000 ns)
Response.Write "Truncated: " & dt.DurationTruncate(dur, 3600000000000) & " ns"
Set dt = Nothing
%>
```
