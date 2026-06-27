# Get the Month Component

## Overview

Returns the month component of a date value as an integer (1-12).

## Syntax

```asp
result = g3date.Month(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |

## Return Value

Returns an **Integer** from 1 (January) to 12 (December).

## Example

```asp
<%
Option Explicit
Dim dt, m
Set dt = Server.CreateObject("G3DATE")
m = dt.Month(dt.Now())
Response.Write "Current month: " & m
Set dt = Nothing
%>
```
