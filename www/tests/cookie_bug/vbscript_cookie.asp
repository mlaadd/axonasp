<%@ Language="VBScript" %>
<%
Response.Write("Method: " & Request.ServerVariables("REQUEST_METHOD") & vbCrLf)
Dim action
action = Request.QueryString("action")
If action = "set" Then
    Response.Cookies("test_vb_cookie") = "vb_value"
    Response.Write("Cookie set")
ElseIf action = "get" Then
    Dim val
    val = Request.Cookies("test_vb_cookie")
    Response.Write("Cookie retrieved: " & val)
Else
    Response.Write("No action")
End If
%>