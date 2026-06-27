# Get Current Date and Time

## Overview

Returns the current system date and time.

## Syntax

```asp
result = g3date.Now()
```

## Parameters

None.

## Return Value

Returns a **Date** value representing the current system date and time in the configured default timezone.

## Remarks

- The timezone used is determined by the `global.default_timezone` setting in `axonasp.toml`.
- To get UTC time regardless of configuration, use `UTCNow()`.

## Example

```asp
<%
Option Explicit
Dim dt, now
Set dt = Server.CreateObject("G3DATE")
now = dt.Now()
Response.Write "Current date and time: " & now
Set dt = Nothing
%>
```
