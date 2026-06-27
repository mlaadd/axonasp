# Get Text Representation of a Date

## Overview

Returns the text representation of a date using Go's text marshaling format.

## Syntax

```asp
result = g3date.AppendText(date, layout)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |
| **layout** | String | Yes | Layout format for text output. |

## Return Value

Returns a **String** containing the text representation.

## Example

```asp
<%
Option Explicit
Dim dt, now
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
Response.Write dt.AppendText(now, "2006-01-02")
Set dt = Nothing
%>
```
