# Calculate the Difference Between Two Dates

## Overview

Returns the difference between two dates in nanoseconds (date1 minus date2).

## Syntax

```asp
result = g3date.DateDiff(date1, date2)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date1** | Date | Yes | The first (later) date. |
| **date2** | Date | Yes | The second (earlier) date. |

## Return Value

Returns an **Integer** representing the difference in nanoseconds. A positive result means date1 is after date2.

## Remarks

- The result is in nanoseconds. Use `DurationHours`, `DurationMinutes`, etc. to convert.
- This method name avoids conflict with the VBScript `Sub` keyword.

## Example

```asp
<%
Option Explicit
Dim dt, now, later, diff
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
later = dt.AddDate(now, 0, 0, 7) ' 7 days later
diff = dt.DateDiff(later, now)
Response.Write "Difference in nanoseconds: " & diff
Response.Write "Hours: " & dt.DurationHours(diff)
Set dt = Nothing
%>
```
