# DrawLine

## Overview

Draws a line on the PDF page canvas using a parameter string to specify start and end coordinates, color, and width. This method is part of the Persits.Pdf compatibility layer and is called on a `PdfCanvas` object.

## Syntax

```asp
canvas.DrawLine Params
```

## Parameters

- `Params` (String, Required): A semicolon-separated string of key=value pairs specifying the line properties.

## Supported Param Keys

| Key | Type | Default | Description |
|---|---|---|---|
| x | Double | 0 | Start point X coordinate. |
| y | Double | 0 | Start point Y coordinate. |
| x1 | Double | x+10 | End point X coordinate. |
| y1 | Double | y+10 | End point Y coordinate. |
| color | String | current color | Line color as a hex value (`#RRGGBB`) or HTML color name. |
| width | Double | 0.2 | Line thickness in the current unit. |

## Return Value

**Returns:** Boolean. True on success, False if the param string is missing.

## Remarks

- This method is part of the Persits.Pdf / AspPDF compatibility layer.
- The param string parser handles whitespace and semicolons flexibly.
- The line is drawn using the current draw color unless overridden by the `color` parameter.

## Code Example

```asp
<%
Option Explicit

Dim pdf, doc, page, canvas
Set pdf = Server.CreateObject("Persits.Pdf")
Set doc = pdf.CreateDocument()
Set page = doc.Pages.Add()
Set canvas = page.Canvas

' Draw a horizontal line from (10, 100) to (200, 100)
canvas.DrawLine "x=10; y=100; x1=200; y1=100; width=1; color=#000000"

' Draw a red diagonal line
canvas.DrawLine "x=10; y=10; x1=100; y1=100; color=#FF0000; width=0.5"

doc.Save "C:\drawline_example.pdf"
Set doc = Nothing
Set pdf = Nothing
%>
```
