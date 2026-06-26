# SetMaxSize Method

## Overview
(ASPUpload Compatibility) Sets the maximum allowed file upload payload limit.

## Syntax
```asp
uploader.SetMaxSize maxBytes, [reject]
```

## Parameters and Arguments
- `maxBytes` (Integer, Required): The maximum upload size limit in bytes.
- `reject` (Boolean, Optional): If true (default), the request is rejected with an error if it exceeds the limit.

## Return Values
Returns **Empty**.

## Remarks
- Dynamically configures the internal uploader limits.

## Code Example
```asp
<%
Dim upl
Set upl = Server.CreateObject("Persits.Upload")
upl.SetMaxSize 10485760, True ' Limit to 10MB
%>
```
