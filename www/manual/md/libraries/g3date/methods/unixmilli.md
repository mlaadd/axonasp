# Get or Create UNIX Millisecond Timestamp

## Overview

When called with a date argument, returns the UNIX millisecond timestamp. When called with a single integer, creates a date from milliseconds.

## Syntax

```asp
result = g3date.UnixMilli(value)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **value** | Date or Integer | Yes | A date value (returns milliseconds) or an integer timestamp in milliseconds (creates date). |

## Return Value

- If the argument is a **Date**: returns an **Integer** representing milliseconds since 1970-01-01 UTC.
- If the argument is an **Integer**: returns a **Date** value.

## Example

```asp
<%
Option Explicit
Dim dt, now, millis
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
millis = dt.UnixMilli(now)
Response.Write "Milliseconds: " & millis
Set dt = Nothing
%>
```
