<%
' AxonASP console extensions test for VBScript
' Run with: .\axonasp-cli.exe -m vbscript -r ./www/tests/test_console_extensions.asp

Dim data
Set data = Server.CreateObject("Scripting.Dictionary")
data.Add "name", "AxonASP"
data.Add "version", 2

dim i
console.time "vb-phase"
For i = 1 To 5000
Next
console.timeEnd "vb-phase"

console.dir data
console.log "VBScript console extensions test completed"
Response.Write "OK"
%>
