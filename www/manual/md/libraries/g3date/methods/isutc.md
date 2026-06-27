# Check if Date Is in UTC

## Overview

Determines whether a date value is in the UTC timezone.

## Syntax

```asp
result = g3date.IsUTC(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |

## Return Value

Returns a **Boolean**: True if the date's location is UTC, False otherwise.

## Example

```asp
<%
Option Explicit
Dim dt, utc
Set dt = Server.CreateObject("G3DATE")
utc = dt.UTCNow()
If dt.IsUTC(utc) Then
    Response.Write "Date is in UTC"
End If
Set dt = Nothing
%>
```
