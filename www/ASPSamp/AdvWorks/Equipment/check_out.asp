<!--#include virtual="/AdvWorks/Cart.inc"-->
<%
iCount = Session("ItemCount")
ARYshoppingcart = Session("MyShoppingCart")
Set Conn = Server.CreateObject("ADODB.Connection")
	 
If Request.QueryString("ProductCode") <> "" Then
	If iCount < MaxShoppingCartItems Then
		iCount = iCount + 1
	End if
	Session("ItemCount") = iCount
	Conn.Open Session("ConnectionString")
	SQLcatalog_item = "SELECT ProductID, ProductCode, ProductName, ProductDescription, UnitPrice, OnSale FROM Products WHERE {fn UCASE(ProductCode)} = '" & Ucase(Request.QueryString("ProductCode")) & "'"
	Set RS = Conn.Execute(SQLcatalog_item)
	If Not IsEmpty(RS) Then
		ARYshoppingcart(cartCHECKED,iCount) = "CHECKED"
		ARYshoppingcart(cartProductCode,iCount) = RS("ProductCode")
		ARYshoppingcart(cartProductName,iCount) = RS("ProductName")
		ARYshoppingcart(cartProductDescription,iCount) = RS("ProductDescription")
		ARYshoppingcart(cartItemQuantity,iCount) = 1
		If RS("OnSale") Then
			ARYshoppingcart(cartUnitPrice,iCount) = RS("UnitPrice") - (RS("UnitPrice") * 0.1)
		Else
			ARYshoppingcart(cartUnitPrice,iCount) = RS("UnitPrice")
		End If
		ARYshoppingcart(cartProductID,iCount) = RS("ProductID")
		Session("MyShoppingCart") = ARYshoppingcart
		RS.Close
		Conn.Close
	End If
End If
  
SELECT CASE Request("Action")
   
CASE "Shop for More"
	For i = 1 to iCount       
		Quantity = Request("Quantity" & CStr(i))
		If IsNumeric(Quantity) Then
			ARYshoppingcart(cartItemQuantity,i) = abs(CLng(Quantity))
		Else
			ARYshoppingcart(cartItemQuantity,i) = 1
		End If
	Next
	Session("MyShoppingCart") = ARYshoppingcart
	Response.Redirect "/AdvWorks/equipment/default.asp"

CASE "Recalculate"
	For i = 1 to iCount       
		Quantity = Request("Quantity" & CStr(i))
		If IsNumeric(Quantity) Then
			ARYshoppingcart(cartItemQuantity,i) = abs(CLng(Quantity))
		Else
			ARYshoppingcart(cartItemQuantity,i) = 1
		End If
	Next
	For i = 1 to iCount
		If Request("Confirm" & CStr(i)) = "" Then
			iCount = iCount - 1
			For x = 1 to UBound(ARYshoppingcart,1)
				ARYshoppingcart(x,i) = ""
			Next
			n = i
			while n < UBound(ARYshoppingcart,2)
				For x = 1 to UBound(ARYshoppingcart,1)
					ARYshoppingcart(x,n) = ARYshoppingcart(x,n + 1)
					ARYshoppingcart(x,n + 1) = ""
				Next
				n = n + 1
			wend	
		End If
    Next
	Session("MyShoppingCart") = ARYshoppingcart
	Session("ItemCount") = iCount

CASE "Cancel Order"
	iCount = 0	
	Session("ItemCount") = iCount
	Response.Redirect "/AdvWorks/equipment/default.asp"

CASE "Click to Pay"
	Quantity = Request("Quantity" & CStr(i))
	If IsNumeric(Quantity) Then
		ARYshoppingcart(cartItemQuantity,i) = abs(CLng(Quantity))
	Else
		ARYshoppingcart(cartItemQuantity,i) = 1
	End If
	Session("MyShoppingCart") = ARYshoppingcart
		' Check if new customer
	CustomerID = Session("CustomerID")
	if CustomerID = 0 then ' new customer
		Response.Redirect "/AdvWorks/Equipment/GetCustomer.asp"
	else
		' First check to ensure that the customer was not removed from the database
		Conn.Open Session("ConnectionString")
		Set rs = Conn.Execute( _
			"select CompanyName FROM Customers where CustomerID = " & CustomerID & _
			" and ContactFirstName = '" & Session("CustomerFirstName") & "'")
		URL = "/AdvWorks/equipment/shipping.asp"
		If rs.EOF Then
			Session("CustomerID") = -1 ' This means the user WAS in the database at one time, but isn't now
			URL ="/AdvWorks/Equipment/GetCustomer.asp"
		End If
		rs.Close
		Conn.Close
		Response.Redirect URL
	End If
END SELECT
%>

<HTML>
<HEAD>
<TITLE>Adventure Works - Shopping Cart</TITLE>
</HEAD>

<BODY BACKGROUND="/AdvWorks/multimedia/images/back_sub.gif" LINK="#800000" VLINK="#008040"> 
<FONT FACE="Verdana, Arial, Helvetica" SIZE=2>


<TABLE BORDER=0>
<TR>
<TD WIDTH=30> 
<IMG SRC="/AdvWorks/multimedia/images/spacer.GIF" ALIGN=RIGHT ALT="">
</TD>

<TD COLSPAN=5>
<IMG SRC="/AdvWorks/multimedia/images/hd_Check_out.gif" width="250" height="42" ALT="Check Out">
<HR SIZE=4>
</TD>
</TR>

<!-- BEGIN Navigational buttons -->

<TR>
<TD ROWSPAN=20 ALIGN=LEFT VALIGN=TOP>
<IMG SRC="/AdvWorks/multimedia/images/spacer.gif" WIDTH=120 ALT="">
</TD>


<TD>

<!-- BEGIN table inserted into table data cell --><!-- BEGIN form with first row of data -->

<FORM ACTION="/AdvWorks/equipment/check_out.asp?" METHOD=POST>

<Table COLSPAN=8 CELLPADDING=5 BORDER=0>

<!-- BEGIN column header row -->

<TR>
<TD ALIGN=CENTER BGCOLOR="#800000">
<FONT STYLE="Verdana, Arial, Helvetica" COLOR="#ffffff" SIZE=2>Confirm</FONT>
</TD>
<TD ALIGN=CENTER BGCOLOR="#800000">
<FONT STYLE="Verdana, Arial, Helvetica" COLOR="#ffffff" SIZE=2>Product Code</FONT>
</TD>
<TD ALIGN=CENTER BGCOLOR="#800000">
<FONT STYLE="Verdana, Arial, Helvetica" COLOR="#ffffff" SIZE=2>Product Name</FONT>
</TD>
<TD ALIGN=CENTER WIDTH=150 BGCOLOR="#800000">
<FONT STYLE="Verdana, Arial, Helvetica" COLOR="#ffffff" SIZE=2>Description</FONT>
</TD>
<TD ALIGN=CENTER BGCOLOR="#800000">
<FONT STYLE="Verdana, Arial, Helvetica" COLOR="#ffffff" SIZE=2>Quantity</FONT>
</TD>
<TD ALIGN=CENTER BGCOLOR="#800000">
<FONT STYLE="Verdana, Arial, Helvetica" COLOR="#ffffff" SIZE=2>Unit Price</FONT>
</TD>
<TD ALIGN=CENTER BGCOLOR="#800000">
<FONT STYLE="Verdana, Arial, Helvetica" COLOR="#ffffff" SIZE=2>Unit Total</FONT>
</TD>
</TR>

<%
iSubtotal = 0
For i = 1 to iCount
%>

<!-- BEGIN first row of inserted product data -->
<TR>
<TD ALIGN=CENTER BGCOLOR="f7efde">
<%If ARYshoppingcart(cartCHECKED,i) = "CHECKED" Then%>
   <INPUT TYPE="CHECKBOX" NAME=<%Response.Write "Confirm" & CStr(i)%> VALUE="Confirmed" CHECKED> <%End If%>
</TD>
<TD BGCOLOR="f7efde" ALIGN=CENTER>
<FONT STYLE="Verdana, Arial, Helvetica" SIZE=2><%=ARYshoppingcart(cartProductCode,i)%></FONT>
</TD>
<TD BGCOLOR="f7efde" ALIGN=CENTER>
<FONT STYLE="Verdana, Arial, Helvetica" SIZE=2><%=ARYshoppingcart(cartProductName,i)%></FONT>
</TD>
<TD BGCOLOR="f7efde" ALIGN=LEFT WIDTH=150>
<FONT STYLE="Verdana, Arial, Helvetica" SIZE=2><%=ARYshoppingcart(cartProductDescription,i)%></FONT>
</TD>
<TD BGCOLOR="f7efde" ALIGN=CENTER>
<%If ARYshoppingcart(cartCHECKED,i) = "CHECKED" Then%>
   <FONT STYLE="Verdana, Arial, Helvetica" SIZE=2><INPUT TYPE=TEXT NAME=<%Response.Write "Quantity" & CStr(i)%> VALUE="<%=ARYshoppingcart(cartItemQuantity,i)%>" SIZE=2 MAXLENGTH=5></FONT>
<%End If%>
</TD>
<TD BGCOLOR="f7efde" ALIGN=RIGHT>
<FONT STYLE="Verdana, Arial, Helvetica" SIZE=2><% = FormatCurrency(ARYshoppingcart(cartUnitPrice,i))%></FONT>
</TD>
<TD BGCOLOR="f7efde" ALIGN=RIGHT>
<FONT STYLE="Verdana, Arial, Helvetica" SIZE=2><% = FormatCurrency(ARYshoppingcart(cartUnitPrice,i) * ARYshoppingcart(cartItemQuantity,i))%></FONT>
</TD>
</TR>

<%
If (ARYshoppingcart(cartUnitPrice,i)) <> "" Then
   iSubTotal = iSubtotal + (ARYshoppingcart(cartUnitPrice,i) * ARYshoppingcart(cartItemQuantity,i))
End If
Next
%>

<!-- BEGIN subtotal -->

<TR>
<TD COLSPAN=5></TD>
<TD BGCOLOR="f7efde" ALIGN=LEFT><FONT STYLE="Verdana, Arial, Helvetica" COLOR="#800000" SIZE=2>Subtotal:</FONT></TD>
<TD BGCOLOR="f7efde" ALIGN=RIGHT><FONT STYLE="Verdana, Arial, Helvetica" SIZE=2><% = FormatCurrency(iSubtotal)%></FONT></TD>
</TR>

<TR>
<TD ALIGN=RIGHT COLSPAN=3></TD>
<TD COLSPAN=5 ALIGN=RIGHT>

<% If iCount < MaxShoppingCartItems Then %>
   <INPUT TYPE=SUBMIT NAME="Action" VALUE="Shop for More">
<% End If %>
<% If iCount > 0 Then %>
   <INPUT TYPE=SUBMIT NAME="Action" VALUE="Click to Pay">
   <INPUT TYPE=SUBMIT NAME="Action" VALUE="Recalculate">
<% End If %>
<INPUT TYPE=SUBMIT NAME="Action" VALUE="Cancel Order">
</TD>
</TR>
</TABLE>
</FORM>

<!-- END table inserted into table data cell -->

</TD>

<% REM Column Span Value %>
<% HTML_CS = 5 %>
<% HTML_INDENT = FALSE %>
<!--#include virtual="/AdvWorks/Disclaim.inc"-->

<!--#include virtual="/AdvWorks/srcform.inc"-->


</TABLE>
</BODY>
</HTML>