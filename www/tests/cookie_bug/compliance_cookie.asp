<%@ Language="VBScript" %>
<%
' Test Dictionary/Collection objects for cookies
Dim action
action = Request.QueryString("action")
If action = "set" Then
    Response.Cookies("complex_cookie")("key1") = "val1"
    Response.Cookies("complex_cookie")("key2") = "val2"
    Response.Write("Complex Cookie set")
ElseIf action = "get" Then
    Dim val1, val2
    val1 = Request.Cookies("complex_cookie")("key1")
    val2 = Request.Cookies("complex_cookie")("key2")
    Response.Write("Complex Cookie retrieved: key1=" & val1 & ", key2=" & val2)
End If
%>