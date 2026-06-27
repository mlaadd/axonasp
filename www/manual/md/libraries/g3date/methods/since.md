# Get Time Elapsed Since a Date

## Overview

Returns the elapsed time in nanoseconds since the specified date.

## Syntax

```asp
result = g3date.Since(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The past date. |

## Return Value

Returns an **Integer** representing nanoseconds elapsed since the given date.

## Remarks

- The result is equivalent to `DateDiff(Now(), date)`.
- A negative result means the date is in the future.

## Example

```asp
<%
Option Explicit
Dim dt, past, elapsed
Set dt = Server.CreateObject("G3DATE")
past = dt.AddDate(dt.Now(), 0, 0, -1) ' 1 day ago
elapsed = dt.Since(past)
Response.Write "Nanoseconds since yesterday: " & elapsed
Set dt = Nothing
%>
```
