<HTML>
<HEAD>
<TITLE>Adventure Works Excursions</TITLE></HEAD>

<BODY BACKGROUND="/AdvWorks/multimedia/images/back_sub.gif" LINK="#800000" VLINK="#008040"> 
<FONT FACE="Verdana, Arial, Helvetica">

<TABLE WIDTH=600 BORDER=0>
<TR>
<TD>
<IMG SRC="/AdvWorks/multimedia/images/spacer.GIF" ALIGN=RIGHT WIDTH=110 ALT=""></TD>
<TD COLSPAN=3>
<IMG SRC="/AdvWorks/Multimedia/Images/hd_excursions.gif" WIDTH="187" HEIGHT="42" ALIGN=center BORDER=0 ALT="Excursions"><BR>
<HR SIZE=4>
</TD>
</TR>

<!--Begin Navigational Buttons, using the NavBar include (inc.) file. 
This file will automatically place the navigational bar you see on the left-hand side of the screen-->

<TR>
<TD ROWSPAN=7 VALIGN=TOP ALIGN=LEFT>
<!--#include virtual="/AdvWorks/NavBar.inc"-->
</TD>

<TD COLSPAN=3 VALIGN=TOP ALIGN=LEFT>
<FONT SIZE=2 FACE="Verdana, Arial, Helvetica">
Adventure Works' excursions cover the globe. Click the mountain you want to climb, for a wealth of information, including links to route descriptions, trip reports, and maps of the surrounding areas. Adventure Works can take you there!
<P>
</FONT>
</TD>
</TR>

<TR>
<TD COLSPAN=3 HEIGHT=10>
<IMG SRC="/AdvWorks/multimedia/images/spacer.gif" ALT="">
</TD>
</TR>

<TR>
<TD VALIGN=TOP>
<STRONG>
<FONT SIZE=4 FACE="Verdana, Arial, Helvetica">
<IMG SRC="/AdvWorks/Multimedia/Images/bullet.gif" WIDTH="25" HEIGHT="25" ALIGN=CENTER ALT="Bullet">
<A HREF="/AdvWorks/excursions/Alaska.asp">Alaska - Mt. McKinley</A>
<P>

<IMG SRC="/AdvWorks/Multimedia/Images/bullet.gif" WIDTH="25" HEIGHT="25" ALIGN=CENTER ALT="Bullet">
<A HREF="/AdvWorks/excursions/washington.asp">Washington - Mt. Rainier</A>
<P>

<IMG SRC="/AdvWorks/Multimedia/Images/bullet.gif" WIDTH="25" HEIGHT="25" ALIGN=CENTER ALT="Bullet">
<A HREF="/AdvWorks/excursions/patagonia.asp">Argentina - Patagonia</A>
<P>
</TD>
</TR>


<TR>
<TD>
<IMG SRC="/AdvWorks/multimedia/images/spacer.gif" HEIGHT=10 BORDER=0 ALT="">
</TD>
</TR>

<!-- 
BEGIN advertisement.  If Browser supports ActiveX controls and is running on intel,
then use the client side ad rotator, otherwise use the server side ad rotator.
 -->

<TR>
<TD VALIGN=TOP ALIGN=LEFT>
<% 
Set OBJbrowser = Server.CreateObject("MSWC.BrowserType")
If OBJbrowser.ActiveXControls = TRUE and Request.ServerVariables("HTTP_UA_CPU") = "x86" Then
%>
	<OBJECT CODEBASE="/AdvWorks/Controls/nboard.cab#version=5,0,0,5"
		WIDTH=460
		HEIGHT=60
		DATA="/AdvWorks/Controls/billboard.ods"
		CLASSID="clsid:6059B947-EC52-11CF-B509-00A024488F73">
	</OBJECT>
	<FONT FACE="Verdana, Arial, Helvetica" SIZE=1><CENTER>
	Billboard control provided by NCompass.  Not for distribution, production, or commercial use.<P>
	</FONT></CENTER>
<% 
Else
	Set Ad = Server.CreateObject("MSWC.Adrotator")
	Response.Write(Ad.GetAdvertisement("/AdvWorks/adrot.txt"))
End If
%>
</TD>
</TR>
<!-- END advertisement -->

<% REM Column Span Value %>
<% HTML_CS = 3 %>
<% HTML_INDENT = FALSE %>
<!--#include virtual="/AdvWorks/Disclaim.inc"-->

</TABLE>
</BODY>
</HTML>
