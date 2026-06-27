# Format Date as ISO 8601 / RFC 3339

## Overview

Formats a date value as an ISO 8601 string (RFC 3339 format).

## Syntax

```asp
result = g3date.ISOFormat(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date to format. |

## Return Value

Returns a **String** in RFC 3339 format (e.g., "2026-06-26T17:36:29Z").

## Remarks

- The output follows the ISO 8601 extended format.
- UTC dates end with "Z", other timezones include the offset.

## Example

```asp
<%
Option Explicit
Dim dt, now
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
Response.Write dt.ISOFormat(now)
Set dt = Nothing
%>
```
