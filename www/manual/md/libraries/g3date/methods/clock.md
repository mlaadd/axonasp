# Get the Clock Time Components

## Overview

Returns the clock time (hour, minute, second) as a three-element array.

## Syntax

```asp
arr = g3date.Clock(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |

## Return Value

Returns an **Array** with three elements: `[hour, minute, second]`.

## Example

```asp
<%
Option Explicit
Dim dt, arr
Set dt = Server.CreateObject("G3DATE")
arr = dt.Clock(dt.Now())
Response.Write "Hour: " & arr(0) & ", Minute: " & arr(1) & ", Second: " & arr(2)
Set dt = Nothing
%>
```
