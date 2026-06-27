# Load and Validate a Timezone

## Overview

Validates a timezone name and returns its IANA identifier, or Empty if the timezone is not found.

## Syntax

```asp
result = g3date.LoadLocation(timezone)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **timezone** | String | Yes | IANA timezone identifier (e.g., "America/New_York"). |

## Return Value

Returns a **String** containing the validated timezone name, or **Empty** if the timezone is not recognized.

## Remarks

- Use this method to validate timezone names before using them in other methods.
- Valid timezones are those in the IANA Time Zone Database.

## Example

```asp
<%
Option Explicit
Dim dt, loc
Set dt = Server.CreateObject("G3DATE")
loc = dt.LoadLocation("Europe/London")
If Not IsEmpty(loc) Then
    Response.Write "Valid timezone: " & loc
Else
    Response.Write "Invalid timezone"
End If
Set dt = Nothing
%>
```
