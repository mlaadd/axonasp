<%@ Language="VBScript" %>
<%
' Reads the values set by Application_OnStart defined via SSI includes in global.asa.
' Expected output: ProjectID: 12345 | ConfigLoaded: True
Response.Write "ProjectID: " & Application("ProjectID") & " | ConfigLoaded: " & Application("ConfigLoaded")
%>