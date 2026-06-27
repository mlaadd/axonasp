# Check if Date Is in Local Timezone

## Overview

Determines whether a date value is in the system local timezone.

## Syntax

```asp
result = g3date.IsLocal(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |

## Return Value

Returns a **Boolean**: True if the date's location is the system local timezone, False otherwise.

## Example

```asp
<%
Option Explicit
Dim dt, now
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
If dt.IsLocal(now) Then
    Response.Write "Date is in local timezone"
End If
Set dt = Nothing
%>
```
