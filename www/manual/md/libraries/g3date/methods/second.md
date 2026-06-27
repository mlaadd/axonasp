# Get the Second Component

## Overview

Returns the second component of a date value (0-59).

## Syntax

```asp
result = g3date.Second(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |

## Return Value

Returns an **Integer** from 0 to 59 representing the second of the minute.

## Example

```asp
<%
Option Explicit
Dim dt, s
Set dt = Server.CreateObject("G3DATE")
s = dt.Second(dt.Now())
Response.Write "Current second: " & s
Set dt = Nothing
%>
```
