<HTML>
<HEAD>
<TITLE>Adventure Works Customer Listing</TITLE></HEAD>
<BODY BACKGROUND="/AdvWorks/multimedia/images/back_sub.gif" LINK="#800000" VLINK="#008040"> 
<FONT FACE="Verdana, Arial, Helvetica" SIZE=2>


<TABLE WIDTH=600 BORDER=0>
<TR>
<TD>
<IMG SRC="/AdvWorks/multimedia/images/spacer.GIF" ALIGN=RIGHT WIDTH=110 ALT=""></TD>
<TD COLSPAN=3>
<FONT SIZE=4 FACE="Verdana, Arial, Helvetica" COLOR="#800000">Customer Listing</FONT>
<HR SIZE=4>
</TD>
</TR>

<!--Begin Navigational Buttons, using the NavBar include (inc.) file. 
This file will automatically place the navigational bar you see on the left-hand side of the screen-->
<TR>
<TD ROWSPAN=7 VALIGN=TOP ALIGN=LEFT>
<!--#include virtual="/AdvWorks/NavBar.inc"-->
</TD>

<TD VALIGN=TOP ALIGN=LEFT COLSPAN=3><FONT SIZE=2>


<FORM ACTION="/AdvWorks/ ........ " METHOD=POST>

<%
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open Session("ConnectionString")
Set RS = Conn.Execute("SELECT * FROM Customers")
%>

<TABLE COLSPAN=8 CELLPADDING=5 BORDER=0>

<!-- BEGIN column header row -->

<TR>
<TD ALIGN=CENTER BGCOLOR="#800000">
<FONT STYLE="Verdana, Arial, Helvetica" COLOR="#ffffff" SIZE=2>Company Name</FONT>
</TD>
<TD ALIGN=CENTER BGCOLOR="#800000">
<FONT STYLE="Verdana, Arial, Helvetica" COLOR="#ffffff" SIZE=2>Contact Name</FONT>
</TD>
<TD ALIGN=CENTER WIDTH=150 BGCOLOR="#800000">
<FONT STYLE="Verdana, Arial, Helvetica" COLOR="#ffffff" SIZE=2>E-mail address</FONT>
</TD>
<TD ALIGN=CENTER BGCOLOR="#800000">
<FONT STYLE="Verdana, Arial, Helvetica" COLOR="#ffffff" SIZE=2>City</FONT>
</TD>
<TD ALIGN=CENTER BGCOLOR="#800000">
<FONT STYLE="Verdana, Arial, Helvetica" COLOR="#ffffff" SIZE=2>State/Province</FONT>
</TD>
</TR>

<!-- BEGIN first row of inserted product data -->

<% Do While Not RS.EOF %>
	<TR>
	<TD BGCOLOR="f7efde" ALIGN=CENTER>
	<FONT STYLE="Verdana, Arial, Helvetica" SIZE=2><%=RS("CompanyName")%></FONT></TD>
	<TD BGCOLOR="f7efde" ALIGN=CENTER>
	<FONT STYLE="Verdana, Arial, Helvetica" SIZE=2><%=RS("ContactLastName") & ", " & RS("ContactFirstName")%></FONT></TD>
	<TD BGCOLOR="f7efde" ALIGN=CENTER>
	<FONT STYLE="Verdana, Arial, Helvetica" SIZE=2><A HREF="mailto:<%=RS("EmailAddress")%>"><%=RS("EmailAddress")%></A></FONT></TD>
	<TD BGCOLOR="f7efde" ALIGN=CENTER>
	<FONT STYLE="Verdana, Arial, Helvetica" SIZE=2><%=RS("City")%></FONT></TD>
	<TD BGCOLOR="f7efde" ALIGN=CENTER>
	<FONT STYLE="Verdana, Arial, Helvetica" SIZE=2><%=RS("StateOrProvince")%></FONT></TD>
	</TR>
<%
	RS.MoveNext
Loop
RS.Close
Conn.Close
Set RS = Nothing
%>

</TABLE>
</TD>
</TR>


<% REM Column Span Value %>
<% HTML_CS = 3 %>
<% HTML_INDENT = FALSE %>
<!--#include virtual="/AdvWorks/Disclaim.inc"-->
</TABLE>
</BODY>
</HTML>