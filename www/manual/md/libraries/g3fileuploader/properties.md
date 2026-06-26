# G3FILEUPLOADER Properties

## Overview
This page summarizes properties exposed by **G3FILEUPLOADER** in G3Pix AxonASP, including the compatibility properties for **Persits.Upload (ASPUpload)** and **SoftArtisans.FileUp (SA-FileUp)**.

## Core Properties Reference

| Property | Access | Type | Description |
|---|---|---|---|
| AllowAbsolutePaths | Read/Write | Boolean | When true, allows saving files to absolute system paths outside the web root. (Defaults to true in compatibility modes). |
| AllowedExtensions | Read-only | Array of String | Gets the current allowed extension set. |
| BlockedExtensions | Read-only | Array of String | Gets the current blocked extension set. |
| DebugMode | Read/Write | Boolean | Gets or sets whether debug information is logged. |
| FormFields | Read-only | Dictionary | Returns a Dictionary containing all non-file form fields sent in the request. |
| MaxFileSize | Read/Write | Integer | Gets or sets the maximum upload size in bytes for each file. |
| PreserveOriginalName | Read/Write | Boolean | Gets or sets whether saved files preserve the original uploaded filename. |

## Compatibility Properties (ASPUpload & SA-FileUp)

| Property | Access | Type | Description |
|---|---|---|---|
| TotalBytes | Read-only | Integer | Returns the total size of the uploaded data in bytes. |
| OverwriteFiles | Read/Write | Boolean | (ASPUpload) When true (default), existing files with the same name are overwritten. When false, a unique counter is appended. |
| LogonUser | Read/Write | String | (ASPUpload) Impersonated user context (ignored, returns string). |
| ProgressID | Read/Write | String | (ASPUpload) ID for progress tracking. |
| Form | Read-only | Object | Collection of text form fields. In SA-FileUp mode, this mixes both text fields and file items. |
| Files | Read-only | Object | (ASPUpload) Collection of uploaded file objects. |
| Path | Read/Write | String | (SA-FileUp) Gets or sets the default directory where files will be saved. |
| IsEmpty | Read-only | Boolean | (SA-FileUp) Returns True if no files were uploaded in the request. |
| MaxBytes | Read/Write | Integer | (SA-FileUp) Gets or sets the maximum request payload size in bytes. |

## Uploaded File Item Properties

When accessing items inside the `Files` or `Form` (SA-FileUp) collections, the returned file objects support the following properties:

| Property | Access | Type | Description |
|---|---|---|---|
| Path | Read-only | String | Full local system path where the file is saved. |
| Filename | Read-only | String | The name of the file (e.g. `document.pdf`). |
| Ext | Read-only | String | The file extension including the dot (e.g. `.pdf`). |
| Size | Read-only | Integer | Size of the file in bytes. |
| ContentType | Read-only | String | MIME type of the file (e.g. `application/pdf`). |
| Binary | Read-only | Array | SafeArray of byte values containing the raw file data. |
| ImageWidth | Read-only | Integer | Width of the image in pixels (returns 0 if not a supported image file). |
| ImageHeight | Read-only | Integer | Height of the image in pixels (returns 0 if not a supported image file). |

## Remarks
- Property names are case-insensitive.
- Smart Alias Detection determines property availability and defaults based on the ProgID used during instantiation (`Persits.Upload` or `SoftArtisans.FileUp`).
