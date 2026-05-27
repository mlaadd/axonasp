<%@ LANGUAGE = VBScript %>
<HTML>

<HEAD>
<TITLE>Adventure Works Base Camp</TITLE>
</HEAD>

<BODY BACKGROUND="/advworks/multimedia/images/back_sub.gif" LINK="#800000" VLINK="#008040"> 
<FONT FACE="MS SANS SERIF" SIZE=4>
<BGSOUND SRC="/advworks/multimedia/audio/cfire2.wav">

<TABLE WIDTH=600 BORDER=0>

<TR>
<TD>
<IMG SRC="/advworks/multimedia/images/spacer.GIF" WIDTH=110>
</TD>

<TD COLSPAN=3>
<IMG SRC="/advworks/Multimedia/Images/BaseCComp.gif" ALIGN=center BORDER=0 ALT="Base Camp"><BR>
<HR SIZE=4>
</TD>
</TR>

<TR>
<TD ROWSPAN=4 VALIGN=TOP ALIGN=LEFT>
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
<%If Not IsEmpty(Session("ItemCount")) Then
     iCount = Session("ItemCount")
  Else
     iCount = 0
  End If

  If iCount > 0 Then%>

     <A HREF="/advworks/equipment/check_out.asp">
     <IMG SRC="/advworks/multimedia/images/checkout.gif" ALT="Check Out" BORDER=O></A>

<%End If%>
</TD>

<TD VALIGN=TOP ALIGN=LEFT>

<FONT FACE="ARIAL NARROW" SIZE=4>
<STRONG>

<A HREF="/advworks/excursions/excursions.asp">
<IMG SRC="/advworks/Multimedia/Images/bullet.gif" ALIGN=MIDDLE BORDER=0>Excursions</A><BR>
<P>

<A HREF="/advworks/excursions/membership.asp">
<IMG SRC="/advworks/Multimedia/Images/bullet.gif" ALIGN=MIDDLE BORDER=0>Membership</A><BR>
<P>

<A HREF="/advworks/excursions/trivia.asp">
<IMG SRC="/advworks/Multimedia/Images/bullet.gif" ALIGN=MIDDLE BORDER=0>Climbing Games and Trivia</A><BR>
<P>
</STRONG>
</FONT>

</TD>

</TR>


<TR>
<TD>
<IMG SRC="/advworks/multimedia/images/spacer.gif" HEIGHT=10>
</TD>
</TR>

<!-- BEGIN advertisement -->

<TR>
<TD VALIGN=TOP ALIGN=LEFT>

<!--Tutorial Exercise:  Browser Capabilities-->

<!--Tutorial Exercise:  Advertisement Rotator-->

</TD>
</TR>

<!-- END advertisement -->

<TR>

<TD COLSPAN=2 VALIGN=TOP ALIGN=LEFT>
<HR SIZE=4>
<FONT FACE="MS SANS SERIF" SIZE=1>
The names of companies, products, people, characters, and/or data mentioned
herein are fictitious and are in no way intended to represent any real individual,
company, product, or event, unless otherwise noted.
<P>

<IMG SRC="/advworks/multimedia/images/ie_anim.gif" ALIGN=RIGHT>

<SUP>&#169;</SUP>1996 Adventure Works<BR>
Photos Corbis and courtesy of REI<SUP>&#174;</SUP>
</FONT>

</TD>
</TR>

</TABLE>
</FONT>
</BODY>

</HTML>
