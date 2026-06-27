# Format Date as RFC 3339 with Nanoseconds

## Overview

Formats a date using the RFC 3339 standard layout with nanosecond precision.

## Syntax

```asp
result = g3date.RFC3339NanoFormat(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date to format. |

## Return Value

Returns a **String** in RFC 3339 format with nanosecond precision (e.g., "2026-06-26T17:36:29.123456789Z").

## Example

```asp
<%
Option Explicit
Dim dt, now
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
Response.Write dt.RFC3339NanoFormat(now)
Set dt = Nothing
%>
```
