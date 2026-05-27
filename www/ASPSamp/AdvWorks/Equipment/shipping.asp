<%
CustomerID = CLng(Session("CustomerID"))
if CustomerID = 0 then ' new customer
	Response.Redirect "/AdvWorks/Equipment/GetCustomer.asp"
End If
%>

<!--#include virtual="/AdvWorks/Cart.inc"-->

<SCRIPT LANGUAGE=VBScript RUNAT=Server>
FUNCTION CheckString (s, endchar)
	pos = InStr(s, "'")
	While pos > 0
		s = Mid(s, 1, pos) & "'" & Mid(s, pos + 1)
		pos = InStr(pos + 2, s, "'")
	Wend
	CheckString="'" & s & "'" & endchar
END FUNCTION

'Function ReplaceComma handles currency formatting styles which use a comma for the decimal point
FUNCTION ReplaceComma (s)
	pos = InStr(s, ",")
	if pos > 0 then
		s = Mid(s, 1, pos - 1) & "." & Mid(s, pos + 1)
	end if
	ReplaceComma = s
END FUNCTION
</SCRIPT>

<%
' Get session variables
ARYshoppingcart = Session("MyShoppingCart")
iCount = Session("ItemCount")
Set Conn = Server.CreateObject("ADODB.Connection")
msg=""
DateErrorMsg = "<TT><B><I>An valid Expiration Date (MM/YY greater than today's date) is required</I></B></TT><BR>"
Action = Left(UCase(Request("Action")),5)
If Action = "ORDER" Then
	' First do some validation on the entries
	If Len(Request("CreditCardNumber")) < 8 Then
		msg="<TT><B><I>Credit Card number must have at least 8 digits</I></B></TT><BR>"
	elseif NOT IsDate(Request("ExpDate")) then
		msg = DateErrorMsg
	elseif CDate(Request("ExpDate")) < now then
		msg = DateErrorMsg
	End If
	
	If Request("ShipName") = "" OR _
		Request("ShipContactFirstName") = "" OR _
		Request("ShipContactLastName") = "" OR _
		Request("ShipAddress") = "" OR _
		Request("ShipCity") = "" OR _
		Request("ShipState") = "" OR _
		Request("ShipPostalCode") = "" OR _
		Request("ShipCountry") = "" OR _
		Request("ShipPhoneNumber") = "" Then
			msg = msg & "<TT><B><I>All fields must have a valid non-empty response.</I></B></TT><BR>"
	End If


	If msg = "" Then  'No errors -- insert into database
		sql = "INSERT INTO Orders(CustomerID, EmployeeID, OrderDate, ShipName, "
		sql = sql & "ShipContactFirstName, ShipContactLastName, ShipAddress, ShipCity, "
		sql = sql & "ShipStateOrProvince, ShipPostalCode, ShipCountry, ShipPhoneNumber, "
		sql = sql & "ShipDate, ShippingMethodID, FreightCharge, SalesTaxRate) "
		sql = sql & "VALUES( "
		sql = sql & Request("CustomerID")
		sql = sql & ", 6, "
		sql = sql & "{fn now()},"
		sql = sql & CheckString(Request("ShipName"),",")
		sql = sql & CheckString(Request("ShipContactFirstName"),",")
		sql = sql & CheckString(Request("ShipContactLastName"),",")
		sql = sql & CheckString(Request("ShipAddress"), ",")
		sql = sql & CheckString(Request("ShipCity"), ",")
		sql = sql & CheckString(Request("ShipState"), ",")
		sql = sql & CheckString(Request("ShipPostalCode"), ",")
		sql = sql & CheckString(Request("ShipCountry"), ",")
		sql = sql & CheckString(Request("ShipPhoneNumber"), ",")
		sql = sql & "{fn now()}, "
		sql = sql & Request("ShippingMethod") & ", " 
		sql = sql & ReplaceComma(Request("FreightCharge")) & ", " 
		sql = sql & ReplaceComma(Request("SalesTaxRate")) & ")"
			
		Conn.Open Session("ConnectionString")
		Conn.Execute(sql)
			' Select the identity column if using SQL Server.  This is much more
			' efficient than selecting the max orderid, and is not subject to
			' concurrency problems.
		sql = "select @@identity"
			' Use the following statement if the target database is Access or
			' something other than SQL Server.  NOTE:  it is not guaranteed 
			' that this will return the Order just created if there is high
			' concurrency on the site
		sql = "select max(OrderID) from Orders"
		set rs = Conn.Execute(sql)
		OrderID = rs(0)
		rs.Close

			' Generate Order Detail record for each item in shopping cart
		For i = 1 to iCount
			sql = "INSERT INTO Order_Details(OrderID, ProductID, Quantity, UnitPrice, Discount) "           
			sql = sql & "VALUES( "
		    sql = sql & OrderID & ","
			sql = sql & ARYshoppingcart(cartProductID,i) & ","
			sql = sql & ARYshoppingcart(cartItemQuantity,i) & ","
			sql = sql & ReplaceComma(ARYshoppingcart(cartUnitPrice,i)) & ","
			sql = sql & "0)"
			Conn.Execute(sql)
		Next

			' Generate Payment record
		sql = "INSERT INTO Payments(OrderID, PaymentAmount, PaymentDate, CreditCardNumber, CreditCardExpDate, PaymentMethodID) " 
		sql = sql & "VALUES( "
		sql = sql & OrderID & ","
		sql = sql & ReplaceComma(Request("PaymentAmount")) & ","
		sql = sql & "{fn now()},"
    	sql = sql & "'" & Request("CreditCardNumber") & "',"
		sql = sql & "'" & CDate(Request("ExpDate")) & "',"
		sql = sql & "2)"
		Conn.Execute(sql)
	
		Session("ItemCount") = 0
		Conn.Close
		Response.Redirect "/AdvWorks/equipment/congratulations.asp"
	End If  'msg = ""
Elseif Action = "CANCE" Then
	Session("ItemCount") = 0
	Response.Redirect "/AdvWorks/default.asp"
End If
%>

<HTML>
<HEAD>
<TITLE>Payment and Shipping</TITLE></HEAD>
<BODY BACKGROUND="/AdvWorks/multimedia/images/back_sub.gif" LINK="#800000" VLINK="#008040"> 
<FONT FACE="Verdana, Arial, Helvetica" SIZE=2>

<TABLE WIDTH=600 BORDER=0>
<TR>
<TD> 
<IMG SRC="/AdvWorks/multimedia/images/spacer.GIF" ALIGN=RIGHT WIDTH=100 ALT=""></TD>
<TD COLSPAN=5>
<IMG SRC="/AdvWorks/multimedia/images/hd_payment_and_shipping.gif" WIDTH="364" HEIGHT="42" ALT="Payment and Shipping">
<BR>
<HR SIZE=4></TD></TR>

<!-- BEGIN sidebar navigation -->

<TR>
<TD ROWSPAN=4 ALIGN=RIGHT VALIGN=TOP>
<IMG SRC="/AdvWorks/multimedia/images/spacer.gif" WIDTH=120 HEIGHT=350 ALIGN=RIGHT ALT=""></TD>
<TD>

<!-- BEGIN table inserted into table data cell -->
<!-- BEGIN form with first row of data -->

<FORM ACTION="/AdvWorks/equipment/shipping.asp?" METHOD=POST>

<!-- BEGIN column header row -->
<% = msg %>
<TABLE CELLPADDING=5 COLSPAN=2>
<TR>
<TD WIDTH=310 BGCOLOR="#800000"><FONT COLOR="#FFFFFF" STYLE="Verdana, Arial, Helvetica" SIZE=2>Shipping</FONT></TD>
<TD WIDTH=310 BGCOLOR="#800000"><FONT COLOR="#FFFFFF" STYLE="Verdana, Arial, Helvetica" SIZE=2>Payment</FONT></TD>
</TR>

<TD BGCOLOR="f7efde" VALIGN=TOP>
<FONT SIZE=2>
<% 
Conn.Open Session("ConnectionString")
set rs = Conn.Execute("select * from Customers where CustomerID = " & CustomerID) 
%>
First Name: <INPUT TYPE="Text" NAME="ShipContactFirstName" VALUE="<%=rs("ContactFirstName")%>" SIZE=31 MAXLENGTH=35><P>
Last Name: <INPUT TYPE="Text" NAME="ShipContactLastName" VALUE="<%=rs("ContactLastName")%>" SIZE=31 MAXLENGTH=35><P>
Company: <INPUT TYPE="Text" NAME="ShipName" VALUE="<%=rs("CompanyName")%>" SIZE=31 MAXLENGTH=35><P>
Address: <INPUT TYPE="Text" NAME="ShipAddress" VALUE="<%=rs("BillingAddress")%>"SIZE=36 MAXLENGTH=36><P>
City:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbspState:&nbsp&nbsp&nbspPostal&nbspCode:<BR>
<INPUT TYPE="Text" NAME="ShipCity" VALUE="<%=rs("City")%>"Size=8>
<INPUT TYPE="Text" NAME="ShipState" VALUE="<%=rs("StateOrProvince")%>"Size=2>
<INPUT TYPE="Text" NAME="ShipPostalCode" VALUE="<%=rs("PostalCode")%>"Size=5><P>
Country: <INPUT TYPE="Text" NAME="ShipCountry" VALUE="<%=rs("Country")%>" Size=21>
Phone: <INPUT TYPE="Text" NAME="ShipPhoneNumber" VALUE="<%=rs("PhoneNumber")%>" Size=21>
<INPUT TYPE="HIDDEN" NAME="CustomerID" VALUE="<%=rs("CustomerID")%>">
<% rs.Close %>
</FONT>
</TD>

<TD BGCOLOR="f7efde" VALIGN=TOP>
<FONT SIZE=2>
Credit Card:
<BR>
<SELECT NAME="Credit Card">
<OPTION value="--------">VISA
<OPTION value="--------">Master Card
<OPTION value="--------">American Express
<OPTION value="--------">Discover
</SELECT><P>

Credit Card #: <INPUT TYPE="Text" NAME="CreditCardNumber" VALUE="<%=Request("CreditCardNumber")%>" Size=35><P> 
Expiration Date:<BR> <INPUT TYPE="Text" NAME="ExpDate" VALUE="<%=Request("ExpDate")%>" Size=8>  
<P>
Shipping Method:<BR>
<% 
Set rs = Conn.Execute("select * from Shipping_Methods")
Checked = " checked>"
do while not rs.eof
	Response.Write "<input type=radio name=ShippingMethod value=" & rs("ShippingMethodID") & Checked & rs("ShippingMethod") & "<BR>"
	Checked = ">"
	rs.MoveNext
loop
rs.Close
Conn.Close
%>
<HR>
</FONT>
</TD>
</TR>
</TABLE>

<!-- BEGIN new table with summary of order -->

<P>

<Table COLSPAN=7 CELLPADDING=5 BORDER=0>

<!-- BEGIN column header row -->

<TR>
<TD ALIGN=CENTER BGCOLOR="#800000">
<FONT COLOR="#ffffff" SIZE=2>Product Code</FONT>
</TD>
<TD ALIGN=CENTER BGCOLOR="#800000">
<FONT COLOR="#ffffff" SIZE=2>Product Name</FONT>
</TD>
<TD ALIGN=CENTER WIDTH=150 BGCOLOR="#800000">
<FONT COLOR="#ffffff" SIZE=2>Description</FONT>
</TD>
<TD ALIGN=CENTER BGCOLOR="#800000" WIDTH=75>
<FONT COLOR="#ffffff" SIZE=2>Quantity</FONT>
</TD>
<TD ALIGN=CENTER BGCOLOR="#800000" WIDTH=75>
<FONT COLOR="#ffffff" SIZE=2>Price</FONT>
</TD>
</TR>

<!-- BEGIN row of inserted product data -->
<%
iSubtotal = 0
For i = 1 to iCount
%>

<TR>
<TD BGCOLOR="f7efde" ALIGN=CENTER>
<FONT SIZE=2><%=ARYshoppingcart(cartProductID,i)%></FONT>
</TD>
<TD BGCOLOR="f7efde" ALIGN=CENTER>
<FONT SIZE=2><%=ARYshoppingcart(cartProductName,i)%></FONT>
</TD>
<TD BGCOLOR="f7efde" ALIGN=LEFT WIDTH=150>
<FONT SIZE=2><%=ARYshoppingcart(cartProductDescription,i)%></FONT>
</TD>
<TD BGCOLOR="f7efde" ALIGN=CENTER>
<FONT SIZE=2><%=ARYshoppingcart(cartItemQuantity,i)%></FONT>
</TD>
<TD BGCOLOR="f7efde" ALIGN=RIGHT>
<FONT SIZE=2><% = FormatCurrency(ARYshoppingcart(cartUnitPrice,i)) %></FONT>
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
<TD COLSPAN=3></TD>
<TD COLSPAN=1 BGCOLOR="f7efde" ALIGN=RIGHT><FONT COLOR="#800000" SIZE=2>Subtotal:</FONT></TD>
<TD BGCOLOR="f7efde" ALIGN=RIGHT><FONT SIZE=2><%=FormatCurrency(iSubTotal)%></FONT></TD>
</TR>

<!-- BEGIN tax -->
<%iTaxRate = 0.08 %>
<%iTax = iSubTotal * iTaxRate%>
<TR>
<TD COLSPAN=3></TD>
<TD COLSPAN=1 BGCOLOR="f7efde" ALIGN=RIGHT><FONT COLOR="#800000" SIZE=2>Tax (8%):</FONT></TD>
<TD BGCOLOR="f7efde" ALIGN=RIGHT><FONT SIZE=2><%=FormatCurrency(iTax)%></FONT></TD>
</TR>

<!-- BEGIN shipping and handling -->
<%iShipping = iSubTotal * 0.1%>
<TR>
<TD COLSPAN=3></TD>
<TD COLSPAN=1  BGCOLOR="f7efde" ALIGN=RIGHT><FONT COLOR="#800000" SIZE=2>Shipping and Handling:</FONT></TD>
<TD BGCOLOR="f7efde" ALIGN=RIGHT><FONT SIZE=2><%=FormatCurrency(iShipping)%></FONT></TD></TR>

<!-- BEGIN grand total -->
<% iGrandTotal = iSubTotal + iTax + iShipping%>
<TR>
<TD COLSPAN=3></TD>
<TD COLSPAN=1 BGCOLOR="f7efde" ALIGN=RIGHT><FONT COLOR="#800000" SIZE=2>Grand Total:</FONT></TD>
<TD BGCOLOR="f7efde" ALIGN=RIGHT><FONT SIZE=2><%=FormatCurrency(iSubTotal + iTax + iShipping)%></FONT></TD>
</TR>

<!-- BEGIN Order Now! and Cancel buttons -->
<TR>
<TD ALIGN=LEFT COLSPAN=3></TD>
<TD COLSPAN=2 BGCOLOR="#ffffff" ALIGN=RIGHT>
<INPUT TYPE=HIDDEN NAME="FreightCharge" VALUE=<%=iShipping%>>
<INPUT TYPE=HIDDEN NAME="SalesTaxRate" VALUE=<%=iTaxRate%>>
<INPUT TYPE=HIDDEN NAME="PaymentAmount" VALUE=<%=iGrandTotal%>>
<INPUT TYPE=SUBMIT NAME="Action" VALUE="Order Now!">
<INPUT TYPE=SUBMIT NAME="Action" VALUE="Cancel">
</TD>
</TR>
</TABLE>

<!-- END table inserted into table data cell -->

</FORM>
</TD>

<% REM Column Span Value %>
<% HTML_CS = 5 %>
<% HTML_INDENT = FALSE %>

<!--#include virtual="/AdvWorks/Disclaim.inc"-->
<!--#include virtual="/AdvWorks/srcform.inc"-->
</TABLE>
</BODY>
</HTML>