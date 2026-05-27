<HTML>
<HEAD><TITLE>VBScript Using the Ad Rotator</TITLE></HEAD>
<BODY BGCOLOR=#FFFFFF>
<H3>VBScript Using the Ad Rotator</H3>

<% Set Ad = Server.CreateObject("MSWC.Adrotator") %>
<%= Ad.GetAdvertisement("/ASPSamp/Samples/adrot.txt") %>
<BR>
<BR>
<!--#include virtual="/ASPSamp/Samples/srcform.inc"-->
</BODY>
</HTML>
