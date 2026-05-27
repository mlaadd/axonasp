<%@ LANGUAGE = VBScript %>
<%If Not IsEmpty(Session("ItemCount")) Then
     iCount = Session("ItemCount")
  Else
     iCount = 0
     Session("ItemCount") = iCount
  End If
%>
<HTML>

<HEAD>
<TITLE>Adventure Works Welcome Center</TITLE>
</HEAD>

<BODY BACKGROUND="/advworks/multimedia/images/back_sub.gif"> 
<FONT FACE="MS SANS SERIF" SIZE=2>
<BGSOUND SRC="/advworks/multimedia/audio/wind2.wav">

<TABLE WIDTH=600 BORDER=0>

<TR>
<TD>
<IMG SRC="/advworks/multimedia/images/spacer.GIF" WIDTH=110>
</TD>
<TD COLSPAN=3>
<IMG SRC="/advworks/multimedia/images/Frontartcomp.GIF" ALIGN=center BORDER=0 ALT="Adventure Works"><BR>
<HR SIZE=4>
</TD>
</TR>

<TR>
<TD ROWSPAN=3 VALIGN=TOP ALIGN=LEFT>
<A HREF="/advworks/equipment/default.asp">
<IMG SRC="/advworks/multimedia/images/icon_sub_equipment.GIF" ALIGN=CENTER BORDER=0 ALT="Equipment"></A><BR>

<A HREF="/advworks/excursions/default.asp">
<IMG SRC="/advworks/multimedia/images/icon_sub_excursions.GIF" ALIGN=CENTER BORDER=0 ALT="Membership and Excursions"></A><BR>

<A HREF="/advworks/resources/default.asp">
<IMG SRC="/advworks/multimedia/images/icon_sub_resources.GIF" ALIGN=CENTER BORDER=0 ALT="Resources"></A><BR>

<A HREF="/advworks/internal/default.asp">
<IMG SRC="/advworks/multimedia/images/icon_sub_internal.GIF" ALIGN=CENTER BORDER=0 ALT="Internal"></A><BR>

<A HREF="/advworks/default.asp">
<IMG SRC="/advworks/multimedia/images/icon_sub_home.GIF" ALIGN=CENTER BORDER=0 ALT="Home"></A><BR>

<%
  If iCount > 0 Then%>

     <A HREF="/advworks/equipment/check_out.asp">
     <IMG SRC="/advworks/multimedia/images/checkout.gif" ALT="Check Out" BORDER=O></A>

<%End If%>

</TD>

<TD VALIGN=TOP ALIGN=LEFT><FONT SIZE=2>
You know the drill:  Proper equipment for your climb leads to a successful ascent. Adventure Works gear has been tested in the most extreme environments on earth, from the 8,00-meter peaks of the Himalayas to the sub-arctic giants of Alaska.
<P>

Adventure Works has all the gear you need for any expedition, from a day hike to a major excursion.  Shop with us, set up camp with us, and take our challenge.  Join the Adventure Works expedition &#33;

<P>
<BR>

<IMG SRC="/advworks/multimedia/images/tipofday.gif" ALT="Tip of the Day">

<!--Tutorial exercise:  Textstream component-->

<BR><FONT FACE="ARIAL NARROW" SIZE=4 COLOR="#800000"><STRONG>
<%= TipOfTheDay %></STRONG></FONT>

</TD>

<TD VALIGN=TOP ALIGN=RIGHT WIDTH=10>
<IMG SRC="/advworks/multimedia/images/spacer.gif" WIDTH=10>
</TD>

</TR>
</FONT>

<TR>

<TD COLSPAN=3 VALIGN=TOP ALIGN=LEFT>
<HR SIZE=4>
<FONT FACE="MS SANS SERIF" SIZE=1>
The names of companies, products, people, characters, and/or data mentioned
herein are fictitious and are in no way intended to represent any real individual,
company, product, or event, unless otherwise noted.
<P>

<IMG SRC="/advworks/multimedia/images/ie_anim.gif" ALIGN=RIGHT>

<SUP>&#169;</SUP>1996 Adventure Works<BR>
Catalog photos courtesy of REI<sup>&#169;</sup>.<BR>
Corbis photo credits: Alissa Crandall, John Noble, Galen Rowell.</FONT>

</TD>
</TR>

</TABLE>
<FONT>
</BODY>

</HTML>
