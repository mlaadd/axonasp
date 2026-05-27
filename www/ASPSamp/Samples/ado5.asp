<HTML>
<HEAD><TITLE>ActiveX Data Objects</TITLE></HEAD>
<BODY BGCOLOR=#FFFFFF>
<H2>Simple Example Query using a fetch loop</H2>
<%
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "ADOSamples"
sql="select ProductName, ProductDescription from Products where ProductType in ('Boot', 'Tent')"
Set RS = Conn.Execute(sql)
%>
Here are the results from the query:<BR><I><B>  <%=sql%></I></B><P>
<TABLE BORDER>
<% Do While not RS.eof%>
	<TR>
	<TD><% = RS("ProductName") %></TD><TD><% = RS("ProductDescription") %></TD>
	</TR>
	<%
	RS.MoveNext
Loop
RS.close
Conn.close
%>
</TABLE>
<BR>
<BR>
<!--#include virtual="/ASPSamp/Samples/srcform.inc"-->
</BODY>
</HTML>
