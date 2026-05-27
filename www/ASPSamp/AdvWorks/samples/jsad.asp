<%@ Language=JScript %>

<HTML>
<HEAD><TITLE>JScript using the Ad Rotator</TITLE></HEAD>
<BODY BGCOLOR=#FFFFFF>
<H3>JScript using the Ad Rotator</H3>

<%
Ad = Server.CreateObject("MSWC.Adrotator")
Response.Write(Ad.GetAdvertisement("/ASPSamp/Samples/adrot.txt"))
%>

<BR>
<BR>
<!--#include virtual="/ASPSamp/Samples/srcform.inc"-->
</BODY>
</HTML>

