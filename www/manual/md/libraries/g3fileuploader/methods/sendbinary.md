# SendBinary Method

## Overview
(ASPUpload Compatibility) Streams a local binary file directly to the client browser.

## Syntax
```asp
uploader.SendBinary path, [contentType]
```

## Parameters and Arguments
- `path` (String, Required): Local physical path of the file to send.
- `contentType` (String, Optional): The MIME Content-Type header. If omitted, the server attempts to auto-detect the MIME type from the file extension.

## Return Values
Returns **Empty**.

## Remarks
- Flushes binary content directly into the HTTP response stream.

## Code Example
```asp
<%
Dim upl
Set upl = Server.CreateObject("Persits.Upload")
upl.SendBinary "C:\files\report.pdf", "application/pdf"
%>
```
