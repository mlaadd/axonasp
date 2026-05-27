<HTML>
<HEAD><TITLE>Request Query String</TITLE></HEAD>
<BODY BGCOLOR=#FFFFFF>
<H3>Obtaining Query String from an URL</H3>
<A HREF="qstring.asp?Size=Medium&Color=Yellow">
This link will demonstrate the Request.QueryString object.</A><P>
The current value of Size is <%= Request.QueryString("Size") %><BR>
The current value of Color is <%= Request("Color") %>
<BR>
<BR>
<BR>
<!--#include virtual="/ASPSamp/Samples/srcform.inc"-->
</BODY>
</HTML>