<%@ Language=JScript %>

<HTML>
<HEAD><TITLE>JScript and the ActiveX Data Object (ADO)</TITLE></HEAD>
<BODY BGCOLOR=#FFFFFF>
<H3>ActiveX Data Object (ADO)</H3>
<%
Conn = Server.CreateObject("ADODB.Connection")
Conn.Open("ADOSamples")
RS = Conn.Execute("SELECT * FROM Orders")
%>
<P>
<TABLE BORDER=1>
<TR>
<% for (i = 0; i < RS.Fields.Count - 1; i++) { %>
	<TD><B><%= RS.Fields(i).Name %></B></TD>
<% } %>
</TR>

<% while (!RS.EOF) { %>
	<TR>
	<% for (i = 0; i < RS.Fields.Count - 1; i++) { %>
		<TD VALIGN=TOP><%= RS(i) %></TD>
	<% } %>
	</TR>
	<%
	RS.MoveNext()
}
RS.Close()
Conn.Close()
%>

</TABLE>
<BR>
<BR>
<!--#include virtual="/ASPSamp/Samples/srcform.inc"-->
</BODY>
</HTML>
