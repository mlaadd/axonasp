# Get Timezone Abbreviation

## Overview

Returns the timezone abbreviation for a given date (e.g., "EST", "EDT", "UTC").

## Syntax

```asp
result = g3date.TimezoneAbbreviation(date)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **date** | Date | Yes | The date value. |

## Return Value

Returns a **String** containing the timezone abbreviation (short name).

## Remarks

- The abbreviation depends on DST status for the given date.
- For America/New_York in January, returns "EST"; in July, returns "EDT".

## Example

```asp
<%
Option Explicit
Dim dt, abbr
Set dt = Server.CreateObject("G3DATE")
abbr = dt.TimezoneAbbreviation(dt.Now())
Response.Write "Timezone abbreviation: " & abbr
Set dt = Nothing
%>
```
