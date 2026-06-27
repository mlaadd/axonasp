# Get or Create UNIX Microsecond Timestamp

## Overview

When called with a date argument, returns the UNIX microsecond timestamp. When called with a single integer, creates a date from microseconds.

## Syntax

```asp
result = g3date.UnixMicro(value)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **value** | Date or Integer | Yes | A date value (returns microseconds) or an integer timestamp in microseconds (creates date). |

## Return Value

- If the argument is a **Date**: returns an **Integer** representing microseconds since 1970-01-01 UTC.
- If the argument is an **Integer**: returns a **Date** value.

## Example

```asp
<%
Option Explicit
Dim dt, now, micros
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
micros = dt.UnixMicro(now)
Response.Write "Microseconds: " & micros
Set dt = Nothing
%>
```
