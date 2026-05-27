<HTML>
<HEAD><TITLE>ADO Test</TITLE></HEAD>
<BODY BGCOLOR=#FFFFFF>
<H1>ADO Test</H1>
<% 
  Set C = Server.CreateObject("ADODB.Connection")
  C.Open "ADOSamples"
%>
<LI><FONT SIZE=4>Connection Properties</FONT>
<TABLE BORDER=1>
<%  For Item = 0 To C.Properties.Count - 1 %>
<TR>
<TD><FONT SIZE=2>
<%= C.Properties(Item).Name %></FONT></TD>

<TD><B><FONT SIZE=2>
<%
  ' Print something so that the table border gets displayed
  If IsEmpty(C.Properties(Item)) Then
	Response.Write "&nbsp&nbsp"
  ' Determine if the property is a Boolean
  ElseIf VarType(C.Properties(Item)) = 11 Then
    Response.Write CStr(CBool(C.Properties(Item)))
  Else
    Response.Write C.Properties(Item)
  End If
%>
</FONT></B></TD>
</TR>
<% Next %>
</TABLE>

<P>
<LI><FONT SIZE=4>Resultset Properties</FONT>
<BR>

<% Set RS = C.Execute("SELECT * FROM Products") %>

<TABLE BORDER=1>

<% For Item = 0 To RS.Properties.Count - 1 %>
<TR>
<TD><FONT SIZE=2><%=RS.Properties(Item).Name%></FONT></TD>
<TD><B><FONT SIZE=2>
<%
  ' Determine if the property is a Boolean
  If VarType(RS.Properties(Item)) = 11 Then
    Response.Write CStr(CBool(RS.Properties(Item)))
  Else
    Response.Write RS.Properties(Item)
  End If
%>
</FONT></B></TD>
</TR>
<% Next %>
</TABLE>

<% RS.Close %>
<% C.Close %>
<BR>
<BR>
<!--#include virtual="/ASPSamp/Samples/srcform.inc"--> 
</BODY>
</HTML>