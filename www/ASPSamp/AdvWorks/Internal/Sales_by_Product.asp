<HTML>
<HEAD>
<TITLE>Adventure Works Sales by Product</TITLE></HEAD>
<BODY BACKGROUND="/AdvWorks/multimedia/images/back_sub.gif" LINK="#800000" VLINK="#008040"> 
<FONT FACE="Verdana, Arial, Helvetica" SIZE=2>

<TABLE WIDTH=600 BORDER=0>
<TR>
<TD>
<IMG SRC="/AdvWorks/multimedia/images/spacer.GIF" ALIGN=RIGHT WIDTH=110 ALT=""></TD>
<TD COLSPAN=3>
<FONT SIZE=4 FACE="Verdana, Arial, Helvetica" COLOR="#800000">Sales by Product</FONT>
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
Set RS = Conn.Execute("{Call SalesByProduct}")
TotalUnits = 0
TotalSales = 0
%>

<TABLE COLSPAN=8 CELLPADDING=5 BORDER=0>

<!-- BEGIN column header row -->

<TR>
<TD ALIGN=CENTER BGCOLOR="#800000">
<FONT STYLE="Verdana, Arial, Helvetica" COLOR="#ffffff" SIZE=2>Product Name</FONT>
</TD>
<TD ALIGN=CENTER BGCOLOR="#800000">
<FONT STYLE="Verdana, Arial, Helvetica" COLOR="#ffffff" SIZE=2>Total Units</FONT>
</TD>
<TD ALIGN=CENTER BGCOLOR="#800000">
<FONT STYLE="Verdana, Arial, Helvetica" COLOR="#ffffff" SIZE=2>Total Sales</FONT>
</TD>
</TR>

<!-- BEGIN first row of inserted product data -->

<% Do While Not RS.EOF %>
  <TR>
  <TD BGCOLOR="f7efde" ALIGN=CENTER>
  <FONT STYLE="Verdana, Arial, Helvetica" SIZE=2><%=RS("ProductName")%></FONT></TD>
  <TD BGCOLOR="f7efde" ALIGN=RIGHT>
  <FONT STYLE="Verdana, Arial, Helvetica" SIZE=2><%=FormatNumber(CDbl(RS("Total Units")),0)%></FONT></TD>
  <TD BGCOLOR="f7efde" ALIGN=RIGHT>
  <FONT STYLE="Verdana, Arial, Helvetica" SIZE=2><%=FormatCurrency(CDbl(RS("Total Sales")))%></FONT></TD>
  </TR>
<%
	TotalUnits = TotalUnits + RS("Total Units")
	TotalSales = TotalSales + RS("Total Sales")
	RS.MoveNext
Loop
Conn.Close
%>

<TR>
<TD ALIGN=CENTER BGCOLOR="#800000">
<FONT STYLE="Verdana, Arial, Helvetica" COLOR="#ffffff" SIZE=2>Grand Total</FONT>
</TD>
<TD ALIGN=RIGHT BGCOLOR="#800000">
<FONT STYLE="Verdana, Arial, Helvetica" COLOR="#ffffff" SIZE=2><%=FormatNumber(TotalUnits,0)%></FONT>
</TD>
<TD ALIGN=RIGHT BGCOLOR="#800000">
<FONT STYLE="Verdana, Arial, Helvetica" COLOR="#ffffff" SIZE=2><%=FormatCurrency(TotalSales)%></FONT>
</TD>
</TR>
</TABLE>

<BR>

<OBJECT
	classid="clsid:FC25B780-75BE-11CF-8B01-444553540000"
        CODEBASE="/AdvWorks/Controls/iechart.ocx"
	id=chart1
	WIDTH=500
	HEIGHT=200
	align=center
	hspace=0
	vspace=0
>
<param name="hgridStyle" value="3">
<param name="vgridStyle" value="0">
<param name="colorscheme" value="0">
<param name="DisplayLegend" value="1">
<param name="BackStyle" value="1">
<param name="BackColor" value="#800000">
<param name="ForeColor" value="#ffffff">
<param name="Scale" value="100">
<param name="url" value="/AdvWorks/internal/sales_by_product_graph.asp">

</OBJECT>
</FONT>
</TD>
</TR>

<% REM Column Span Value %>
<% HTML_CS = 3 %>
<% HTML_INDENT = FALSE %>

<!--#include virtual="/AdvWorks/Disclaim.inc"-->

</TABLE>
</BODY>
</HTML>