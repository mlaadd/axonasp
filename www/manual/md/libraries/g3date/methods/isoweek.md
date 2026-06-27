# Get the ISO Week Number

## Overview

Returns the ISO 8601 week number combined with the year as a single integer value (year * 1000 + week).

## Syntax

```asp
result = g3date.ISOWeek(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |

## Return Value

Returns an **Integer** where the year and ISO week number are encoded as `year * 1000 + week`. For example, 2026043 represents year 2026, week 43.

## Remarks

- ISO weeks start on Monday.
- Week 1 is the week containing the first Thursday of the year.

## Example

```asp
<%
Option Explicit
Dim dt, iw
Set dt = Server.CreateObject("G3DATE")
iw = dt.ISOWeek(dt.Now())
Response.Write "ISO week code: " & iw
Set dt = Nothing
%>
```
