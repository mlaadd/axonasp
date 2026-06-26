# TransferFile Method

## Overview
(SA-FileUp Compatibility) Streams a local binary file to the client browser. Functional alias of `SendBinary`.

## Syntax
```asp
uploader.TransferFile path, [contentType]
```

## Parameters and Arguments
- `path` (String, Required): Local physical path of the file.
- `contentType` (String, Optional): The MIME Content-Type header.

## Return Values
Returns **Empty**.

## Remarks
- Flushes the local file directly into the HTTP response stream.

## Code Example
```asp
<%
Dim fileup
Set fileup = Server.CreateObject("SoftArtisans.FileUp")
fileup.TransferFile "C:\reports\archive.zip", "application/zip"
%>
```
