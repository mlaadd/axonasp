# Flush Method

## Overview
(SA-FileUp Compatibility) Clears cached upload request parsing state.

## Syntax
```asp
uploader.Flush()
```

## Parameters and Arguments
None.

## Return Values
Returns **Empty**.

## Remarks
- Resets the parsed state cache of the uploader instance.

## Code Example
```asp
<%
Dim fileup
Set fileup = Server.CreateObject("SoftArtisans.FileUp")
fileup.Flush
%>
```
