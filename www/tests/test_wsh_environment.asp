<%@ Language="VBScript" %>
<%
' Test WScript.Shell.Environment collection
Response.Write "=== WScript.Shell.Environment Test ===" & vbCrLf

Dim shell, env, sysEnv
Set shell = Server.CreateObject("WScript.Shell")

' Test 1: Default Environment (PROCESS)
Set env = shell.Environment
Response.Write "Test 1 - Default Environment.Count: " & env.Count & vbCrLf
If env.Count > 0 Then
    Response.Write "  PASS: Count > 0" & vbCrLf
Else
    Response.Write "  FAIL: Count is 0" & vbCrLf
End If

' Test 2: Item access via default property
Response.Write "Test 2 - env(""PATH"") exists: " & (Len(env("PATH")) > 0) & vbCrLf
If Len(env("PATH")) > 0 Then
    Response.Write "  PASS: PATH found" & vbCrLf
Else
    Response.Write "  FAIL: PATH not found" & vbCrLf
End If

' Test 3: SYSTEM scope
Set sysEnv = shell.Environment("SYSTEM")
Response.Write "Test 3 - Environment(""SYSTEM"").Count: " & sysEnv.Count & vbCrLf

' Test 4: For Each enumeration
Response.Write "Test 4 - For Each enumeration:" & vbCrLf
Dim count, envVar
count = 0
For Each envVar In shell.Environment
    count = count + 1
    If count <= 3 Then
        Response.Write "  " & envVar & vbCrLf
    End If
Next
Response.Write "  Total enumerated: " & count & " (Count property says: " & env.Count & ")" & vbCrLf
If count = env.Count Then
    Response.Write "  PASS: For Each matches Count" & vbCrLf
Else
    Response.Write "  FAIL: For Each count mismatch" & vbCrLf
End If

' Test 5: .Item method
Response.Write "Test 5 - env.Item(""OS""): " & env.Item("OS") & vbCrLf

Response.Write "=== All Tests Complete ===" & vbCrLf
%>