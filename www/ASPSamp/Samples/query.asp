<HTML>
<HEAD><TITLE>Simple ADO Page Scrolling Example</TITLE></HEAD>
<BODY BGCOLOR=#FFFFFF>
<H1>Simple ADO Page Scrolling Example</H1>
<FORM METHOD=POST ACTION="Results.asp">
<P>Query:
<% sql = Request("sql")
if sql = "" Then
	sql = "select ProductName, ProductType, ProductDescription, ProductImageURL from products"
end if
%>
<P><TEXTAREA NAME="sql" ROWS=15 COLS=75><%=sql%></TEXTAREA><BR>
<P><INPUT TYPE=SUBMIT VALUE="Execute"><INPUT TYPE=RESET VALUE="Reset">
</FORM>
<!--#include virtual="/ASPSamp/Samples/srcform.inc"--> 
</BODY>
</HTML>
