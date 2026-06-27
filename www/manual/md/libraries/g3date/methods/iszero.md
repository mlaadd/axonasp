# Check if Date Is Zero

## Overview

Determines whether a date value is the zero (undefined) date value.

## Syntax

```asp
result = g3date.IsZero(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |

## Return Value

Returns a **Boolean**: True if the date is the zero value, False otherwise.

## Remarks

- The zero date represents an undefined or uninitialized date.
- Comparing a zero date against valid dates helps detect uninitialized values.

## Example

```asp
<%
Option Explicit
Dim dt, now
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
If Not dt.IsZero(now) Then
    Response.Write "Date is valid"
End If
Set dt = Nothing
%>
```
