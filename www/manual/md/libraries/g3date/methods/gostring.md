# Get Go Syntax Representation

## Overview

Returns a Go-syntax representation of the date value using Go's GoString() format.

## Syntax

```asp
result = g3date.GoString(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |

## Return Value

Returns a **String** in Go syntax format, suitable for debugging.

## Example

```asp
<%
Option Explicit
Dim dt, now
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
Response.Write dt.GoString(now)
Set dt = Nothing
%>
```
