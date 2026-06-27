# Get String Representation of a Duration

## Overview

Returns the human-readable string representation of a duration.

## Syntax

```asp
result = g3date.DurationString(duration)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **duration** | Integer | Yes | Duration in nanoseconds. |

## Return Value

Returns a **String** in the format like "2h30m0s", "1h15m30s", or "45.5s".

## Example

```asp
<%
Option Explicit
Dim dt, dur
Set dt = Server.CreateObject("G3DATE")
dur = dt.ParseDuration("2h30m")
Response.Write "Duration string: " & dt.DurationString(dur) ' Output: 2h30m0s
Set dt = Nothing
%>
```
