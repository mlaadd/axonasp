# Save Method

## Overview
Saves uploaded files to disk. The behavior, signature, and return values of this method depend on the ProgID used to instantiate the uploader (Smart Alias Detection).

## Syntax

### 1. ASPUpload (Persits.Upload) Mode
```asp
count = uploader.Save(Path)
```

### 2. SA-FileUp (SoftArtisans.FileUp) Mode
```asp
uploader.Save()
```

### 3. G3FILEUPLOADER Mode (Alias of Process)
```asp
Set result = uploader.Save(fieldName, targetDir, [newFileName])
```

## Parameters and Arguments
- `Path` (String, Required for ASPUpload): The physical directory where all uploaded files are to be saved.
- `fieldName` (String, Required for G3FILEUPLOADER): The form field name containing the file.
- `targetDir` (String, Optional for G3FILEUPLOADER): Target directory.
- `newFileName` (String, Optional for G3FILEUPLOADER): Optional new name.

## Return Values
- In **ASPUpload** mode: Returns an **Integer** representing the number of successfully saved files.
- In **SA-FileUp** mode: Returns **Empty**.
- In **G3FILEUPLOADER** mode: Returns a **Dictionary** containing the standardized uploader result.

## Remarks
- In **SA-FileUp** mode, the parameterless `Save()` method automatically saves all uploaded files to the folder path configured in the `Path` property.
- If absolute paths are disabled, virtual mapping is resolved.

## Code Example

### ASPUpload Example:
```asp
<%
Dim upl, savedCount
Set upl = Server.CreateObject("Persits.Upload")
savedCount = upl.Save("C:\uploads\")
Response.Write "Saved " & savedCount & " files."
%>
```

### SA-FileUp Example:
```asp
<%
Dim fileup
Set fileup = Server.CreateObject("SoftArtisans.FileUp")
fileup.Path = "C:\uploads\"
fileup.Save
%>
```
