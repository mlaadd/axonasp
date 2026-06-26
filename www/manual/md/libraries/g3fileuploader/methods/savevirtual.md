# SaveVirtual Method

## Overview
(ASPUpload Compatibility) Saves all uploaded files to a virtual IIS directory path.

## Syntax
```asp
count = uploader.SaveVirtual(virtualPath)
```

## Parameters and Arguments
- `virtualPath` (String, Required): The virtual path (e.g. `/uploads` or `./images`) where files will be saved.

## Return Values
Returns an **Integer** representing the number of successfully saved files.

## Remarks
- Resolves the absolute physical path by invoking the internal path-mapping engine of the server before writing files.

## Code Example
```asp
<%
Dim upl, count
Set upl = Server.CreateObject("Persits.Upload")
count = upl.SaveVirtual("/my_virtual_uploads")
Response.Write "Saved " & count & " files."
%>
```
