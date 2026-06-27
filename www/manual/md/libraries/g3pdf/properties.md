# G3PDF Properties

## Overview
This page summarizes properties exposed by the G3PDF library in G3Pix AxonASP.

## Properties Reference

| Property | Access | Type | Description |
|---|---|---|---|
| LastError | Read-only | String | Stores the most recent library error message. |
| Page | Read-only | Integer | Returns the current page number. |
| X | Read/Write | Double | Gets or sets the current horizontal cursor position. |
| Y | Read/Write | Double | Gets or sets the current vertical cursor position. |
| W | Read-only | Double | Returns current page width. |
| H | Read-only | Double | Returns current page height. |
| Version | Read-only | String | Returns the implementation version string for this library. |

## Remarks
- Property names are case-insensitive.
- PageWidth and PageHeight are accepted aliases for W and H.
- For Persits.Pdf compatibility properties (Canvas, Width, Height, etc.), refer to the Methods page which documents sub-object properties of PdfPage, PdfDocument, PdfFont, and PdfCanvas.
