# CreateDirectory Method

## Overview
(ASPUpload Compatibility) Creates a directory on the local system.

## Syntax
```asp
uploader.CreateDirectory path, [ignoreAlreadyExists]
```

## Parameters and Arguments
- `path` (String, Required): The local system directory path to create.
- `ignoreAlreadyExists` (Boolean, Optional): If true (default), no error is raised if the directory already exists.

## Return Values
Returns **Empty**.

## Remarks
- Resolves virtual paths to physical paths if a relative path is provided.

## Code Example
```asp
<%
Dim upl
Set upl = Server.CreateObject("Persits.Upload")
upl.CreateDirectory "C:\new_upload_directory", True
%>
```
