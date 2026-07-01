<%
Sub InnerRedirect()
    Response.Redirect "target.asp"
End Sub

Sub Outer()
    Response.Write "before<br>"
    InnerRedirect
    Response.Write "after (should NOT appear)<br>"
End Sub

Outer
%>