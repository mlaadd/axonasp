# Format Date as RFC 1123

## Overview

Formats a date using the RFC 1123 standard layout.

## Syntax

```asp
result = g3date.RFC1123Format(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date to format. |

## Return Value

Returns a **String** in RFC 1123 format (e.g., "Fri, 26 Jun 2026 17:36:29 UTC").

## Remarks

- RFC 1123 is the standard format used in HTTP headers.
- Use this method when you need dates formatted for HTTP responses.

## Example

```asp
<%
Option Explicit
Dim dt, now
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
Response.Write dt.RFC1123Format(now)
Set dt = Nothing
%>
```
