# Check if Daylight Saving Time Is Active

## Overview

Determines whether Daylight Saving Time (DST) is active for a given date in its timezone.

## Syntax

```asp
result = g3date.IsDST(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |

## Return Value

Returns a **Boolean**: True if DST is active for the date's timezone, False otherwise.

## Remarks

- UTC always returns False since it has no DST.
- The method compares January and July offsets to determine if DST is observed.
- For timezones that do not observe DST, always returns False.

## Example

```asp
<%
Option Explicit
Dim dt, now
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
If dt.IsDST(now) Then
    Response.Write "DST is currently active"
Else
    Response.Write "DST is not active"
End If
Set dt = Nothing
%>
```
