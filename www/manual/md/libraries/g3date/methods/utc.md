# Convert Date to UTC

## Overview

Converts a date value to Coordinated Universal Time (UTC).

## Syntax

```asp
result = g3date.UTC(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |

## Return Value

Returns a **Date** value converted to UTC.

## Example

```asp
<%
Option Explicit
Dim dt, now, utc
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
utc = dt.UTC(now)
Response.Write "UTC time: " & utc
Set dt = Nothing
%>
```
