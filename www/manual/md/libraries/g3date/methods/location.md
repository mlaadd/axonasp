# Get the System Default Timezone

## Overview

Returns the IANA name of the system default timezone as configured in `axonasp.toml`.

## Syntax

```asp
result = g3date.Location()
```

## Parameters

None.

## Return Value

Returns a **String** containing the IANA timezone name (e.g., "UTC", "America/New_York").

## Remarks

- The value is determined by the `global.default_timezone` setting in `axonasp.toml`.
- If not configured, defaults to "UTC".

## Example

```asp
<%
Option Explicit
Dim dt, sysLoc
Set dt = Server.CreateObject("G3DATE")
sysLoc = dt.Location()
Response.Write "System timezone: " & sysLoc
Set dt = Nothing
%>
```
