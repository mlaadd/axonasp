<HTML>
<HEAD>
<TITLE>Adventure Works Excursions - Patagonia</TITLE></HEAD>
<BODY BACKGROUND="/AdvWorks/multimedia/images/back_sub.gif" LINK="#800000" VLINK="#008040"> 
<FONT FACE="Verdana, Arial, Helvetica" SIZE=2>

<TABLE WIDTH=600 BORDER=0>
<TR>
<TD>
<IMG SRC="/AdvWorks/multimedia/images/spacer.GIF" WIDTH=110 ALT=""></TD>
<TD COLSPAN=3>
<IMG SRC="/AdvWorks/Multimedia/Images/bc_title_patagonia.gif" WIDTH="180" HEIGHT="42" ALIGN=center BORDER=0 ALT="Patagonia">
<BR>
<HR SIZE=4>
</TD>
</TR>

<!--Begin Navigational Buttons, using the NavBar include (inc.) file. 
This file will automatically place the navigational bar you see on the left-hand side of the screen-->

<TR>
<TD ROWSPAN=20 VALIGN=TOP ALIGN=LEFT>
<!--#include virtual="/AdvWorks/NavBar.inc"-->

<!--Begin code for creating navigational arrows to cycle through the Excursion pages-->
<% Set OBJnextlink = Server.CreateObject("MSWC.NextLink") %>

<IMG SRC="/AdvWorks/multimedia/images/icon_arrows_both_ways.GIF" WIDTH="85" HEIGHT="45" ALIGN=CENTER BORDER=0 USEMAP="#ARROWS" ALT="Navigational arrows"></A>
<BR>
<MAP NAME="ARROWS">
<AREA SHAPE="RECT" COORDS="0,0 46,45" HREF="<%=OBJnextlink.GetPreviousURL ("/AdvWorks/excursions/nextlink.txt")%>">
<AREA SHAPE="RECT" COORDS="48,1 85,45" HREF="<%=OBJnextlink.GetNextURL ("/AdvWorks/excursions/nextlink.txt")%>">
</MAP>
</TD>

<TD WIDTH=220 VALIGN=TOP ALIGN=RIGHT>
<IMG SRC="/AdvWorks/multimedia/images/map_patagonia2.gif" WIDTH="220" HEIGHT="220" ALIGN=TOP ALT="Patagonia">
</TD>

<TD WIDTH=380 ALIGN=LEFT><FONT SIZE=2>
<strong>Where:</strong>&nbsp;&nbsp;Patagonia, Argentine Andes, South America<br>
<br>
<strong>What:</strong>&nbsp;&nbsp;Trekking<br>
<br>
<strong>When:</strong>&nbsp;&nbsp;<%=date+21%> - <%=date+35%> (14 days)<br>
<br>
<strong>Who:</strong>&nbsp;&nbsp;Backpacking experience<br>
<br>
<strong>How:</strong>&nbsp;&nbsp;6 - 10 trekkers with 2 instructors<br>
<br>
<strong>Cost:</strong>&nbsp;&nbsp;$1750 AW member $2200 nonmember<BR>
<BR>
</TD>

<TD><IMG SRC="/AdvWorks/multimedia/images/spacer.gif" WIDTH=40 ALT=""></TD></TR>

<TR>
<TD COLSPAN=3><HR SIZE=4>
<FONT SIZE=2>
Trek through Patagonia, Argentina, one of the most beautiful mountain regions of the world. Located at the Southern tip of South America, Patagonia is home to diverse wildlife and spectacular mountains.<P>

We will trek near the Northern end of the Patagonian ice cap, paying visits to the classic peaks of the area, including Fitz Roy and Cerro Torre.<P>

Other places we'll explore include Lago Argentino and the Moreno Glacier, as well as Tierra del Fuego National Park.<P>

Along the way, we'll visit the penguin colonies of the Atlantic coast and the flamingos of Lago Viedma.<P>
<HR SIZE=4>
</TD>
</TR>


<TR><TD COLSPAN=3 HEIGHT=10></TD></TR>


<TR><TD COLSPAN=3>The icon <IMG SRC="/AdvWorks/multimedia/images/leavesite.GIF" WIDTH="19" HEIGHT="8" ALT="You are going to a site outside of Adventure Works"> indicates that the link takes you to an URL that is outside Microsoft's Adventure Works site; you can return to Adventure Works by using the Back button in your browser.</TD></TR>

<TR><TD COLSPAN=3 HEIGHT=10></TD></TR>

<TR>
<TD COLSPAN=3>
<B>TRIP REPORTS</B></FONT>
<BR>
<A HREF="http://www.tc.umn.edu/nlhome/m027/bonzi/pw/prologue.htm">
<FONT SIZE=2>Excerpts from the book <I>Patagonia Wilderness</I></A>
<IMG SRC="/AdvWorks/multimedia/images/leavesite.GIF" WIDTH="19" HEIGHT="8" ALT="You are going to a site outside of Adventure Works">
<BR>
<A HREF="http://www.solutions.mb.ca/rec-travel/south_america/argentina/patagonia.trip.salmon.html"><FONT SIZE=2>1993 Trip Journal</A>
<IMG SRC="/AdvWorks/multimedia/images/leavesite.GIF" WIDTH="19" HEIGHT="8" ALT="You are going to a site outside of Adventure Works">
<BR>
<A HREF="http://www.gorp.com/gorp/location/latamer/patagoni.htm"><FONT SIZE=2>About Patagonia</A>
<IMG SRC="/AdvWorks/multimedia/images/leavesite.GIF" WIDTH="19" HEIGHT="8" ALT="You are going to a site outside of Adventure Works"></TD></TR>

<% REM Column Span Value %>
<% HTML_CS = 3 %>
<% HTML_INDENT = FALSE %>
<!--#include virtual="/AdvWorks/Disclaim.inc"-->

</TABLE>
</BODY>
</HTML>


