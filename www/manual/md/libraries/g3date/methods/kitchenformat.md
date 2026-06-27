# Format Date as Kitchen Time

## Overview

Formats a date using the kitchen time layout (hour:minute AM/PM).

## Syntax

```asp
result = g3date.KitchenFormat(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date to format. |

## Return Value

Returns a **String** in kitchen format (e.g., "5:36PM").

## Example

```asp
<%
Option Explicit
Dim dt, now
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
Response.Write dt.KitchenFormat(now)
Set dt = Nothing
%>
```
