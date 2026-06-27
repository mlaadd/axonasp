# Add Years, Months, and Days to a Date

## Overview

Adds a specified number of years, months, and days to a date value.

## Syntax

```asp
result = g3date.AddDate(date, years, months, days)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The base date. |
| **years** | Integer | Yes | Number of years to add (negative to subtract). |
| **months** | Integer | Yes | Number of months to add (negative to subtract). |
| **days** | Integer | Yes | Number of days to add (negative to subtract). |

## Return Value

Returns a **Date** value adjusted by the specified amounts.

## Remarks

- Years, months, and days are applied in that order.
- Negative values perform subtraction.
- Month overflow is normalized (e.g., adding 1 month to January 31 produces February 28 or 29).

## Example

```asp
<%
Option Explicit
Dim dt, today, future
Set dt = Server.CreateObject("G3DATE")
today = dt.Now()
' Add 1 year, 2 months, 10 days
future = dt.AddDate(today, 1, 2, 10)
Response.Write "Future date: " & future
Set dt = Nothing
%>
```
