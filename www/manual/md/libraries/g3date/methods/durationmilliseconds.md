# Convert Duration to Milliseconds

## Overview

Converts a duration in nanoseconds to milliseconds as an integer.

## Syntax

```asp
result = g3date.DurationMilliseconds(duration)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **duration** | Integer | Yes | Duration in nanoseconds. |

## Return Value

Returns an **Integer** representing the duration in milliseconds. Fractional milliseconds are truncated.

## Example

```asp
<%
Option Explicit
Dim dt, dur
Set dt = Server.CreateObject("G3DATE")
dur = dt.ParseDuration("2.5s")
Response.Write "Milliseconds: " & dt.DurationMilliseconds(dur) ' Output: 2500
Set dt = Nothing
%>
```
