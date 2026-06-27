# Get Absolute Value of a Duration

## Overview

Returns the absolute (non-negative) value of a duration.

## Syntax

```asp
result = g3date.DurationAbs(duration)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **duration** | Integer | Yes | Duration in nanoseconds (may be negative). |

## Return Value

Returns an **Integer** representing the absolute value of the duration in nanoseconds (always non-negative).

## Example

```asp
<%
Option Explicit
Dim dt, dur
Set dt = Server.CreateObject("G3DATE")
dur = dt.DurationAbs(-3600000000000) ' -1 hour
Response.Write "Absolute: " & dt.DurationHours(dur) & " hours" ' Output: 1
Set dt = Nothing
%>
```
