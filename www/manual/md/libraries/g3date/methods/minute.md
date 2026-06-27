# Get the Minute Component

## Overview

Returns the minute component of a date value (0-59).

## Syntax

```asp
result = g3date.Minute(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |

## Return Value

Returns an **Integer** from 0 to 59 representing the minute of the hour.

## Example

```asp
<%
Option Explicit
Dim dt, min
Set dt = Server.CreateObject("G3DATE")
min = dt.Minute(dt.Now())
Response.Write "Current minute: " & min
Set dt = Nothing
%>
```
