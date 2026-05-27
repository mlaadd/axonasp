<HTML>
<HEAD>
<TITLE>Adventure Works Base Camp</TITLE></HEAD>

<BODY BACKGROUND="/AdvWorks/multimedia/images/back_sub.gif" LINK="#800000" VLINK="#008040"> 
<FONT FACE="Verdana, Arial, Helvetica" SIZE=2>
<BGSOUND SRC="/AdvWorks/multimedia/audio/cricfrg2.wav">

<TABLE WIDTH=600 BORDER=0>
<TR>
<TD><IMG SRC="/AdvWorks/multimedia/images/spacer.GIF" ALIGN=RIGHT WIDTH=110 ALT=""></TD>
<TD COLSPAN=3>
<IMG SRC="/AdvWorks/Multimedia/Images/BaseCComp.jpg" WIDTH="465" HEIGHT="146" ALIGN=center BORDER=0 ALT="Base Camp"><BR>
<HR SIZE=4>
</TD>
</TR>

<!--Begin Navigational Buttons, using the NavBar include (inc.) file. 
This file will automatically place the navigational bar you see on the left-hand side of the screen-->

<TR>
<TD ROWSPAN=4 VALIGN=TOP ALIGN=LEFT>

<!--#include virtual="/AdvWorks/NavBar.inc"-->
</TD>

<TD VALIGN=TOP ALIGN=LEFT>
<STRONG>
<FONT FACE="Verdana, Arial, Helvetica" SIZE=4>

<A HREF="/AdvWorks/excursions/excursions.asp">
<IMG SRC="/AdvWorks/Multimedia/Images/bullet.gif" WIDTH="25" HEIGHT="25" ALIGN=MIDDLE BORDER=0 ALT="Bullet">Excursions</A>
</FONT>
</TD>
</TR>


<TR>
<TD>
<IMG SRC="/AdvWorks/multimedia/images/spacer.gif" HEIGHT=10 ALT="">
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