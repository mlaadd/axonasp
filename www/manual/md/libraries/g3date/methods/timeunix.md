# Get UNIX Timestamp from a Date

## Overview

Returns the UNIX timestamp (seconds since 1970-01-01 UTC) from a date value.

## Syntax

```asp
result = g3date.TimeUnix(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |

## Return Value

Returns an **Integer** representing seconds since January 1, 1970 UTC.

## Example

```asp
<%
Option Explicit
Dim dt, now, ts
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
ts = dt.TimeUnix(now)
Response.Write "UNIX timestamp: " & ts
Set dt = Nothing
%>
```
