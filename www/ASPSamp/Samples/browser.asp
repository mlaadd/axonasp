<HTML>
<HEAD><TITLE>Browser Properties</TITLE></HEAD>
<BODY BGCOLOR=#FFFFFF>

<% Set bc = Server.CreateObject("MSWC.BrowserType") %>

<H3>The following is a list of properties of your browser:</H3>
<TABLE BORDER=1>
<TR><TD>Browser Type</TD>		<TD><%= bc.Browser %></TD>
<TR><TD>What Version</TD>		<TD><%= bc.Version %></TD>
<TR><TD>Major Version</TD>		<TD><%= bc.Majorver %></TD>
<TR><TD>Minor Version</TD>		<TD><%= bc.Minorver %></TD>
<TR><TD>Frames</TD>			<TD><%= CStr(CBool(bc.Frames)) %></TD>
<TR><TD>Tables</TD>			<TD><%= CStr(CBool(bc.Tables)) %></TD>
<TR><TD>Cookies</TD>			<TD><%= CStr(CBool(bc.cookies)) %></TD>
<TR><TD>Background Sounds</TD>		<TD><%= CStr(CBool(bc.BackgroundSounds)) %></TD>
<TR><TD>VBScript</TD>			<TD><%= CStr(CBool(bc.VBScript)) %></TD>
<TR><TD>JavaScript</TD>			<TD><%= CStr(CBool(bc.Javascript)) %></TD>
</TABLE>
<BR>
<BR>
<!--#include virtual="/ASPSamp/Samples/srcform.inc"-->
</BODY>
</HTML>