# Get the Year Component

## Overview

Returns the year component of a date value.

## Syntax

```asp
result = g3date.Year(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |

## Return Value

Returns an **Integer** representing the year (e.g., 2026).

## Example

```asp
<%
Option Explicit
Dim dt, y
Set dt = Server.CreateObject("G3DATE")
y = dt.Year(dt.Now())
Response.Write "Current year: " & y
Set dt = Nothing
%>
```
