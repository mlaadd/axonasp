# Convert Date to Local Time

## Overview

Converts a date value to the system local timezone.

## Syntax

```asp
result = g3date.Local(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |

## Return Value

Returns a **Date** value converted to the system local timezone.

## Example

```asp
<%
Option Explicit
Dim dt, utc, local
Set dt = Server.CreateObject("G3DATE")
utc = dt.UTCNow()
local = dt.Local(utc)
Response.Write "Local time: " & local
Set dt = Nothing
%>
```
