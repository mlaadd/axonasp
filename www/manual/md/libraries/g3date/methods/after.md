# Check if One Date Is After Another

## Overview

Determines whether the first date occurs after the second date.

## Syntax

```asp
result = g3date.After(date1, date2)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date1** | Date | Yes | The date to test. |
| **date2** | Date | Yes | The reference date. |

## Return Value

Returns a **Boolean**: True if date1 is after date2, False otherwise.

## Example

```asp
<%
Option Explicit
Dim dt, today, tomorrow
Set dt = Server.CreateObject("G3DATE")
today = dt.Now()
tomorrow = dt.AddDate(today, 0, 0, 1)
If dt.After(tomorrow, today) Then
    Response.Write "Tomorrow is after today"
End If
Set dt = Nothing
%>
```
