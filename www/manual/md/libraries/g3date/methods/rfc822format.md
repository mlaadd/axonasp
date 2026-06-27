# Format Date as RFC 822

## Overview

Formats a date using the RFC 822 standard layout.

## Syntax

```asp
result = g3date.RFC822Format(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date to format. |

## Return Value

Returns a **String** in RFC 822 format (e.g., "26 Jun 26 17:36 UTC").

## Example

```asp
<%
Option Explicit
Dim dt, now
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
Response.Write dt.RFC822Format(now)
Set dt = Nothing
%>
```
