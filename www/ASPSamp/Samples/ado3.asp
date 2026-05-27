<HTML>
<HEAD>
<TITLE>ActiveX Data Object (ADO)</TITLE>
</HEAD>
<BODY BGCOLOR=#FFFFFF>
<H3>ActiveX Data Object (ADO)</H3>
<OBJECT RUNAT=Server ID=Conn PROGID="ADODB.Connection"></OBJECT>
<%
Conn.Open "ADOSamples"
Set RS = Conn.Execute("SELECT * FROM Orders")
%>
<P>
<TABLE BORDER=1>
<TR>
<% For i = 0 to RS.Fields.Count - 1 %>
	<TD><B><% = RS(i).Name %></B></TD>
<% Next %>
</TR>
<% Do While Not RS.EOF %>
	<TR>
	<% For i = 0 to RS.Fields.Count - 1 %>
		<TD VALIGN=TOP><% = RS(i) %></TD>
	<% Next %>
	</TR>
	<%
	RS.MoveNext
Loop
RS.Close
Conn.Close
%>
</TABLE>
<BR>
<BR>
<!--#include virtual="/ASPSamp/Samples/srcform.inc"-->
</BODY>
</HTML>
