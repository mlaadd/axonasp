<HTML>
<HEAD>
<TITLE>Adventure Works Welcome Center</TITLE>
</HEAD>
<BODY BACKGROUND="/AdvWorks/multimedia/images/back_sub.gif"> 
<FONT FACE="Verdana, Arial, Helvetica" SIZE=2>
<BGSOUND SRC="/AdvWorks/multimedia/audio/wind2.wav">

<TABLE WIDTH=600 BORDER=0>
<TR>
<TD><IMG SRC="/AdvWorks/multimedia/images/spacer.GIF" ALIGN=RIGHT WIDTH=110 ALT=""></TD>
<TD COLSPAN=3>
<IMG SRC="/AdvWorks/multimedia/images/Frontartcomp.jpg" ALIGN=center WIDTH=344 HEIGHT=146 BORDER=0 ALT="Adventure Works"><BR>
<HR SIZE=4>
</TD>
</TR>

<!--Begin Navigational Buttons, using the NavBar include (inc.) file. 
This file will automatically place the navigational bar you see on the left-hand side of the screen-->

<TR>
<TD ROWSPAN=3 VALIGN=TOP ALIGN=LEFT>

<!--#include virtual="/AdvWorks/NavBar.inc"-->

</TD>

<TD VALIGN=TOP ALIGN=LEFT><FONT SIZE=2><CENTER><B>
<% If IsEmpty(Session("CustomerFirstName")) Then %>
  Welcome!!!
<% Else %>
  Welcome back <%=Session("CustomerFirstName")%>!!!
<% End If %>
</B>
You are visitor #<B><%=FormatNumber(Session("VisitorID"),0)%></B>
</CENTER>
<P>

You know the drill:  Proper equipment for your climb leads to a successful ascent. Adventure Works gear has been tested in the most extreme environments on earth, from the 8,000-meter peaks of the Himalayas to the sub-arctic giants of Alaska.
<P>

Adventure Works has all the gear you need for any excursion, from a day hike to a major expedition.  Shop with us, set up camp with us, and take our challenge.  Join the Adventure Works expedition&#33;
</FONT>
<BR>
<BR>

<IMG SRC="/AdvWorks/multimedia/images/tipofday.gif" WIDTH=265 HEIGHT=45 ALT="Tip of the Day">



<%
' Pick a tip between 1 and 10 to display in the page
Randomize
TipNumber = Int(Rnd*10)

' Open the file with the 10 tips in it
Set FileObject = Server.CreateObject("Scripting.FileSystemObject")
Set Instream = FileObject.OpenTextFile (Server.MapPath ("/AdvWorks") & "\tips.txt", 1, FALSE, FALSE)

' Skip the tips before the tip you want to display in the page
For i = 1 to TipNumber -1
	InStream.SkipLine()
Next

' Assign the variable TipOfTheDay to the tip randomly selected above
TipOfTheDay = Instream.ReadLine
%>
<BR><FONT FACE="Verdana, Arial, Helvetica" SIZE=4 COLOR="#800000"><B>
<%= TipOfTheDay %></B></FONT>
<BR>
</TD>






<TD VALIGN=TOP ALIGN=RIGHT WIDTH=10>
<IMG SRC="/AdvWorks/multimedia/images/spacer.gif" WIDTH=10 ALT="">
</TD>
</TR>
<BR>
<BR>
<TR>
<TD>
<HR SIZE=4>
<FONT FACE="Verdana, Arial, Helvetica" SIZE=2>
The names of companies, products, people, characters and/or data mentioned
herein are fictitious and are in no way intended to represent any real individual,
company, product or event unless otherwise noted.
<P>
<BR>
Catalog photos courtesy of Recreational Equipment Incorporated (REI).<BR>
Corbis photo credits: Alissa Crandall, John Noble, Galen Rowell.
</FONT>
<HR SIZE=4>
</TD>
</TR>

<TR>
<TD COLSPAN=2 ALIGN=CENTER>
<FONT FACE="Verdana, Arial, Helvetica" SIZE=1>
<A HREF="http://www.microsoft.com/MISC/CPYRIGHT.HTM" TARGET="_top">&copy;1996 Microsoft Corporation.  All rights reserved.</A>
</FONT>
</TD>
</TR>
<TR>
<TD COLSPAN=3>
<A HREF="http://www.microsoft.com/ie/">
<IMG SRC="/AdvWorks/multimedia/images/ie_anim.gif" ALIGN=RIGHT BORDER=0 ALT="Download Internet Explorer Free!"></A>
</TD>
</TR>
</TABLE>
</BODY>
</HTML>
