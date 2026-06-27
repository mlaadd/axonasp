# Create a Duration Value

## Overview

Creates a duration value from a nanosecond count.

## Syntax

```asp
result = g3date.Duration(nanoseconds)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **nanoseconds** | Integer | Yes | The duration in nanoseconds. |

## Return Value

Returns an **Integer** representing the duration in nanoseconds.

## Remarks

- This method is primarily for type clarity; the value is stored as an integer.
- Use with other duration methods like `DurationHours`, `DurationString`, etc.

## Example

```asp
<%
Option Explicit
Dim dt, dur
Set dt = Server.CreateObject("G3DATE")
dur = dt.Duration(7200000000000) ' 2 hours
Response.Write "Duration: " & dt.DurationHours(dur) & " hours"
Set dt = Nothing
%>
```
