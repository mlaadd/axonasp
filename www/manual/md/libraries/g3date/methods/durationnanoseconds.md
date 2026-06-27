# Convert Duration to Nanoseconds

## Overview

Returns a duration in nanoseconds as an integer. This is an identity operation since durations are already stored in nanoseconds.

## Syntax

```asp
result = g3date.DurationNanoseconds(duration)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **duration** | Integer | Yes | Duration in nanoseconds. |

## Return Value

Returns an **Integer** representing the same duration in nanoseconds.

## Example

```asp
<%
Option Explicit
Dim dt, dur
Set dt = Server.CreateObject("G3DATE")
dur = dt.ParseDuration("1h")
Response.Write "Nanoseconds: " & dt.DurationNanoseconds(dur)
Set dt = Nothing
%>
```
