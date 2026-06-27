# Get the Hour Component

## Overview

Returns the hour component of a date value (0-23).

## Syntax

```asp
result = g3date.Hour(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |

## Return Value

Returns an **Integer** from 0 to 23 representing the hour of the day.

## Example

```asp
<%
Option Explicit
Dim dt, h
Set dt = Server.CreateObject("G3DATE")
h = dt.Hour(dt.Now())
Response.Write "Current hour: " & h
Set dt = Nothing
%>
```
