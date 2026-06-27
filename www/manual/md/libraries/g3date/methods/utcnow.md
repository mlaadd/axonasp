# Get Current UTC Date and Time

## Overview

Returns the current date and time in Coordinated Universal Time (UTC).

## Syntax

```asp
result = g3date.UTCNow()
```

## Parameters

None.

## Return Value

Returns a **Date** value representing the current UTC date and time.

## Remarks

- Unlike `Now()`, this method always returns UTC regardless of the configured timezone.
- Use this for timezone-independent timestamps.

## Example

```asp
<%
Option Explicit
Dim dt, utc
Set dt = Server.CreateObject("G3DATE")
utc = dt.UTCNow()
Response.Write "UTC time: " & utc
Set dt = Nothing
%>
```
