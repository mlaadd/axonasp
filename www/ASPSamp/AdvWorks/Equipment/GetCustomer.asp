<SCRIPT LANGUAGE=VBScript RUNAT=Server>
FUNCTION CheckString (s, endchar)
	pos = InStr(s, "'")
	While pos > 0
		s = Mid(s, 1, pos) & "'" & Mid(s, pos + 1)
		pos = InStr(pos + 2, s, "'")
	Wend
   CheckString="'" & s & "'" & endchar
END FUNCTION
</SCRIPT>
<%
msg=""
Action = Left(UCase(Request("Action")),5)

' Do Some form validation
If Action = "ENTER" Then
	If Request("CompanyName") = "" OR _
		Request("ContactFirstName") = "" OR _
		Request("ContactLastName") = "" OR _
		Request("BillingAddress") = "" OR _
		Request("City") = "" OR _
		Request("StateOrProvince") = "" OR _
		Request("PostalCode") = "" OR _
		Request("Country") = "" OR _
		Request("PhoneNumber") = "" OR _
		Request("EmailAddress") = "" OR _
		Request("LevelOfExperience") = "" Then
			msg="<B><I>All fields must have a valid non-empty response.</I></B>"
	End If

' The form is valid and no missing fields
	If msg = "" Then
		sql = "insert into Customers (" &_
				"CompanyName, " &_
				"ContactFirstName, " &_
				"ContactLastName, " &_
				"BillingAddress, " &_
				"City, " &_
				"StateOrProvince, " &_
				"PostalCode, " &_
				"Country, " &_
				"PhoneNumber, " &_
				"EmailAddress, " &_
				"LevelOfExperience) " &_
				"VALUES ( "
		sql = sql & CheckString(Request("CompanyName"),",")
		sql = sql & CheckString(Request("ContactFirstName"),",")
		sql = sql & CheckString(Request("ContactLastName"),",")
		sql = sql & CheckString(Request("BillingAddress"), ",")
		sql = sql & CheckString(Request("City"), ",")
		sql = sql & CheckString(Request("StateorProvince"), ",")
		sql = sql & CheckString(Request("PostalCode"), ",")
		sql = sql & CheckString(Request("Country"), ",")
		sql = sql & CheckString(Request("PhoneNumber"), ",")
		sql = sql & CheckString(Request("EmailAddress"), ",")
		sql = sql & CheckString(Request("LevelOfExperience"), ")")
		Set Conn = Server.CreateObject("ADODB.Connection")
		Conn.Open Session("ConnectionString")
		Conn.Execute(sql)
			' For SQL Server, it is much more efficient to use the identity built in
			' variable @@identity.
		sql = "select @@identity"
			' For MS Access and other databases, use the max value just inserted.  For
			' SQL Server, comment out the following line.
		sql = "select max(CustomerID) from Customers"
		set rs = Conn.Execute(sql)
		CustomerID = CLng(rs(0))
		rs.Close
		Conn.Close
			
		Session("CustomerID")= CustomerID
		Session("CustomerFirstName") = Request("ContactFirstName").Item
		Response.Cookies("CustomerFirstName")         = Request("ContactFirstName")
		Response.Cookies("CustomerFirstName").Expires = Date+365
		Response.Cookies("CustomerFirstName").Path    = "/AdvWorks"
		Response.Cookies("CustomerID")                = CustomerID
		Response.Cookies("CustomerID").Expires        = Date+365
		Response.Cookies("CustomerID").Path           = "/AdvWorks"
		Response.Redirect "/AdvWorks/Equipment/Shipping.asp"
	End If  'msg = ""
End If  'Action = "ENTER"
%>


<HTML>
<HEAD>
<TITLE>Adventure Works Sign Up Page</TITLE></HEAD>
<BODY BACKGROUND="/AdvWorks/multimedia/images/back_sub.gif" LINK="#800000" VLINK="#008040"> 
<FONT FACE="Verdana, Arial, Helvetica" SIZE=2>

<TABLE WIDTH=600 BORDER=0>
<TR>
<TD>
<IMG SRC="/AdvWorks/multimedia/images/spacer.GIF" ALIGN=RIGHT WIDTH=100 ALT=""></TD>
<TD COLSPAN=5>
<IMG SRC="/AdvWorks/multimedia/images/hd_sign_up.gif" WIDTH="133" HEIGHT="42" ALT="Sign Up"><BR>
<HR SIZE=4>
</TD>
</TR>

<TR>
<TD ROWSPAN=4 ALIGN=RIGHT VALIGN=TOP>
<IMG SRC="/AdvWorks/multimedia/images/spacer.gif" WIDTH=120 HEIGHT=350 ALIGN=RIGHT ALT="">
</TD>
<TD VALIGN=TOP ALIGN=LEFT>
<FONT SIZE=2 FACE="Verdana, Arial, Helvetica">
<%
ContactFirstName = Request("ContactFirstName")
' Check to see if this is a customer that got deleted from the database.   If so
' they need to fill in the information again
if Session("CustomerID") = -1 then
  Response.Write "<I><B>" & Session("CustomerFirstName") & "</B>, we need to update your information in our database</I><P>"
  ContactFirstName = Session("CustomerFirstName")
end if
%>
So that we can service you better, please, take some time now to fill out the
following form.</FONT>
<P>
</TR>

<TR>
<TD>
<!-- BEGIN Application Form -->

<FORM ACTION="/AdvWorks/equipment/GetCustomer.asp" METHOD=POST>
<% = msg %>
<!-- BEGIN column header row -->
<TABLE CELLPADDING=5 COLSPAN=2>
<TR>
<TD WIDTH=310 BGCOLOR="#800000"><FONT COLOR="#FFFFFF" STYLE="Verdana, Arial, Helvetica" SIZE=2>Personal Information</FONT></TD>
<TD WIDTH=310 BGCOLOR="#800000"><FONT COLOR="#FFFFFF" STYLE="Verdana, Arial, Helvetica" SIZE=2>Miscellaneous Information</FONT></TD>
</TR>
<TD BGCOLOR="f7efde" VALIGN=TOP>
<FONT SIZE=2>
First Name: <INPUT TYPE="Text" NAME="ContactFirstName" VALUE="<%=ContactFirstName%>" SIZE=31 MAXLENGTH=35><P>
Last Name: <INPUT TYPE="Text" NAME="ContactLastName" VALUE="<%=Request("ContactLastName")%>" SIZE=31 MAXLENGTH=35><P>
Company: <INPUT TYPE="Text" NAME="CompanyName" VALUE="<%=Request("CompanyName")%>" SIZE=31 MAXLENGTH=35><P>
Address: <INPUT TYPE="Text" NAME="BillingAddress" VALUE="<%=Request("BillingAddress")%>" SIZE=36 MAXLENGTH=36>
<TABLE>
<TR>
<TD><FONT SIZE=2>City:</FONT></TD><TD><FONT SIZE=2>State:</FONT></TD><TD><FONT SIZE=2>Postal Code:</FONT></TD>
</TR>
<TR>
<TD>
<INPUT TYPE="Text" NAME="City" VALUE="<%=Request("City")%>" Size=8>
</TD>
<TD>
<INPUT TYPE="Text" NAME="StateOrProvince" VALUE="<%=Request("StateOrProvince")%>" Size=2>
</TD>
<TD>
<INPUT TYPE="Text" NAME="PostalCode" VALUE="<%=Request("PostalCode")%>" Size=5>
</TD>
</TR>
</TABLE>
Phone:<BR> <INPUT TYPE="Text" NAME="PhoneNumber" VALUE="<%=Request("PhoneNumber")%>" Size=21><BR>
Country:<BR> <INPUT TYPE="Text" NAME="Country" VALUE="<%=Request("Country")%>" Size=21><BR>
</FONT>
</TD>

<TD BGCOLOR="f7efde" VALIGN=TOP>
<FONT SIZE=2>
Level of Experience: 
<SELECT NAME="LevelOfExperience" SIZE="1">
<OPTION>N/A
<OPTION>Beginner
<OPTION>Intermediate
<OPTION>Advanced
</SELECT><P>
Email Address: <BR> <INPUT TYPE="Text" NAME="EmailAddress" VALUE="<%=Request("EmailAddress")%>" Size=35><P> 
</FONT>
</TD>
</TR>
<TR>
<TD><INPUT TYPE=SUBMIT NAME="Action" VALUE="Enter Customer Info"></TD>
</TR>
</TABLE>
</FORM>
</TR>
<!-- END Application Form -->

<% REM Column Span Value %>
<% HTML_CS = 3 %>
<% HTML_INDENT = FALSE %>

<!--#include virtual="/AdvWorks/srcform.inc"-->

<!--#include virtual="/AdvWorks/Disclaim.inc"-->

</TABLE>
</BODY>
</HTML>