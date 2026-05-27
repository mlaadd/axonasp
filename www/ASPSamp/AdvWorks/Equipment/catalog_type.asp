<%
ProductType = Request.QueryString("ProductType")
If ProductType = "" Then
	Response.Redirect("/AdvWorks/Equipment/default.asp")
End If
%>

<HTML>
<HEAD>
<TITLE>Adventure Works Catalog</TITLE>
</HEAD>

<BODY BACKGROUND="/AdvWorks/multimedia/images/back_sub.gif"> 
<FONT FACE="Verdana, Arial, Helvetica" SIZE=2>

<%
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open Session("ConnectionString")
SQL = "SELECT * FROM Products WHERE ProductType = '" & ProductType & "'"
Set RScatalog_item = Conn.Execute(SQL)
%>

<TABLE BORDER=0>
<TR>
<TD> 
<IMG SRC="/AdvWorks/multimedia/images/spacer.GIF" ALIGN=RIGHT WIDTH=100 ALT="">
</TD>

<TD COLSPAN=5>
<IMG SRC="/AdvWorks/multimedia/images/hd_<% = ProductType %>.GIF" ALIGN=CENTER BORDER=0 ALT="<%= Request.QueryString("ProductType") %>"><BR>
<HR SIZE=4>
</TD>
</TR>


<!--Begin Navigational Buttons-->

<TR>
<TD ROWSPAN=5 ALIGN=LEFT VALIGN=TOP>
<!--#include virtual="/AdvWorks/Navbar2.inc"-->
<!--#include virtual="/AdvWorks/srcform.inc"-->
<BR>

<%If Session("ItemCount") > 0 Then%>
	<A HREF="/AdvWorks/equipment/check_out.asp">
	<IMG SRC="/AdvWorks/multimedia/images/checkout.gif" WIDTH="85" HEIGHT="45" ALT="Check Out" BORDER=O></A>
<%End If%>
</TD>

<!-- BEGIN data into interface -->

<%
ProductNumber = 1
Do While Not RScatalog_item.EOF
	ProductNumber = ProductNumber + 1
%>

  <TD ALIGN=RIGHT VALIGN=TOP>
  <IMG SRC="<%=RScatalog_item("ProductImageURL")%>" ALT="<%=RScatalog_item("ProductName")%>">
  </TD>

  <TD ALIGN=LEFT VALIGN=TOP>
  <%if MONTH(RScatalog_item("ProductIntroductionDate")) > (MONTH(NOW)-1) then%>
    <FONT COLOR="#800080" SIZE=2><B>New!</B></FONT><BR> 
  <%end if%>

  <FONT SIZE=2><B><%=RScatalog_item("ProductName")%></B>,
  <%=RScatalog_item("ProductDescription")%><BR>

  <% If Not IsNull(RScatalog_item("ProductSize")) Then %>
    sizes <%=RScatalog_item("ProductSize")%>
  <% End If %>
  <BR>
  <%=RScatalog_item("ProductCode")%>

<BR>
<BR>

<%
	If RScatalog_item("OnSale") Then
		bOnSale = TRUE
		Price = (RScatalog_item("UnitPrice")-(RScatalog_item("UnitPrice") / 10))
	Else
		Price = (RScatalog_item("UnitPrice"))
	End If
%>

  <!-- Display number in currency format -->

  <B><%= FormatCurrency(Price)%></B>

  <%If (bOnSale) Then%>
    <IMG SRC="/AdvWorks/multimedia/images/saleTag1.gif" WIDTH=57 HEIGHT=32 ALIGN=CENTER ALT="On Sale"><BR>
    <% bOnSale = FALSE %>
  <%End If%>

  <A HREF="/AdvWorks/equipment/check_out.asp?ProductCode=<%=RScatalog_item("ProductCode")%>">
  <IMG SRC="/AdvWorks/multimedia/images/order.gif" WIDTH="55" HEIGHT="15" ALT="Order" BORDER=0></A>
  </FONT>
  </TD>

<%
	RScatalog_item.MoveNext
	If (ProductNumber MOD 2) then
		Response.Write "</TR><TR><TD HEIGHT=10></TD></TR>"  'break the row
	End If
Loop
%>

<!-- END data into interface -->

<% REM Column Span Value %>
<% HTML_CS = 5 %>
<% HTML_INDENT = FALSE %>

<!--#include virtual="/AdvWorks/Disclaim.inc"-->

</TABLE>
</BODY>
</HTML>
