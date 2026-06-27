# DrawBox

## Overview

Draws a rectangular box on the PDF page canvas using a parameter string to specify boundaries, color, and border width. This method is part of the Persits.Pdf compatibility layer and is called on a `PdfCanvas` object.

## Syntax

```asp
canvas.DrawBox Params
```

## Parameters

- `Params` (String, Required): A semicolon-separated string of key=value pairs specifying the rectangle properties.

## Supported Param Keys

| Key | Type | Default | Description |
|---|---|---|---|
| left | Double | 10 | Left edge X coordinate. |
| top | Double | 10 | Top edge Y coordinate. |
| right | Double | left+50 | Right edge X coordinate. |
| bottom | Double | top+50 | Bottom edge Y coordinate. |
| color | String | current color | Border color as a hex value (`#RRGGBB`) or HTML color name. |
| width | Double | 0.2 | Border line thickness in the current unit. |

## Return Value

**Returns:** Boolean. True on success, False if the param string is missing.

## Remarks

- This method is part of the Persits.Pdf / AspPDF compatibility layer.
- The param string parser handles whitespace and semicolons flexibly.
- Only the outline (border) of the rectangle is drawn; fill is not supported in this version.
- If `right` minus `left` or `bottom` minus `top` is zero or negative, the operation is silently skipped.

## Code Example

```asp
<%
Option Explicit

Dim pdf, doc, page, canvas
Set pdf = Server.CreateObject("Persits.Pdf")
Set doc = pdf.CreateDocument()
Set page = doc.Pages.Add()
Set canvas = page.Canvas

' Draw a box from (50, 50) to (150, 100) with red border
canvas.DrawBox "left=50; top=50; right=150; bottom=100; color=#FF0000; width=1"

' Draw a simple box with default settings
canvas.DrawBox "left=10; top=10; right=200; bottom=50"

doc.Save "C:\drawbox_example.pdf"
Set doc = Nothing
Set pdf = Nothing
%>
```
