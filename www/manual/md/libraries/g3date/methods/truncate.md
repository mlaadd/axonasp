# Truncate Time to a Given Duration

## Overview

Rounds a date down to a multiple of the specified duration.

## Syntax

```asp
result = g3date.Truncate(date, nanoseconds)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date to truncate. |
| **nanoseconds** | Integer | Yes | Duration unit for rounding (e.g., 3600000000000 for 1 hour). |

## Return Value

Returns a **Date** value truncated to the given duration boundary.

## Remarks

- Truncation always rounds down (toward the past).
- For example, truncating to 1 hour sets minutes, seconds, and nanoseconds to zero.

## Example

```asp
<%
Option Explicit
Dim dt, now, truncated
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
truncated = dt.Truncate(now, 3600000000000) ' truncate to hour
Response.Write "Truncated to hour: " & truncated
Set dt = Nothing
%>
```
