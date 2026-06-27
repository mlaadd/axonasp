# Get Time Until a Future Date

## Overview

Returns the time remaining in nanoseconds until the specified future date.

## Syntax

```asp
result = g3date.Until(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The future date. |

## Return Value

Returns an **Integer** representing nanoseconds until the given date.

## Remarks

- The result is equivalent to `DateDiff(date, Now())`.
- A negative result means the date is in the past.

## Example

```asp
<%
Option Explicit
Dim dt, future, remaining
Set dt = Server.CreateObject("G3DATE")
future = dt.AddDate(dt.Now(), 0, 0, 7) ' 7 days from now
remaining = dt.Until(future)
Response.Write "Nanoseconds until next week: " & remaining
Set dt = Nothing
%>
```
