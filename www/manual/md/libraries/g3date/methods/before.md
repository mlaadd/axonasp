# Check if One Date Is Before Another

## Overview

Determines whether the first date occurs before the second date.

## Syntax

```asp
result = g3date.Before(date1, date2)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date1** | Date | Yes | The date to test. |
| **date2** | Date | Yes | The reference date. |

## Return Value

Returns a **Boolean**: True if date1 is before date2, False otherwise.

## Example

```asp
<%
Option Explicit
Dim dt, today, yesterday
Set dt = Server.CreateObject("G3DATE")
today = dt.Now()
yesterday = dt.AddDate(today, 0, 0, -1)
If dt.Before(yesterday, today) Then
    Response.Write "Yesterday is before today"
End If
Set dt = Nothing
%>
```
