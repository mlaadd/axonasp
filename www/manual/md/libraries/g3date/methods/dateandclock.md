# Get All Date and Time Components

## Overview

Returns the full date and time components as a six-element array: `[year, month, day, hour, minute, second]`.

## Syntax

```asp
arr = g3date.DateAndClock(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |

## Return Value

Returns an **Array** with six elements: `[year, month, day, hour, minute, second]`.

## Example

```asp
<%
Option Explicit
Dim dt, arr
Set dt = Server.CreateObject("G3DATE")
arr = dt.DateAndClock(dt.Now())
Response.Write "Year: " & arr(0) & ", Month: " & arr(1) & ", Day: " & arr(2)
Response.Write ", Hour: " & arr(3) & ", Minute: " & arr(4) & ", Second: " & arr(5)
Set dt = Nothing
%>
```
