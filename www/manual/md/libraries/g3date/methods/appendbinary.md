# Get Binary Encoding of a Date

## Overview

Returns the binary encoding of a date value using Go's binary encoding format.

## Syntax

```asp
result = g3date.AppendBinary(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |

## Return Value

Returns a **String** containing the binary-encoded date representation.

## Remark

This is useful for serializing dates for storage or transmission in binary formats.

## Example

```asp
<%
Option Explicit
Dim dt, now, bin
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
bin = dt.AppendBinary(now)
Response.Write "Binary length: " & Len(bin)
Set dt = Nothing
%>
```
