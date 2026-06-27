# CreateDocument

## Overview

Creates a new PDF document and returns a `PdfDocument` sub-object. This is the entry point for the Persits.Pdf compatibility layer.

## Syntax

```asp
Set doc = obj.CreateDocument()
```

## Parameters

None.

## Return Value

**Returns:** Object (PdfDocument). A sub-object representing the new PDF document.

## Remarks

- This method is part of the Persits.Pdf / AspPDF compatibility layer.
- It is available when the object is instantiated via `Server.CreateObject("Persits.Pdf")` or `Server.CreateObject("ASP.Pdf")`.
- The returned `PdfDocument` object supports `Save`, `SendBinary`, `ImportFromUrl`, and `Close` methods, as well as a `Pages` property for adding pages.

## Code Example

```asp
<%
Option Explicit

Dim pdf, doc
Set pdf = Server.CreateObject("Persits.Pdf")
Set doc = pdf.CreateDocument()

' Add pages and content via doc.Pages.Add and doc.Pages(1).Canvas

doc.Save "C:\output.pdf"
Set doc = Nothing
Set pdf = Nothing
%>
```
