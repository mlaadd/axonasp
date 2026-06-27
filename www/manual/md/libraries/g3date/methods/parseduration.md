# Parse a Duration String

## Overview

Parses a human-readable duration string and returns the equivalent value in nanoseconds.

## Syntax

```asp
result = g3date.ParseDuration(duration)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **duration** | String | Yes | Duration string (e.g., "2h45m", "1h30m20s", "300ms"). |

## Return Value

Returns an **Integer** representing the duration in nanoseconds, or raises an error if the duration string is invalid.

## Remarks

- Valid time units: `ns`, `us`/`µs`, `ms`, `s`, `m`, `h`.
- Format: `[number]unit` with optional fractional values (e.g., "1.5h").
- Combine multiple units: `"2h45m30s"`.

## Example

```asp
<%
Option Explicit
Dim dt, dur, now, future
Set dt = Server.CreateObject("G3DATE")

' Parse 2 hours and 30 minutes
dur = dt.ParseDuration("2h30m")
now = dt.Now()
future = dt.Add(now, dur)
Response.Write "2.5 hours from now: " & future

Set dt = Nothing
%>
```
