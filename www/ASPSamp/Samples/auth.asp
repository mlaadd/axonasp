<% 
' In this sample, accessing the page will result in the browser popping up
' its authentication dialog requesting a user name and password.   Entering a 
' valid user name and password will display the user name and the type of 
' authentication used to validate the user.

If Request.ServerVariables("LOGON_USER") = "" Then
	Response.Status = "401 access denied"
End If
%>
<HTML>
<HEAD>
<TITLE>Authentication Sample</TITLE>
</HEAD>
<BODY BGCOLOR="#FFFFFF">
<h3>Authentication Sample</h3>
You logged in as user:<B>  <% = Request.ServerVariables("LOGON_USER") %></B>
<P>
You were authenticated using:<B>  <% = Request.ServerVariables("AUTH_TYPE") %></B> authentication
<P>
<P>
<!--#include virtual="/ASPSamp/Samples/srcform.inc"-->
</BODY>
</HTML>