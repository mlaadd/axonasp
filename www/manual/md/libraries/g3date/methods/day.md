# Get the Day Component

## Overview

Returns the day-of-month component of a date value (1-31).

## Syntax

```asp
result = g3date.Day(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |

## Return Value

Returns an **Integer** from 1 to 31 representing the day of the month.

## Example

```asp
<%
Option Explicit
Dim dt, d
Set dt = Server.CreateObject("G3DATE")
d = dt.Day(dt.Now())
Response.Write "Current day: " & d
Set dt = Nothing
%>
```
