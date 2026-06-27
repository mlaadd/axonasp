# Get the Day of the Year

## Overview

Returns the day of the year as an integer (1-366).

## Syntax

```asp
result = g3date.YearDay(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |

## Return Value

Returns an **Integer** from 1 to 366 representing the day of the year.

## Example

```asp
<%
Option Explicit
Dim dt, yd
Set dt = Server.CreateObject("G3DATE")
yd = dt.YearDay(dt.Now())
Response.Write "Day of the year: " & yd
Set dt = Nothing
%>
```
