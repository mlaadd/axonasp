# G3FILEUPLOADER Methods

## Overview
This page summarizes methods exposed by **G3FILEUPLOADER** in G3Pix AxonASP, including compatibility methods for **Persits.Upload (ASPUpload)** and **SoftArtisans.FileUp (SA-FileUp)**.

## Core & Compatibility Methods Reference

| Method | Returns | Description |
|---|---|---|
| AllowExtension | Empty | Adds one extension to the allowed list. |
| AllowExtensions | Empty | Adds multiple extensions to the allowed list from a comma-separated string. |
| BlockExtension | Empty | Adds one extension to the blocked list. |
| BlockExtensions | Empty | Adds multiple extensions to the blocked list from a comma-separated string. |
| Form | String/Object | Gets a form field value by name or index. In SA-FileUp mode, returns a file object if the field is a file. |
| FormValue | String | Alias of Form. |
| IsValidExtension | Boolean | Validates whether an extension is currently allowed. |
| GetFileInfo | Dictionary | Returns metadata for one uploaded form field. |
| GetAllFilesInfo | Array | Returns metadata for all uploaded files in the current request. |
| Process | Dictionary | Processes one uploaded file and saves it to disk (original G3FILEUPLOADER signature). |
| ProcessAll | Array | Processes all uploaded files and saves them to disk. |
| SetUseAllowedOnly | Empty | Enables or disables allow-list-only validation mode. |
| Save | Integer / Empty | **Collision Resolution:** Saves uploaded files to disk. In ASPUpload mode, it takes a target directory path and returns the number of successfully saved files. In SA-FileUp mode, it takes no parameters and saves all files to the folder path configured in the `Path` property. |
| SaveVirtual | Integer | (ASPUpload) Saves uploaded files to a virtual IIS folder and returns the count of files saved. |
| CreateDirectory | Empty | (ASPUpload) Creates a local physical or virtual directory. |
| SendBinary | Empty | (ASPUpload) Streams a binary file directly to the client browser, setting appropriate Content-Type headers. |
| SetMaxSize | Empty | (ASPUpload) Restricts maximum allowed upload payload size. |
| TransferFile | Empty | (SA-FileUp) Alias of `SendBinary`. Streams a local file to the client browser. |
| Flush | Empty | (SA-FileUp) Clears the parsed request state. |

## File Object Methods

Uploaded files retrieved from collections support the following methods:

| Method | Returns | Description |
|---|---|---|
| SaveAs | Empty | Saves the file to a specified absolute local system path. |
| SaveAsVirtual | Empty | Saves the file to a virtual IIS web path. |
| Copy | Empty | Copies the saved file to a target file path. |
| Delete | Empty | Deletes the saved file from the local disk. |

## Smart Alias Collision Resolution
When instantiating the uploader using `Server.CreateObject("Persits.Upload")` versus `Server.CreateObject("SoftArtisans.FileUp")`, the runtime sets the internal compatibility `Mode`. 
- **The `.Save()` Collision:**
  - In `Persits.Upload` mode, `Save(Path)` requires a physical directory path argument and returns the count of files saved.
  - In `SoftArtisans.FileUp` mode, `Save()` is parameterless and automatically saves all files to the directory path specified in the `.Path` property.
