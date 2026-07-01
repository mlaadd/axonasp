<%@ Language="VBScript" %>
<!--
Test: Bare call Response.Redirect termination
Verifies that Response.Redirect inside a Sub called with bare call (no Call keyword)
correctly terminates script execution.
-->
<%
Dim afterFlag
afterFlag = False

Sub InnerRedirect(target, msg)
    Response.Redirect target
End Sub

Sub Outer()
    Response.Write "before<br>"
    ' Bare call with arguments - this must terminate the script
    InnerRedirect "target.asp", "success" 
    Response.Write "after (should NOT appear)<br>"
End Sub

Outer
%>