# Convert Date to a Specific Timezone

## Overview

Converts a date value to the specified timezone.

## Syntax

```asp
result = g3date.In(date, timezone)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |
| **timezone** | String | Yes | IANA timezone identifier (e.g., "America/New_York"). |

## Return Value

Returns a **Date** value representing the same instant in the specified timezone.

## Example

```asp
<%
Option Explicit
Dim dt, now, nyTime
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
nyTime = dt.In(now, "America/New_York")
Response.Write "New York time: " & nyTime
Set dt = Nothing
%>
```
