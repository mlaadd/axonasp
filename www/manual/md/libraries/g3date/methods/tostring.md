# Get Default String Representation

## Overview

Returns the default string representation of a date value using Go's String() format.

## Syntax

```asp
result = g3date.ToString(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |

## Return Value

Returns a **String** in Go's default time format (e.g., "2026-06-26 17:36:29 +0000 UTC").

## Example

```asp
<%
Option Explicit
Dim dt, now
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
Response.Write dt.ToString(now)
Set dt = Nothing
%>
```
