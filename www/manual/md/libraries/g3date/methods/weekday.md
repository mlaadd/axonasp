# Get the Weekday Component

## Overview

Returns the day of the week as an integer (0=Sunday, 6=Saturday).

## Syntax

```asp
result = g3date.Weekday(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |

## Return Value

Returns an **Integer** from 0 (Sunday) to 6 (Saturday).

## Example

```asp
<%
Option Explicit
Dim dt, wd
Set dt = Server.CreateObject("G3DATE")
wd = dt.Weekday(dt.Now())
Response.Write "Today is day " & wd & " of the week (0=Sunday)"
Set dt = Nothing
%>
```
