# Format Date as RFC 850

## Overview

Formats a date using the RFC 850 standard layout.

## Syntax

```asp
result = g3date.RFC850Format(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date to format. |

## Return Value

Returns a **String** in RFC 850 format (e.g., "Friday, 26-Jun-26 17:36:29 UTC").

## Example

```asp
<%
Option Explicit
Dim dt, now
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
Response.Write dt.RFC850Format(now)
Set dt = Nothing
%>
```
