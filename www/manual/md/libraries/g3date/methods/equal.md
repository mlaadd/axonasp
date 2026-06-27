# Check if Two Dates Are Equal

## Overview

Determines whether two date values represent the same instant in time.

## Syntax

```asp
result = g3date.Equal(date1, date2)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date1** | Date | Yes | The first date. |
| **date2** | Date | Yes | The second date. |

## Return Value

Returns a **Boolean**: True if both dates represent the same instant, False otherwise.

## Remarks

- Equality is based on the UTC instant, not the clock time in a specific timezone.
- Two dates in different timezones that represent the same moment are considered equal.

## Example

```asp
<%
Option Explicit
Dim dt, d1, d2
Set dt = Server.CreateObject("G3DATE")
d1 = dt.Now()
d2 = dt.Now()
If dt.Equal(d1, d2) Then
    Response.Write "Both dates are the same"
End If
Set dt = Nothing
%>
```
