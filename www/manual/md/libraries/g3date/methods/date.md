# Construct a Date from Components

## Overview

Creates a date value from individual year, month, day, and optional time components.

## Syntax

```asp
result = g3date.Date(year, month, day [, hour, minute, second, nanosecond, timezone])
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **year** | Integer | Yes | Year (e.g., 2026). |
| **month** | Integer | Yes | Month (1-12). |
| **day** | Integer | Yes | Day (1-31). |
| **hour** | Integer | No | Hour (0-23, default: 0). |
| **minute** | Integer | No | Minute (0-59, default: 0). |
| **second** | Integer | No | Second (0-59, default: 0). |
| **nanosecond** | Integer | No | Nanosecond (0-999999999, default: 0). |
| **timezone** | String | No | IANA timezone name (default: system timezone). |

## Return Value

Returns a **Date** value constructed from the specified components.

## Remarks

- Out-of-range values are normalized (e.g., month 14 becomes February of the next year).
- The timezone determines the location context of the constructed time.

## Example

```asp
<%
Option Explicit
Dim dt, custom
Set dt = Server.CreateObject("G3DATE")
custom = dt.Date(2026, 12, 25, 10, 30, 0, 0, "UTC")
Response.Write "Custom date: " & custom
Set dt = Nothing
%>
```
