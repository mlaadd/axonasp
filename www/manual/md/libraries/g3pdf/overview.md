# Create PDF documents using G3PDF

## Overview
The `G3PDF` object is a high-performance native library for generating PDF documents directly from Classic ASP code. It provides functions to add pages, format text, draw shapes, and manage document layout.

## Syntax
```asp
Dim pdf
Set pdf = Server.CreateObject("G3PDF")
```
```javascript
var pdf = Server.CreateObject("G3PDF");
```

## Parameters
None for instantiation.

## Return Values
Returns a native `G3PDF` object that can be used to construct PDF documents.

## Remarks
- Requires `Server.CreateObject("G3PDF")`. No aliases are supported.
- Powered by `go-pdf/fpdf` optimized for AxonASP.
- Ensure that memory and binary output streams are managed correctly.
- Call `Close` when finished applying content to the PDF object.

## Persits.Pdf Compatibility
The G3PDF library includes a **Persits.Pdf (AspPDF) compatibility layer**. When the object is instantiated via `Server.CreateObject("Persits.Pdf")` or `Server.CreateObject("ASP.Pdf")`, it provides an object model compatible with the AspPDF API:

- `CreateDocument()` returns a `PdfDocument` sub-object.
- `OpenDocument(Path)` opens an existing PDF file.
- `Fonts("FontName")` loads a font and returns a `PdfFont` sub-object.
- `PdfDocument.Pages.Add()` adds a page and returns a `PdfPage`.
- `PdfPage.Canvas` returns a `PdfCanvas` for drawing.
- `PdfCanvas.DrawText`, `DrawLine`, `DrawBox` use parameter strings for flexible positioning.
- `PdfDocument.Save`, `SendBinary`, and `ImportFromUrl` provide output and import.
- `ImportFromUrl` routes to the existing HTML-to-PDF engine.

See the Methods page for complete details on all Persits.Pdf sub-object methods and properties.

## Code Example
```asp
<%
Dim pdf
Set pdf = Server.CreateObject("G3PDF")

pdf.AddPage "", "", 0
pdf.SetFont "Arial", "B", 16
pdf.Cell 40, 10, "Hello World!", 1, 0, "C", False, ""

' Further output code...
%>
```

