<%@ Language="VBScript" %>
<%
Dim action
action = Request.QueryString("action")
If action = "set" Then
    Session("test_session_key") = "session_value"
    Response.Write("Session set")
ElseIf action = "get" Then
    Dim val
    val = Session("test_session_key")
    Response.Write("Session retrieved: " & val)
End If
%>