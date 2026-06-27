# Get the Nanosecond Component

## Overview

Returns the nanosecond component of a date value (0-999999999).

## Syntax

```asp
result = g3date.Nanosecond(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |

## Return Value

Returns an **Integer** from 0 to 999999999 representing the nanosecond within the second.

## Example

```asp
<%
Option Explicit
Dim dt, ns
Set dt = Server.CreateObject("G3DATE")
ns = dt.Nanosecond(dt.Now())
Response.Write "Nanoseconds: " & ns
Set dt = Nothing
%>
```
