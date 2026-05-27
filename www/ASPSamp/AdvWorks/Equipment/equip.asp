<%
Set Conn = Server.CreateObject("ADODB.Connection")
EquipmentType = Request.QueryString("EquipmentType")
SELECT CASE EquipmentType
CASE "Camping"
	EquipmentTypeTitle = "Camping Equipment"
	TitleGIF = "camping"
CASE "Climbing"
	EquipmentTypeTitle = "Climbing Equipment"
	TitleGIF = "climbing"
CASE "Clothing"
	EquipmentTypeTitle = "Clothing"
	TitleGIF = "clothing"
CASE ELSE
	Response.Redirect("/AdvWorks/Equipment/default.asp")
END SELECT
' The queries to return the best selling items by equipment type
' are encapsulated in stored procedures (or "querydefs" as they are called 
' in Microsoft Access).  There is one stored procedure for each equipment
' category.  The stored procedure name to invoke is the EquipmentType 
' plus the name "TopSales"
SQL = "{call " & EquipmentType & "TopSales}"
Conn.Open Session("ConnectionString")
Set RS = Conn.Execute(SQL)
%>

<HTML>
<HEAD>
<TITLE>Adventure Works Catalog - <%=EquipmentTypeTitle%></TITLE></HEAD>
<BODY BACKGROUND="/AdvWorks/multimedia/images/back_sub.gif" LINK="#800000" VLINK="#008040"> 
<FONT FACE="Verdana, Arial, Helvetica" SIZE=2>

<TABLE BORDER=0>
<TR>
<TD> 
<IMG SRC="/AdvWorks/multimedia/images/spacer.GIF" ALIGN=RIGHT WIDTH=100 ALT=""></TD>

<TD COLSPAN=5>
<IMG SRC="/AdvWorks/multimedia/images/title_<%=TitleGIF%>.GIF" ALIGN=CENTER BORDER=0 ALT="<%=EquipmentTypeTitle%>">
<BR>
<HR SIZE=4></TD></TR>

<!-- BEGIN Navigational buttons -->

<TR>
<TD ROWSPAN=4 ALIGN=LEFT VALIGN=TOP>
<!--#include virtual="/AdvWorks/Navbar2.inc"-->
<!--#include virtual="/AdvWorks/srcform.inc"-->
<BR>
<% If Session("ItemCount") > 0 Then %>
     <A HREF="/AdvWorks/equipment/check_out.asp">
     <IMG SRC="/AdvWorks/multimedia/images/checkout.gif" WIDTH="85" HEIGHT="45" ALT="Check Out" BORDER=O></A>
<% End If %>

</TD>

<!-- BEGIN data into interface -->

<% 
ProductNumber = 1
Do While Not RS.EOF
	If prodtype <> RS("ProductType") Then
		prodtype = RS("ProductType")
		ProductNumber = ProductNumber + 1
%>
<TD ALIGN=RIGHT VALIGN=TOP>
<IMG SRC="<%=RS("ProductImageURL")%>" ALT="<%=RS("ProductName")%>">
<CENTER>
<A HREF="/AdvWorks/equipment/catalog_type.asp?ProductType=<%=prodtype%>">
<IMG SRC="/AdvWorks/multimedia/images/more.gif" WIDTH="67" HEIGHT="21" ALT="More <%=prodtype%>" BORDER=0></A>
</CENTER>
</TD>

<TD ALIGN=LEFT VALIGN=TOP>
<% If MONTH(RS("ProductIntroductionDate")) > (MONTH(NOW)-1) Then%>
	<FONT COLOR="#800080" SIZE=2><B>New!</B></FONT><BR> 
<% End If%>

<FONT SIZE=2><B><%=RS("ProductName")%></B>,
<%=RS("ProductDescription")%><BR>

<% If Not IsNull(RS("ProductSize")) Then %>
	sizes <%=RS("ProductSize")%>
<%End If%>
<BR>
<%=RS("ProductCode")%>
<BR><BR>

<%
If RS("OnSale") Then
	bOnSale = TRUE
	Price = (RS("UnitPrice")-(RS("UnitPrice") / 10))
Else
	Price = (RS("UnitPrice"))
End If
%>

     <!-- Display number in currency format -->
<B><% = FormatCurrency(Price)%></B>
<% If (bOnSale) Then %>
	<IMG SRC="/AdvWorks/multimedia/images/saleTag1.gif" WIDTH="57" HEIGHT="32" ALIGN=CENTER ALT="On Sale"><BR>
<% bOnSale = FALSE %>
<% End If %>
<A HREF="/AdvWorks/equipment/check_out.asp?ProductCode=<%=RS("ProductCode")%>">
<IMG SRC="/AdvWorks/multimedia/images/order.gif" WIDTH="55" HEIGHT="15" ALT="Order" BORDER=0></A>
</FONT>
</TD>
<% 
If (ProductNumber MOD 2) Then
	Response.Write "</TR><TR><TD HEIGHT=10></TD></TR>"  'break the row
End If
  
End If

RS.MoveNext
Loop
Conn.Close
%>

<!-- END data into interface -->

<% REM Column Span Value %>
<% HTML_CS = 5 %>
<% HTML_INDENT = TRUE %>
<!--#include virtual="/AdvWorks/Disclaim.inc"-->

</TABLE>
</BODY>
</HTML>
