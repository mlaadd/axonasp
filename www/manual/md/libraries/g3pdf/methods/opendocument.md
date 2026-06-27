# OpenDocument

## Overview

Opens an existing PDF file and returns a `PdfDocument` sub-object for further manipulation.

## Syntax

```asp
Set doc = obj.OpenDocument(Path)
```

## Parameters

- `Path` (String, Required): The file system path to the existing PDF file.

## Return Value

**Returns:** Object (PdfDocument). A sub-object representing the opened PDF document. Returns False if the file cannot be opened.

## Remarks

- This method is part of the Persits.Pdf / AspPDF compatibility layer.
- The underlying `go-pdf/fpdf` engine has limited support for loading existing PDFs. The document is recreated and existing content may not be fully preserved. For new documents, prefer `CreateDocument`.

## Code Example

```asp
<%
Option Explicit

Dim pdf, doc
Set pdf = Server.CreateObject("Persits.Pdf")
Set doc = pdf.OpenDocument("C:\existing.pdf")

If doc Is Nothing Then
    Response.Write "Failed to open document"
Else
    doc.Save "C:\modified.pdf"
End If

Set doc = Nothing
Set pdf = Nothing
%>
```
