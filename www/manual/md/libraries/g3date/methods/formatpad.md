# Format a Date with Zero Padding

## Overview

Formats a date using a Go layout pattern with zero-padded numeric fields.

## Syntax

```asp
result = g3date.FormatPad(date, layout)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date to format. |
| **layout** | String | Yes | Go time layout string with zero-padded fields. |

## Return Value

Returns a **String** containing the formatted date with zero-padded components.

## Remarks

- This method replaces digits 1-6 in the layout with zero-padded equivalents (01-06) before formatting.
- Useful for ensuring consistent width in formatted output.

## Example

```asp
<%
Option Explicit
Dim dt, now
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
Response.Write dt.FormatPad(now, "2006-1-2 3:4:5")
Set dt = Nothing
%>
```
