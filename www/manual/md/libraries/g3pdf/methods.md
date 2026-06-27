# G3PDF Methods

## Overview
This page summarizes methods exposed by the G3PDF library in G3Pix AxonASP.

## Methods Reference

| Method | Returns | Description |
|---|---|---|
| New | Object | Initializes a new PDF context and returns the same object instance. |
| Init | Object | Alias of New. Initializes a new PDF context and returns the same object instance. |
| Reset | Object | Alias of New. Reinitializes the PDF context and returns the same object instance. |
| AddPage | Boolean | Adds a new page to the current document. |
| Close | Boolean | Finalizes the current document state. |
| Output | Boolean, String, or Null | Emits document output by destination mode: inline/download/file returns Boolean, string mode returns PDF binary string, and generation failures return Null. |
| SetFont | Boolean | Sets active font family, style, and size. |
| SetFontSize | Boolean | Sets active font size. |
| SetTextColor | Boolean | Sets text color using grayscale or RGB values. |
| SetDrawColor | Boolean | Sets stroke color using grayscale or RGB values. |
| SetFillColor | Boolean | Sets fill color using grayscale or RGB values. |
| SetLineWidth | Boolean | Sets line width for draw operations. |
| SetMargins | Boolean | Sets left, top, and optional right page margins. Returns False when required arguments are missing. |
| SetLeftMargin | Boolean | Sets left page margin. |
| SetTopMargin | Boolean | Sets top page margin. |
| SetRightMargin | Boolean | Sets right page margin. |
| SetX | Boolean | Sets the current horizontal cursor position. |
| SetY | Boolean | Sets the current vertical cursor position with optional X reset behavior. |
| SetXY | Boolean | Sets both horizontal and vertical cursor positions. |
| GetX | Double | Returns current horizontal cursor position. |
| GetY | Double | Returns current vertical cursor position. |
| Ln | Boolean | Moves cursor to the next line using optional offset. |
| Cell | Boolean | Writes one cell at the current cursor position. Returns False when required arguments are missing. |
| MultiCell | Boolean | Writes wrapped multi-line text cells. Returns False when required arguments are missing. |
| Write | Boolean | Writes flowing text. Returns False when required arguments are missing. |
| Text | Boolean | Writes text at absolute coordinates. Returns False when required arguments are missing. |
| Line | Boolean | Draws a line segment. Returns False when required arguments are missing. |
| Rect | Boolean | Draws a rectangle with optional style. Returns False when required arguments are missing. |
| Image | Boolean | Places an image at coordinates with optional sizing and link metadata. Returns False when required arguments are missing. |
| AddLink | Integer | Creates an internal link identifier and returns it. |
| SetLink | Boolean | Binds a link identifier to a document location. Returns False when required arguments are missing. |
| Link | Boolean | Creates a clickable rectangle bound to an internal or external link target. Returns False when required arguments are missing. |
| SetTitle | Boolean | Sets document title metadata. |
| SetAuthor | Boolean | Sets document author metadata. |
| SetSubject | Boolean | Sets document subject metadata. |
| SetKeywords | Boolean | Sets document keywords metadata. |
| SetCreator | Boolean | Sets document creator metadata. |
| AliasNbPages | Boolean | Sets the total-page alias token used in content placeholders. |
| SetDisplayMode | Boolean | Sets PDF viewer zoom and page layout mode. |
| SetCompression | Boolean | Enables or disables PDF stream compression. |
| WriteHTML | Boolean | Renders supported HTML markup into the current document. Returns False when HTML input is missing. |
| HTML | Boolean | Alias of WriteHTML. |
| WriteHTMLFile | Boolean | Loads and renders HTML from a file path. Returns False when the argument is missing or file loading fails. |
| HTMLFile | Boolean | Alias of WriteHTMLFile. |
| LoadHTMLFile | Boolean | Alias of WriteHTMLFile. |
| GetPageWidth | Double | Returns current page width in the active unit. |
| GetPageHeight | Double | Returns current page height in the active unit. |
| GetStringWidth | Double | Measures rendered width for a text string in the active font settings. |
| CreateDocument | Object (PdfDocument) | **[Persits.Pdf]** Creates a new PDF document and returns a PdfDocument sub-object. |
| OpenDocument | Object (PdfDocument) | **[Persits.Pdf]** Opens an existing PDF file and returns a PdfDocument sub-object. |
| Fonts | Object (PdfFont) | **[Persits.Pdf]** Loads a font by name and returns a PdfFont sub-object. |

## Persits.Pdf Sub-Object Methods

The following methods are available on sub-objects returned by Persits.Pdf methods.

### PdfDocument Methods

| Method | Returns | Description |
|---|---|---|
| Save | Boolean | **[Persits.Pdf]** Saves the PDF document to a file path. |
| SendBinary | String (binary) | **[Persits.Pdf]** Returns the PDF as a binary string for Response.BinaryWrite. |
| SendBinaryData | String (binary) | **[Persits.Pdf]** Alias of SendBinary. |
| ImportFromUrl | Boolean | **[Persits.Pdf]** Fetches a URL and renders its HTML content into the PDF. Routes to the existing WriteHTML engine. |
| Close | Boolean | **[Persits.Pdf]** Closes the document. |

### PdfDocument Properties

| Property | Type | Description |
|---|---|---|
| Pages | Object (Pages collection) | **[Persits.Pdf]** Returns a Pages collection object. Call `.Add()` to create a new PdfPage. |
| Open | Boolean | **[Persits.Pdf]** Indicates whether the document is currently open. |

### Pages Collection Methods

| Method | Returns | Description |
|---|---|---|
| Add | Object (PdfPage) | **[Persits.Pdf]** Adds a new page to the document and returns a PdfPage object. |

### PdfPage Properties

| Property | Type | Description |
|---|---|---|
| Canvas | Object (PdfCanvas) | **[Persits.Pdf]** Returns a PdfCanvas drawing surface for this page. |
| Width | Double | **[Persits.Pdf]** Returns page width in the current unit. |
| Height | Double | **[Persits.Pdf]** Returns page height in the current unit. |
| W | Double | **[Persits.Pdf]** Alias of Width. |
| H | Double | **[Persits.Pdf]** Alias of Height. |
| Rotation | Integer | **[Persits.Pdf]** Returns page rotation in degrees (always 0). |
| PageNumber | Integer | **[Persits.Pdf]** Returns the 1-based page number. |

### PdfCanvas Methods

| Method | Returns | Description |
|---|---|---|
| DrawText | Boolean | **[Persits.Pdf]** Draws text on the canvas using a param string. Supports `x`, `y`, `width`, `alignment`, `size`, `color` keys. |
| DrawLine | Boolean | **[Persits.Pdf]** Draws a line using a param string. Supports `x`, `y`, `x1`, `y1`, `color`, `width` keys. |
| DrawBox | Boolean | **[Persits.Pdf]** Draws a rectangle using a param string. Supports `left`, `top`, `right`, `bottom`, `color`, `width` keys. |

### PdfFont Properties

| Property | Type | Description |
|---|---|---|
| Name | String | **[Persits.Pdf]** Returns the original font name used for loading. |
| Family | String | **[Persits.Pdf]** Returns the resolved fpdf font family. |
| Size | Double | **[Persits.Pdf]** Gets or sets the font size in points. |
| Bold | Boolean | **[Persits.Pdf]** Gets or sets bold style flag. |
| Italic | Boolean | **[Persits.Pdf]** Gets or sets italic style flag. |
| Embedded | Boolean | **[Persits.Pdf]** Indicates whether the font is embedded (always true for built-in fonts). |

## Remarks
- Method names are case-insensitive.
- Alias methods resolve to the same behavior and return contract as their canonical methods.
- Items marked with **[Persits.Pdf]** are part of the Persits.Pdf / AspPDF compatibility layer. They are only active when the object was instantiated via `Server.CreateObject("Persits.Pdf")` or `Server.CreateObject("ASP.Pdf")`.
