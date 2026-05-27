<HTML>
<HEAD>
<TITLE>ActiveX Data Objects</TITLE>
</HEAD>
<BODY BGCOLOR=#FFFFFF> 
<H2>Simple Example Retrieving All Results into an Array</H2>
<%
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "ADOSamples"
sql="SELECT * FROM Orders"
Set RS = Conn.Execute(sql)
%>
Here are the results from the query:<BR><I><B>  <%=sql%></I></B>
<P>
<P>
<TABLE BORDER=1>
<TR>
<% For i = 0 to RS.Fields.Count - 1 %>
	<TD><B><% = RS(i).Name %></B></TD>
<% Next %>
</TR>
<%
' Put up to 100 rows in a 2d variant array
v=RS.GetRows(100) 
RS.close
Conn.close
%>

<P>
<% For row = 0 to UBound(v,2)  ' iterate through the rows in the variant array %>
	<TR>
	<% For col = 0 to UBound(v,1) %>  
		<TD><% = v(col,row) %> </TD>
	<% Next %>
	</TR>
<% Next %>
</TABLE>
<BR>
<BR>
<!--#include virtual="/ASPSamp/Samples/srcform.inc"-->
</BODY>
</HTML>
