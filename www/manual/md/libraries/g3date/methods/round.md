# Round Time to a Given Duration

## Overview

Rounds a date to the nearest multiple of the specified duration.

## Syntax

```asp
result = g3date.Round(date, nanoseconds)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date to round. |
| **nanoseconds** | Integer | Yes | Duration unit for rounding (e.g., 3600000000000 for 1 hour). |

## Return Value

Returns a **Date** value rounded to the nearest multiple of the given duration.

## Remarks

- Rounding uses standard midpoint rounding (up at exactly half).
- For example, rounding to 1 hour rounds 10:30:00 to 11:00:00.

## Example

```asp
<%
Option Explicit
Dim dt, now, rounded
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
rounded = dt.Round(now, 3600000000000) ' round to nearest hour
Response.Write "Rounded to hour: " & rounded
Set dt = Nothing
%>
```
