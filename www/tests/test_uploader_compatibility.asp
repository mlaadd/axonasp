<%@ Language = VBScript %>
<%
Response.ContentType = "text/plain"
On Error Resume Next

Response.Write "--- ASPUpload (Persits.Upload) Compatibility Tests ---" & vbCrLf

Dim upl
Set upl = Server.CreateObject("Persits.Upload")
If Err.Number <> 0 Then
    Response.Write "Failed to create Persits.Upload: " & Err.Description & vbCrLf
    Err.Clear
Else
    Response.Write "ASPUpload created successfully." & vbCrLf
End If

' Test Persits Properties
upl.OverwriteFiles = False
Response.Write "OverwriteFiles: " & upl.OverwriteFiles & vbCrLf
upl.LogonUser = "DOMAIN\user"
Response.Write "LogonUser: " & upl.LogonUser & vbCrLf
upl.ProgressID = "prog123"
Response.Write "ProgressID: " & upl.ProgressID & vbCrLf
Response.Write "TotalBytes (should be 0 without request): " & upl.TotalBytes & vbCrLf

' Test Persits Collections
Dim files, form
Set files = upl.Files
Set form = upl.Form
Response.Write "Files TypeName: " & TypeName(files) & vbCrLf
Response.Write "Files Count: " & files.Count & vbCrLf
Response.Write "Form TypeName: " & TypeName(form) & vbCrLf
Response.Write "Form Count: " & form.Count & vbCrLf

' Test Persits Methods
Dim dirCreated
upl.CreateDirectory "./temp_dir_test", True
If Err.Number = 0 Then
    Response.Write "CreateDirectory executed successfully." & vbCrLf
Else
    Response.Write "CreateDirectory failed: " & Err.Description & vbCrLf
    Err.Clear
End If

Response.Write vbCrLf & "--- SA-FileUp (SoftArtisans.FileUp) Compatibility Tests ---" & vbCrLf

Dim fileup
Set fileup = Server.CreateObject("SoftArtisans.FileUp")
If Err.Number <> 0 Then
    Response.Write "Failed to create SoftArtisans.FileUp: " & Err.Description & vbCrLf
    Err.Clear
Else
    Response.Write "SA-FileUp created successfully." & vbCrLf
End If

' Test SA-FileUp Properties
fileup.Path = "C:\temp_uploads"
Response.Write "Path: " & fileup.Path & vbCrLf
fileup.MaxBytes = 2048
Response.Write "MaxBytes: " & fileup.MaxBytes & vbCrLf
Response.Write "IsEmpty (should be True without request): " & fileup.IsEmpty & vbCrLf
Response.Write "TotalBytes: " & fileup.TotalBytes & vbCrLf

' Test SA-FileUp Form
Dim saForm
Set saForm = fileup.Form
Response.Write "SA-FileUp Form Count: " & saForm.Count & vbCrLf

' Clear test directory
Dim fso
Set fso = Server.CreateObject("Scripting.FileSystemObject")
If fso.FolderExists(Server.MapPath("./temp_dir_test")) Then
    fso.DeleteFolder Server.MapPath("./temp_dir_test")
End If
%>
