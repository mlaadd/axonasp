# Fonts

## Overview

Loads a font by name and returns a `PdfFont` sub-object. Fonts are cached internally and reused on subsequent calls with the same name.

## Syntax

```asp
Set font = obj.Fonts(FontName)
```

## Parameters

- `FontName` (String, Required): The name of the font to load. Supports standard PDF font names and common aliases.

## Supported Font Names

| Font Name | FPDF Family | Style |
|---|---|---|
| Helvetica, Arial | helvetica | Normal |
| Helvetica-Bold, Arial Bold, ArialBD | helvetica | Bold |
| Helvetica-Oblique, Helvetica Italic, Arial Italic, ArialI | helvetica | Italic |
| Helvetica-BoldOblique, Helvetica Bold Italic, Arial Bold Italic, ArialBI | helvetica | Bold Italic |
| Times, Times Roman, Times New Roman | times | Normal |
| Times Bold, Times New Roman Bold | times | Bold |
| Times Italic, Times New Roman Italic | times | Italic |
| Times Bold Italic, Times New Roman Bold Italic | times | Bold Italic |
| Courier | courier | Normal |
| Courier-Bold | courier | Bold |
| Courier-Oblique, Courier Italic | courier | Italic |
| Courier-BoldOblique, Courier Bold Italic | courier | Bold Italic |
| Symbol | symbol | Normal |
| ZapfDingbats | zapfdingbats | Normal |

## Return Value

**Returns:** Object (PdfFont). A sub-object representing the loaded font.

## Remarks

- This method is part of the Persits.Pdf / AspPDF compatibility layer.
- The returned `PdfFont` object supports `Name`, `Family`, `Size`, `Bold`, `Italic`, and `Embedded` properties.

## Code Example

```asp
<%
Option Explicit

Dim pdf, doc, font
Set pdf = Server.CreateObject("Persits.Pdf")
Set doc = pdf.CreateDocument()
doc.Pages.Add

Set font = pdf.Fonts("Arial")
font.Size = 16
font.Bold = True

' Use font with canvas.DrawText
Dim canvas
Set canvas = doc.Pages(1).Canvas
canvas.DrawText "Hello", "x=10; y=50", font

doc.Save "C:\font_example.pdf"
Set doc = Nothing
Set pdf = Nothing
%>
```
