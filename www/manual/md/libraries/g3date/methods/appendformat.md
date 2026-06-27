# Append Formatted Text to a Buffer

## Overview

Formats a date using a Go layout and returns the result as a string.

## Syntax

```asp
result = g3date.AppendFormat(date, layout)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date to format. |
| **layout** | String | Yes | Go time layout string. |

## Return Value

Returns a **String** containing the formatted date.

## Remarks

- Similar to `Format`, but uses Go's `AppendFormat` internally.
- The result is identical to `Format` for the same inputs.

## Example

```asp
<%
Option Explicit
Dim dt, now
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
Response.Write dt.AppendFormat(now, "2006-01-02 15:04:05")
Set dt = Nothing
%>
```
