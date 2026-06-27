# Create Date from UNIX Timestamp

## Overview

Creates a date value from a UNIX timestamp (seconds and nanoseconds since 1970-01-01 UTC).

## Syntax

```asp
result = g3date.Unix(sec, nsec)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **sec** | Integer | Yes | Seconds since January 1, 1970 UTC. |
| **nsec** | Integer | Yes | Nanoseconds within the second (0-999999999). |

## Return Value

Returns a **Date** value representing the specified UNIX timestamp.

## Example

```asp
<%
Option Explicit
Dim dt, ts
Set dt = Server.CreateObject("G3DATE")
ts = dt.Unix(1763257845, 0)
Response.Write "Date from timestamp: " & ts
Set dt = Nothing
%>
```
