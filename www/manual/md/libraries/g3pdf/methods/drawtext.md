# DrawText

## Overview

Draws text on a PDF page canvas using a parameter string to specify position, alignment, and formatting. This method is part of the Persits.Pdf compatibility layer and is called on a `PdfCanvas` object.

## Syntax

```asp
canvas.DrawText Text, Params, Font
```

## Parameters

- `Text` (String, Required): The text content to draw.
- `Params` (String, Required): A semicolon-separated string of key=value pairs specifying position and formatting.
- `Font` (Object, Optional): A `PdfFont` object returned by `pdf.Fonts()`. If provided, the font's properties (family, size, style) are applied.

## Supported Param Keys

| Key | Type | Default | Description |
|---|---|---|---|
| x | Double | current X | Horizontal position in the current unit. |
| y | Double | current Y | Vertical position in the current unit. |
| width | Double | auto | Maximum width for text wrapping. |
| alignment | String | left | Text alignment: `left`, `center`, `right`, or `justify`. |
| size | Double | font size | Override font size in points. |
| color | String | font color | Text color as a hex value (`#RRGGBB`) or HTML color name. |

## Return Value

**Returns:** Boolean. True on success, False if required arguments are missing.

## Remarks

- This method is part of the Persits.Pdf / AspPDF compatibility layer.
- The param string parser handles whitespace and semicolons flexibly.
- When a `Font` object is provided, its family, style, size, and color are used as defaults but can be overridden by param keys.
- If `width` is specified, text is wrapped using MultiCell; otherwise it flows continuously via Write.

## Code Example

```asp
<%
Option Explicit

Dim pdf, doc, page, canvas, font
Set pdf = Server.CreateObject("Persits.Pdf")
Set doc = pdf.CreateDocument()
Set page = doc.Pages.Add()
Set canvas = page.Canvas
Set font = pdf.Fonts("Arial")
font.Size = 14

' Draw centered text at position (10, 50) with width 200
canvas.DrawText "Hello from AxonASP!", "x=10; y=50; width=200; alignment=center; size=16", font

' Draw left-aligned text using only the param string
canvas.DrawText "Simple text", "x=10; y=100; color=#FF0000", font

doc.Save "C:\drawtext_example.pdf"
Set doc = Nothing
Set pdf = Nothing
%>
```
