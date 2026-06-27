# Format Date as Standard Datetime String

## Overview

Formats a date as a standard datetime string in the format "2006-01-02 15:04:05".

## Syntax

```asp
result = g3date.DateTimeFormat(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date to format. |

## Return Value

Returns a **String** in "YYYY-MM-DD HH:MM:SS" format (e.g., "2026-06-26 17:36:29").

## Example

```asp
<%
Option Explicit
Dim dt, now
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
Response.Write dt.DateTimeFormat(now)
Set dt = Nothing
%>
```
