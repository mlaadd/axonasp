<HTML>
<HEAD>
<TITLE>Adventure Works Excursions - Washington</TITLE></HEAD>
<BODY BACKGROUND="/AdvWorks/multimedia/images/back_sub.gif" LINK="#800000" VLINK="#008040"> 
<FONT FACE="Verdana, Arial, Helvetica" SIZE=2>

<TABLE WIDTH=600 BORDER=0>
<TR>
<IMG SRC="/AdvWorks/multimedia/images/spacer.GIF" WIDTH=110 ALT=""></TD>
<TD COLSPAN=3>
<IMG SRC="/AdvWorks/Multimedia/Images/bc_title_washington.gif" WIDTH="199" HEIGHT="42" ALIGN=center BORDER=0 ALT="Washington"><BR>
<HR SIZE=4></TD></TR>

<!--Begin Navigational Buttons, using the NavBar include (inc.) file. 
This file will automatically place the navigational bar you see on the left-hand side of the screen-->

<TR>
<TD ROWSPAN=20 VALIGN=TOP ALIGN=LEFT>
<!--#include virtual="/AdvWorks/NavBar.inc"-->

<!--Begin code for creating navigational arrows to cycle through the Excursion pages-->
<% Set OBJnextlink = Server.CreateObject("MSWC.NextLink") %>

<IMG SRC="/AdvWorks/multimedia/images/icon_arrows_both_ways.GIF" ALIGN=CENTER BORDER=0 USEMAP="#ARROWS" ALT="Arrows"></A><BR>

<MAP NAME="ARROWS">
<AREA SHAPE="RECT" COORDS="0,0 46,45" HREF="<%=OBJnextlink.GetPreviousURL ("/AdvWorks/excursions/nextlink.txt")%>">
<AREA SHAPE="RECT" COORDS="48,1 85,45" HREF="<%=OBJnextlink.GetNextURL ("/AdvWorks/excursions/nextlink.txt")%>">
</MAP>
</TD>

<!-- -------------------------------------------- -->

<TD WIDTH=220 VALIGN=TOP ALIGN=RIGHT>
<IMG SRC="/AdvWorks/multimedia/images/map_washington2.gif" WIDTH="220" HEIGHT="220" ALT="Washington">
</TD>

<TD WIDTH=380 ALIGN=LEFT><FONT SIZE=2>
<strong>Where:</strong>&nbsp;&nbsp;Mt. Rainier, Washington, USA (14,410 ft.)<br>
<br>
<strong>What:</strong>&nbsp;&nbsp;Basic alpine mountaineering<br>
<br>
<strong>When:</strong>&nbsp;&nbsp;<%=date+5%> - <%=date+8%> (3 days)<br>
<br>
<strong>Who:</strong>&nbsp;&nbsp;Motivated beginners and regular climbers in good physical condition<br>
<br>
<strong>How:</strong>&nbsp;&nbsp;1-4 climbers with 1 instructor<br>
<br>
<strong>Cost:</strong>&nbsp;&nbsp;$289 AW member, $350 nonmember<BR>
<BR>
</TD>

<TD><IMG SRC="/AdvWorks/multimedia/images/spacer.gif" WIDTH=40 ALT=""></TD></TR>

<TR>
<TD COLSPAN=3><HR SIZE=4>
<FONT SIZE=2>
As the tallest peak in the Pacific Northwest, Mt. Rainier is good glacier-training ground for a Denali, Alaska adventure. 
Liberty Cap is the pinnacle of Mt. Rainier, and Camp Muir is a good starting point for the quest to the summit.
<HR SIZE=4>
</TD>
</TR>

<TR><TD COLSPAN=3 HEIGHT=10></TD></TR>


<TR><TD COLSPAN=3>The icon <IMG SRC="/AdvWorks/multimedia/images/leavesite.GIF" WIDTH="19" HEIGHT="8" ALT="You are going to a site outside of Adventure Works"> indicates that the link takes you to an URL that is outside Microsoft's Adventure Works site; you can return to Adventure Works by using the Back button in your browser.</TD></TR>

<TR><TD COLSPAN=3 HEIGHT=10></TD></TR>


<TR>
<TD COLSPAN=3>
<B>TRIP REPORTS</B></FONT><BR>

<A HREF="http://www.omnigroup.com/People/tom/climbing_tour/rainier.html">
<FONT SIZE=2>http://www.omnigroup.com/People/tom/climbing_tour/rainier.html</font></a><IMG SRC="/AdvWorks/multimedia/images/leavesite.GIF" WIDTH="19" HEIGHT="8" ALT="You are going to a site outside of Adventure Works">
<br>

<A HREF="http://www.isc.tamu.edu/~christor/rainier.j.html">
<FONT SIZE=2>http://www.isc.tamu.edu/~christor/rainier.j.html</FONT></A>
<IMG SRC="/AdvWorks/multimedia/images/leavesite.GIF" WIDTH="19" HEIGHT="8" ALT="You are going to a site outside of Adventure Works">
</TD>
</TR>

<TR><TD COLSPAN=3 HEIGHT=10></TD></TR>

<TR>
<TD COLSPAN=3>
<FONT SIZE=3><B>REFERENCE MATERIAL</B></FONT>
<BR>
<A HREF="http://www.emsl.pnl.gov:2080/docs/cie/neural/workshop2/TriCities/parks/MtRainierNP.html">
<FONT SIZE=2>Mt. Rainier National Park info</FONT></A><IMG SRC="/AdvWorks/multimedia/images/leavesite.GIF" WIDTH="19" HEIGHT="8" ALT="You are going to a site outside of Adventure Works">
<BR>
<A HREF="http://www.mashell.com/Rainmap_detail.html">
<FONT SIZE=2>Mt. Rainier National Park detail map</FONT></A><IMG SRC="/AdvWorks/multimedia/images/leavesite.GIF" WIDTH="19" HEIGHT="8" ALT="You are going to a site outside of Adventure Works">
<BR>
</TD>
</TR>

<% REM Column Span Value %>
<% HTML_CS = 3 %>
<% HTML_INDENT = FALSE %>
<!--#include virtual="/AdvWorks/Disclaim.inc"-->

</TABLE>
</BODY>
</HTML>