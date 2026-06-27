# Format Date as RFC 3339

## Overview

Formats a date using the RFC 3339 standard layout.

## Syntax

```asp
result = g3date.RFC3339Format(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date to format. |

## Return Value

Returns a **String** in RFC 3339 format (e.g., "2026-06-26T17:36:29Z").

## Remarks

- This is equivalent to ISO 8601 extended format.
- RFC 3339 is a profile of ISO 8601.

## Example

```asp
<%
Option Explicit
Dim dt, now
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
Response.Write dt.RFC3339Format(now)
Set dt = Nothing
%>
```
