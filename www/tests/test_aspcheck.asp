<%@ Language="VBScript" %>
<%
' *************************************************

'  Ajiang ASP Probe V1.95 20260115
'  Ajiang Shouhou http://www.ajiang.net

' *************************************************

' Do not use output buffer, display execution results directly on the client
Response.Buffer = true

' Web page immediately expires to prevent caching from causing speed test failure.
Response.Expires = -1

' List of components to be detected
Dim OtT(3,15,1)
' Server variables
dim okCPUS, okCPU, okOS
' Component detection variables
dim isobj,VerObj,TestObj

T = Request("T")
if T="" then T="ABGH"
%>

<HTML>

  <HEAD>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <TITLE>ASP Probe V1.95 - Ajiang http://www.ajiang.net</TITLE>
    <style>
      <!--
      h1 {
        font-size: 14px;
        color: #3F8805;
        font-family: Arial;
        margin: 15px 0px 5px 0px
      }

      h2 {
        font-size: 12px;
        color: #000000;
        margin: 15px 0px 8px 0px
      }

      h3 {
        font-size: 12px;
        color: #3F8805;
        font-family: Arial;
        margin: 7px 0px 3px 12px;
        font-weight: normal;
      }

      BODY,
      TD {
        FONT-FAMILY: Arial, sans-serif;
        FONT-SIZE: 12px;
        word-break: break-all
      }

      tr {
        BACKGROUND-COLOR: #EEFEE0
      }

      A {
        COLOR: #3F8805;
        TEXT-DECORATION: none
      }

      A:hover {
        COLOR: #000000;
        TEXT-DECORATION: underline
      }

      A.a1 {
        COLOR: #000000;
        TEXT-DECORATION: none
      }

      A.a1:hover {
        COLOR: #3F8805;
        TEXT-DECORATION: underline
      }

      table {
        BORDER: #3F8805 1px solid;
        background-color: #3F8805;
        margin-left: 12px
      }

      p {
        margin: 5px 12px;
        color: #000000
      }

      .input {
        BORDER: #111111 1px solid;
        FONT-SIZE: 9pt;
        BACKGROUND-color: #F8FFF0
      }

      .backs {
        BACKGROUND-COLOR: #3F8805;
        COLOR: #ffffff;
        text-align: center
      }

      .backq {
        BACKGROUND-COLOR: #EEFEE0
      }

      .backc {
        BACKGROUND-COLOR: #3F8805;
        BORDER: medium none;
        COLOR: #ffffff;
        HEIGHT: 18px;
        font-size: 9pt
      }

      .fonts {
        COLOR: #3F8805
      }
      -->
    </STYLE>
  </HEAD>

  <body>



    <h1><a href="http://www.ajiang.net/">Ajiang</a> <a href="http://www.ajiang.net/aspcheck.asp">ASP Probe</a> V 1.95 - 20260115
    </h1>
    <%
call mmenu()
for qq=1 to len(T)
  call BodyGo(mid(T,qq,1))
next
call mmenu()
%>
    <br>
    <br>
    <table border=0 width=512 cellspacing=1 cellpadding=3 style="margin-left:0px;border:none;background:none">
      <tr style="background:none" align="center">
        <td>
          <hr width="512" size="1">
          Ajiang Shouhou (www.ajiang.net) Copyright &copy; 2001-2026
          <br>
          <a href="http://www.ajiang.net/">Ajiang Shouhou</a>
          | <a href="http://www.ajstat.com/">Ajiang Statistics</a>
          | <a href="http://www.ajiang.net/products/aspcheck/">Ajiang Probe</a>
          | <a href="http://www.ajiang.net/products/aspcheck/">Download Latest Version</a>
          <hr width="512" size="1">
        </td>
      </tr>
    </table>
  </body>

</html>

<%










' *******************************************************************************
' 　　[ A ] ASP Support and potential JScript error notes
' *******************************************************************************
sub aspyes()
%>
<h2>ASP Support Check</h2>
<table border="0" width="500" cellspacing="1" cellpadding="3">
  <tr>
    <td style="line-height:130%;">
      The following situations indicate that your host does not support ASP:
      <br>1. Prompted to download when accessing this file.
      <br>2. When accessing this file, you see text similar to "&lt;&#x25;&#x40;&#x20;&#x4C;&#x61;&#x6E;&#x67;&#x75;&#x61;&#x67;&#x65;&#x3D;&#x22;&#x56;&#x42;&#x53;&#x63;&#x72;&#x69;&#x70;&#x74;&#x22;&#x20;&#x25;&gt;".
    </td>
  </tr>
</table>
<h2>HTTP 500 (ASP 0240) Error on Consecutive Access?</h2>
<table border="0" width="500" cellspacing="1" cellpadding="3">
  <tr>
    <td style="line-height:130%;">
      If consecutive access to this probe (such as switching functions, speed tests, etc.) results in a 500 error alternating with normal loads (normal once, error next), details might show ASP 0240, HTTP/1.1 500, C0000005, etc.,
      <br><br>· This is not a probe code issue, it is caused by the JScript engine upgrade on higher Windows versions (the probe uses JScript to detect JScript version).
      <br>· If your code also uses JScript, you can <a href="http://www.ajiang.net/products/aspcheck/jscripthelp.asp">click here</a> to learn about problem details and solutions.
    </td>
  </tr>
</table>
<%
end sub






' *******************************************************************************
' 　　[ B ] Server Overview
' *******************************************************************************
sub servinfo()
%>
<h2>Server Overview</h2>
<table border="0" width="500" cellspacing="1" cellpadding="3">
  <tr>
    <td width="110">Server Address</td>
    <td width="390">Name: <%=Request.ServerVariables("SERVER_NAME")%>(IP: <%=Request.ServerVariables("LOCAL_ADDR")%>)
      Port: <%=Request.ServerVariables("SERVER_PORT")%></td>
  </tr>
  <%
	  tnow = now():oknow = cstr(tnow)
	  if oknow <> year(tnow) & "-" & month(tnow) & "-" & day(tnow) & " " & hour(tnow) & ":" & right(FormatNumber(minute(tnow)/100,2),2) & ":" & right(FormatNumber(second(tnow)/100,2),2) then oknow = oknow & " (non-standard date format)"
	  %>
  <tr>
    <td>Server Time</td>
    <td><%=oknow%></td>
  </tr>
  <tr>
    <td>IIS Version</td>
    <td><%=Request.ServerVariables("SERVER_SOFTWARE")%></td>
  </tr>
  <tr>
    <td>Script Timeout</td>
    <td><%=Server.ScriptTimeout%> seconds</td>
  </tr>
  <tr>
    <td>File Path</td>
    <td><%=Request.ServerVariables("PATH_TRANSLATED")%></td>
  </tr>
  <tr>
    <td>Script Engine</td>
    <td><%=ScriptEngine & "/"& ScriptEngineMajorVersion &"."&ScriptEngineMinorVersion&"."& ScriptEngineBuildVersion %> ,
      <%="JScript/" & getjver()%></td>
  </tr>
  <%getsysinfo()  'Get server data%>
  <tr>
    <td>Operating System</td>
    <td><%=okOS%></td>
  </tr>
  <tr>
    <td>Variables (App & Session)</td>
    <td>Application variables: <%=Application.Contents.count%>
      <%if Application.Contents.count>0 then Response.Write "[<a href=""?T=C"">List</a>]"%>,
      Session variables: <%=Session.Contents.count%>
      <%if Session.Contents.count>0 then Response.Write "[<a href=""?T=D"">List</a>]"%></td>
  </tr>
  <tr>
    <td>ServerVariables</td>
    <td><%=Request.ServerVariables.Count%> variables
      <%if Request.ServerVariables.Count>0 then Response.Write "[<a href=""?T=E"">Request.ServerVariables List</a>]"%>
    </td>
  </tr>
  <tr>
    <td>CPU Cores/Processors</td>
    <td><%=okCPUS%></td>
  </tr>
  <%
	  call ObjTest("WScript.Shell")
	  if isobj then
	    set WSshell=server.CreateObject("WScript.Shell")
	  %>
  <tr>
    <td>CPU Details</td>
    <td><%=okCPU%></td>
  </tr>
  <tr>
    <td>Environment Variables</td>
    <td><%=WSshell.Environment.count%> variables
      <%if WSshell.Environment.count>0 then Response.Write "[<a href=""?T=F"">WSshell.Environment List</a>]"%></td>
  </tr>
  <%
	  end if
	  %>
</table>
<%
end sub

%>
<SCRIPT language="JScript" runat="server">
  function getJVer() {
    //Get JScript version
    return ScriptEngineMajorVersion() + "." + ScriptEngineMinorVersion() + "." + ScriptEngineBuildVersion();
  }
</SCRIPT>
<%

' Get commonly used server parameters
sub getsysinfo()
  on error resume next
  Set WshShell = server.CreateObject("WScript.Shell")
  Set WshSysEnv = WshShell.Environment("SYSTEM")
  okOS = cstr(WshSysEnv("OS"))
  okCPUS = cstr(WshSysEnv("NUMBER_OF_PROCESSORS"))
  okCPU = cstr(WshSysEnv("PROCESSOR_IDENTIFIER"))
  if isempty(okCPUS) then
    okCPUS = Request.ServerVariables("NUMBER_OF_PROCESSORS")
  end if
  if okCPUS & "" = "" then
    okCPUS = "(Unknown)"
  end if
  if okOS & "" = "" then
    okOS = "(Unknown)"
  end if
end sub






' *******************************************************************************
' 　　[ C ] Application Variables List
' *******************************************************************************
sub applist()
%>
<h2>Application Variables List</h2>
<table border="0" width="500" cellspacing="1" cellpadding="3">
  <tr class="backs">
    <td width="110">Variable Name</td>
    <td width="390">Value</td>
  </tr>
  <%for each apps in Application.Contents%>
  <tr>
    <td width="110"><%=apps%></td>
    <td width="390"><%
  if isobject(Application.Contents(apps)) then
    Response.Write "[Object]"
  elseif isarray(Application.Contents(apps)) then
    Response.Write "[Array]"
  else
    Response.Write cHtml(Application.Contents(apps))
  end if
  %></td>
  </tr><%next%>
</table>
<%
end sub






' *******************************************************************************
' 　　[ D ] Session Variables List
' *******************************************************************************
sub seslist()
%>
<h2>Session Variables List</h2>
<table border="0" width="500" cellspacing="1" cellpadding="3">
  <tr class="backs">
    <td width="110">Variable Name</td>
    <td width="390">Value</td>
  </tr>
  <%for each sens in Session.Contents%>
  <tr>
    <td width="110"><%=sens%></td>
    <td width="390"><%
  if isobject(Session.Contents(sens)) then
    Response.Write "[Object]"
  elseif isarray(Session.Contents(sens)) then
    Response.Write "[Array]"
  else
    Response.Write cHtml(Session.Contents(sens))
  end if
  %></td>
  </tr><%next%>
</table>
<%
end sub






' *******************************************************************************
' 　　[ E ] Request.ServerVariables List
' *******************************************************************************
sub sevalist()
%>
<h2>Request.ServerVariables List (including client info)</h2>
<table border="0" width="500" cellspacing="1" cellpadding="3">
  <tr class="backs">
    <td width="110">Variable Name</td>
    <td width="390">Value</td>
  </tr>
  <%for each apps in Request.ServerVariables%>
  <tr>
    <td width="110"><%=apps%></td>
    <td width="390"><%=cHtml(Request.ServerVariables(apps))%></td>
  </tr><%next%>
</table>
<%
end sub






' *******************************************************************************
' 　　[ F ] WScript.Shell Environments List
' *******************************************************************************
sub wsslist()
  on error resume next
  Set WSshell = server.CreateObject("WScript.Shell")
%>
<h2>WScript.Shell.Environments List</h2>
<table border="0" width="500" cellspacing="1" cellpadding="3">
  <tr class="backs">
    <td width="110">Variable Name</td>
    <td width="390">Value</td>
  </tr>
  <%for each envs in WSshell.Environment
  envsa = split(envs,"=")
  %>
  <tr>
    <td width="110"><%=envsa(0)%></td>
    <td width="390"><%=cHtml(envsa(1))%></td>
  </tr><%next%>
</table>
<%
end sub






' *******************************************************************************
' 　　[ G ] Component Support
' *******************************************************************************
sub comlist()
  on error resume next
  OtT(0,0,0) = "MSWC.AdRotator"
  OtT(0,1,0) = "MSWC.BrowserType"
  OtT(0,2,0) = "MSWC.NextLink"
  OtT(0,3,0) = "MSWC.Tools"
  OtT(0,4,0) = "MSWC.Status"
  OtT(0,5,0) = "MSWC.Counters"
  OtT(0,6,0) = "IISSample.ContentRotator"
  OtT(0,7,0) = "IISSample.PageCounter"
  OtT(0,8,0) = "MSWC.PermissionChecker"
  OtT(0,9,0) = "Microsoft.XMLHTTP"
  OtT(0,9,1) = "(HTTP component, commonly used in scraping systems)"
  OtT(0,10,0) = "WScript.Shell"
  OtT(0,10,1) = "(Shell component, may involve security issues)"
  OtT(0,11,0) = "Scripting.FileSystemObject"
  OtT(0,11,1) = "(FSO File system management, text file read/write)"
  OtT(0,12,0) = "Adodb.Connection"
  OtT(0,12,1) = "(ADO data objects)"
  OtT(0,13,0) = "Adodb.Stream"
  OtT(0,13,1) = "(ADO stream object, commonly used in non-component upload scripts)"
	
  OtT(1,0,0) = "SoftArtisans.FileUp"
  OtT(1,0,1) = "(SA-FileUp file upload)"
  OtT(1,1,0) = "SoftArtisans.FileManager"
  OtT(1,1,1) = "(SoftArtisans file manager)"
  OtT(1,2,0) = "Ironsoft.UpLoad"
  OtT(1,2,1) = "(Domestic free upload component)"
  OtT(1,3,0) = "LyfUpload.UploadFile"
  OtT(1,3,1) = "(Liu Yunfeng's file upload component)"
  OtT(1,4,0) = "Persits.Upload.1"
  OtT(1,4,1) = "(ASPUpload file upload)"
  OtT(1,5,0) = "w3.upload"
  OtT(1,5,1) = "(Dimac file upload)"

  OtT(2,0,0) = "JMail.SmtpMail"
  OtT(2,0,1) = "(Dimac JMail mail transfer) <a href='http://www.ajiang.net/products/aspcheck/coms.asp'>Manual Download</a>"
  OtT(2,1,0) = "CDONTS.NewMail"
  OtT(2,1,1) = "(CDONTS)"
  OtT(2,2,0) = "CDO.Message"
  OtT(2,2,1) = "(CDOSYS)"
  OtT(2,3,0) = "Persits.MailSender"
  OtT(2,3,1) = "(ASPemail mail sender)"
  OtT(2,4,0) = "SMTPsvg.Mailer"
  OtT(2,4,1) = "(ASPmail mail sender)"
  OtT(2,5,0) = "DkQmail.Qmail"
  OtT(2,5,1) = "(dkQmail mail sender)"
  OtT(2,6,0) = "SmtpMail.SmtpMail.1"
  OtT(2,6,1) = "(SmtpMail mail sender)"
	
  OtT(3,0,0) = "SoftArtisans.ImageGen"
  OtT(3,0,1) = "(SA image read/write component)"
  OtT(3,1,0) = "W3Image.Image"
  OtT(3,1,1) = "(Dimac image read/write component)"
  OtT(3,2,0) = "Persits.Jpeg"
  OtT(3,2,1) = "(ASPJpeg)"
  OtT(3,3,0) = "XY.Graphics"
  OtT(3,3,1) = "(Domestic free image/chart processing component)"
  OtT(3,4,0) = "Ironsoft.DrawPic"
  OtT(3,4,1) = "(Domestic free image/graphic processing component)"
  OtT(3,5,0) = "Ironsoft.FlashCapture"
  OtT(3,5,1) = "(Domestic free multi-functional Flash screenshot component)"
  OtT(3,6,0) = "dyy.zipsvr"
  OtT(3,6,1) = "(Domestic free file compress/decompress component)"
  OtT(3,7,0) = "hin2.com_iis"
  OtT(3,7,1) = "(Domestic free IIS management component)"
  OtT(3,8,0) = "Socket.TCP"
  OtT(3,8,1) = "(Dimac Socket component)"
	
%>
<h2>ASP Component Support</h2><a name="G"></a>

<h3>■ Check Component Support</h3>
<table border="0" width="500" cellspacing="1" cellpadding="3">
  <FORM action="?T=<%=T%>#G" method="post">
    <tr>
      <td align="center" style="padding:10px 0px">
        Enter the ProgId or ClassId of the component to detect
        <input class=input type=text value="" name="classname" size=50>
        <input type=submit value=" Check " class=backc id=submit1 name=submit1>
        <%
Dim strClass
strClass = Trim(Request.Form("classname"))
If "" <> strClass then
Response.Write "<p style=""margin:9px 0px 0px 0px"">"
Dim Verobj1
ObjTest(strClass)
  If Not IsObj then 
	Response.Write "<font color=red>Sorry, the server does not support the " & strclass & " component!</font>"
  Else
	if VerObj="" or isnull(VerObj) then 
	  Verobj1="Could not obtain component version."
	Else
	  Verobj1="Component version: " & VerObj
	End If
	Response.Write "<font class=fonts>Congratulations! The server supports the " & strclass & " component. " & verobj1 & "</font>"
  End If
end if
%>
      </td>
    </tr>
  </FORM>
</table>

<h3>■ OS Built-in Components</h3>
<table border="0" width="500" cellspacing="1" cellpadding="3">
  <tr class="backs">
    <td width="380">Component Name and Description</td>
    <td width="120">Support / Version</td>
  </tr>
  <%
  k=0
  for i=0 to 13
    call ObjTest(OtT(k,i,0))
  %>
  <tr>
    <td width="380"><%=OtT(k,i,0) & " <font color='#888888'>" & OtT(k,i,1) & "</font>"%></td>
    <td width="120" title="<%=VerObj%>"><%=cIsReady(isobj) & " " & left(VerObj,10)%></td>
  </tr>
  <%next%>
</table>

<h3>■ Common File Upload & Management Components</h3>
<table border="0" width="500" cellspacing="1" cellpadding="3">
  <tr class="backs">
    <td width="380">Component Name and Description</td>
    <td width="120">Support / Version</td>
  </tr>
  <%
  k=1
  for i=0 to 5
    call ObjTest(OtT(k,i,0))
  %>
  <tr>
    <td width="380"><%=OtT(k,i,0) & " <font color='#888888'>" & OtT(k,i,1) & "</font>"%></td>
    <td width="120" title="<%=VerObj%>"><%=cIsReady(isobj) & " " & left(VerObj,10)%></td>
  </tr>
  <%next%>
</table>

<h3>■ Common Mail Processing Components</h3>
<table border="0" width="500" cellspacing="1" cellpadding="3">
  <tr class="backs">
    <td width="380">Component Name and Description</td>
    <td width="120">Support / Version</td>
  </tr>
  <%
  k=2
  for i=0 to 6
    call ObjTest(OtT(k,i,0))
  %>
  <tr>
    <td width="380"><%=OtT(k,i,0) & " <font color='#888888'>" & OtT(k,i,1) & "</font>"%></td>
    <td width="120" title="<%=VerObj%>"><%=cIsReady(isobj) & " " & left(VerObj,10)%></td>
  </tr>
  <%next%>
</table>

<h3>■ Other Common Components</h3>
<table border="0" width="500" cellspacing="1" cellpadding="3">
  <tr class="backs">
    <td width="380">Component Name and Description</td>
    <td width="120">Support / Version</td>
  </tr>
  <%
  k=3
  for i=0 to 8
    call ObjTest(OtT(k,i,0))
  %>
  <tr>
    <td width="380"><%=OtT(k,i,0) & " <font color='#888888'>" & OtT(k,i,1) & "</font>"%></td>
    <td width="120" title="<%=VerObj%>"><%=cIsReady(isobj) & " " & left(VerObj,10)%></td>
  </tr>
  <%next%>
</table>

<p>[<a href="http://www.ajiang.net/products/aspcheck/coms.asp">View detailed introductions and download links for the above components</a>]
  <%
	
end sub






' *******************************************************************************
' 　　[ H ] Disk Information
' *******************************************************************************
sub disklist()
  on error resume next

  ObjTest("Scripting.FileSystemObject")
  if isobj then
	set fsoobj=server.CreateObject("Scripting.FileSystemObject")

%>

<h2>Disks and Folders</h2>

<h3>■ Server Disk Information</h3>

<table border="0" width="500" cellspacing="1" cellpadding="3">
  <tr align=center class="backs">
    <td width="100">Drive & Type</td>
    <td width="50">Ready</td>
    <td width="110">Label</td>
    <td width="80">FileSystem</td>
    <td width="80">Free Space</td>
    <td width="80">Total Size</td>
  </tr>
  <%

	' The idea of testing disk information comes from "COCOON ASP Probe"
	
	set drvObj=fsoobj.Drives
	for each d in drvObj
%>
  <tr align="center" class="backq">
    <td align="right"><%=cdrivetype(d.DriveType) & " " & d.DriveLetter%>:</td>
    <%
	if d.DriveLetter = "A" then	'Do not check floppy drive to avoid affecting the server
		Response.Write "<td></td><td></td><td></td><td></td><td></td>"
	else
%>
    <td><%=cIsReady(d.isReady)%></td>
    <td><%=d.VolumeName%></td>
    <td><%=d.FileSystem%></td>
    <td align="right"><%=cSize(d.FreeSpace)%></td>
    <td align="right"><%=cSize(d.TotalSize)%></td>
    <%
	end if
%>
  </tr>
  <%
	next
%>
  </td>
  </tr>
</table>
<p>"<font color=red><b>×</b></font>" indicates the disk is not ready or the current IIS site does not have permission to access it.</p>

<h3>■ Current Folder Information</h3>
<%

Response.Flush


	dPath = server.MapPath("./")
	set dDir = fsoObj.GetFolder(dPath)
	set dDrive = fsoObj.GetDrive(dDir.Drive)
%>
<p>Folder: <%=dPath%></p>
<table border="0" width="500" cellspacing="1" cellpadding="3">
  <tr height="18" align="center" class="backs">
    <td width="75">Used Space</td>
    <td width="75">Free Space</td>
    <td width="75">Subfolders</td>
    <td width="75">Files</td>
    <td width="200">Created Time</td>
  </tr>
  <tr height="18" align="center" class="backq">
    <td><%=cSize(dDir.Size)%></td>
    <td><%=cSize(dDrive.AvailableSpace)%></td>
    <td><%=dDir.SubFolders.Count%></td>
    <td><%=dDir.Files.Count%></td>
    <td><%=dDir.DateCreated%></td>
  </tr>
  </td>
  </tr>
</table>

<%
Response.Flush

end if
end sub






' *******************************************************************************
' 　　[ I ] Disk Speed
' *******************************************************************************
sub diskspeed()
  on error resume next

  %>
<h2>Disk File Operation Speed Test</h2>
<%
  ObjTest("Scripting.FileSystemObject")
  if isobj then
	set fsoobj=server.CreateObject("Scripting.FileSystemObject")
	' The idea of testing file read/write comes from "Michenglangzi"
	
	Response.Write "<p>Repeatedly creating, writing, and deleting text files 50 times..."

	dim thetime3,tempfile,iserr

    iserr=false
	t1=timer
	tempfile=server.MapPath("./") & "\aspchecktest.txt"
	for i=1 to 50
		Err.Clear

		set tempfileOBJ = FsoObj.CreateTextFile(tempfile,true)
		if Err <> 0 then
			Response.Write "Error creating file!<br><br>"
			iserr=true
			Err.Clear
			exit for
		end if
		tempfileOBJ.WriteLine "Only for test. Ajiang ASPcheck"
		if Err <> 0 then
			Response.Write "Error writing to file!<br><br>"
			iserr=true
			Err.Clear
			exit for
		end if
		tempfileOBJ.close
		Set tempfileOBJ = FsoObj.GetFile(tempfile)
		tempfileOBJ.Delete 
		if Err <> 0 then
			Response.Write "Error deleting file!<br><br>"
			iserr=true
			Err.Clear
			exit for
		end if
		set tempfileOBJ=nothing
	next
	t2=timer
    if iserr <> true then
	thetime3=cstr(int(( (t2-t1)*10000 )+0.5)/10)
	Response.Write "...Completed! <font color=red>" & thetime3 & " ms</font>.<br>"
	Response.Flush

%>
</p>
<table border="0" width="500" cellspacing="1" cellpadding="3">
  <tr align=center class="backs">
    <td width=350>Reference Servers</td>
    <td width=150>Completion Time (ms)</td>
  </tr>
  <tr>
    <td>
      <font color=red>This Server: <%=Request.ServerVariables("SERVER_NAME")%></font>&nbsp;
    </td>
    <td>&nbsp;<font color=red><%=thetime3%></font>
    </td>
  </tr>
</table>
<%
end if

Response.Flush
	
	set fsoobj=nothing

end if
end sub






' *******************************************************************************
' 　　[ J ] Script Execution Speed
' *******************************************************************************
sub tspeed()
%>
<h2>ASP Script Interpretation and Calculation Speed Test</h2>
<p>
  <%
Response.Flush

	'Thanks to 网际同学录 http://www.5719.net for recommending timer function
	'Since we only perform 500,000 operations, the check option was removed to run directly
	
	Response.Write "Integer operation test, performing 500,000 addition operations..."
	dim t1,t2,lsabc,thetime,thetime2
	t1=timer
	for i=1 to 500000
		lsabc= 1 + 1
	next
	t2=timer
	thetime=cstr(int(( (t2-t1)*10000 )+0.5)/10)
	Response.Write "...Completed! <font color=red>" & thetime & " ms</font>.<br>"


	Response.Write "Floating-point operation test, performing 200,000 square root operations..."
	t1=timer
	for i=1 to 200000
		lsabc= 2^0.5
	next
	t2=timer
	thetime2=cstr(int(( (t2-t1)*10000 )+0.5)/10)
	Response.Write "...Completed! <font color=red>" & thetime2 & " ms</font>.<br>"
%></p>
<table border="0" width="500" cellspacing="1" cellpadding="3">
  <tr align=center class="backs">
    <td width=350>Reference Servers & Completion Time (ms)</td>
    <td width=75>Integer Ops</td>
    <td width=75>Floating Ops</td>
  </tr>
  <tr>
    <td>
      <font color=red>This Server: <%=Request.ServerVariables("SERVER_NAME")%></font>&nbsp;
    </td>
    <td>&nbsp;<font color=red><%=thetime%></font>
    </td>
    <td>&nbsp;<font color=red><%=thetime2%></font>
    </td>
  </tr>
</table>
<%
end sub






' *******************************************************************************
' 　　[ K ] Network Connection Speed Test
' *******************************************************************************
sub tnet()
%>
<h2>Connection Bandwidth Test</h2><a name="K"></a>
<%
  if T<>"K" then
%>
<p>[<a href="?T=K">Start Test</a>]</p>
<%
  else
   haveok=false

   if Request("ok") <> "" then haveok=true
   if Request("tm") = "" then haveok=false

   if haveok=false then
%>
<p>Testing the connection speed between you and the server, please wait...<span id="baifen">.</span></p>
<script language="javascript" type="text/javascript">
  var acd1;
  acd1 = new Date();
  acd1ok = acd1.getTime();
</script>
<%
Response.Flush
for i=1 to 1000
  Response.Write "<!--567890#########0#########0#########0#########0#########0#########0#########0#########012345-->" & vbcrlf
  if i mod 100=0 then
%>
<script language="javascript" type="text/javascript">
  document.getElementById('baifen').innerHTML = '<%=i/10%>%';
</script>
<%
  end if
/next
%>
<script language="javascript" type="text/javascript">
  var acd2;
  acd2 = new Date();
  acd2ok = acd2.getTime();
  window.location = '?T=K&ok=ok&tm=' + (acd2ok - acd1ok)
</script>
<%
Response.Flush :Response.end

  else

ttime=clng(Request("tm")) + 1

tnetspeed=100000/(ttime)
tnetspeed2=tnetspeed * 8
twidth=int(tnetspeed * 0.16)+5

if twidth> 300 then twidth=300
tnetspeed=formatnumber(tnetspeed,2,,,0)
tnetspeed2=formatnumber(tnetspeed2,2,,,0)

%><p>Test completed. Transmitting 100k bytes of data to the client took <%=formatnumber(ttime,2)%> ms. [<a href="?T=K">Test Again</a>]
</p>
<table border="0" width="500" cellspacing="1" cellpadding="3">
  <tr>
    <td align="center" style="padding:10px 0px">
      <table style="margin:0px;border:none" align="center" width="400" border="0" cellspacing=0 cellpadding=0>
        <tr>
          <td width="45">| 56k Modem</td>
          <td width="160">| 2M ADSL</td>
          <td width=200>| 10M LAN</td>
        </tr>
      </table>
      <table style="margin:0px" class="input" align="center" width="400" border="0" cellspacing=0 cellpadding=0>
        <tr class="input">
          <td width="<%=twidth%>" class="backs"></td>
          <td width="<%=400-twidth%>">&nbsp;<%=tnetspeed%> kB/s</td>
        </tr>
      </table>
      <p style="margin:10px 0px 0px 0px">Your connection speed to this server is <%=tnetspeed%> kB/s (equivalent to <%=tnetspeed2%> kbps)
        <br>
        <font color="#888888">Conversion: 1 Byte = 8 bits</font>
      </p>
    </td>
  </tr>
</table>
<%

  end if
 end if
end sub






' *******************************************************************************
' 　　[ L ] Unsafe Component Detection
' *******************************************************************************
sub tsafe()
%>
<object runat="server" id="ws" scope="page" classid="clsid:72C24DD5-D70A-438B-8A42-98424B88AFB8"></object>
<object runat="server" id="ws" scope="page" classid="clsid:F935DC22-1CF0-11D0-ADB9-00C04FD58A0B"></object>
<object runat="server" id="net" scope="page" classid="clsid:093FF999-1EA0-4079-9525-9614C3504B74"></object>
<object runat="server" id="net" scope="page" classid="clsid:F935DC26-1CF0-11D0-ADB9-00C04FD58A0B"></object>
<object runat="server" id="fso" scope="page" classid="clsid:0D43FE01-F093-11CF-8940-00A0C9054228"></object>
<object runat="server" id="ado" scope="page" classid="clsid:00000566-0000-0010-8000-00AA006D2EA4"></object>
<object runat="server" id="app" scope="page" classid="clsid:13709620-C279-11CE-A49E-444553540000"></object>
<object runat="server" id="hap" scope="page" classid="clsid:06290BD5-48AA-11D2-8432-006008C3FBFC"></object>

<object runat="server" id="x1" scope="page" classid="clsid:2933BF90-7B36-11d2-B20E-00C04F983E60"></object>
<object runat="server" id="x2" scope="page" classid="clsid:f5078f1b-c551-11d3-89b9-0000f81fe221"></object>
<object runat="server" id="x3" scope="page" classid="clsid:f5078f32-c551-11d3-89b9-0000f81fe221"></object>
<object runat="server" id="x4" scope="page" classid="clsid:88d969c0-f192-11d4-a65f-0040963251e5"></object>

<h2>Unsafe Component Detection</h2>
<p>WScript.Shell <%=okObj("ws")%>, Shell.application <%=okObj("app")%></p>
<table border="0" width="500" cellspacing="1" cellpadding="3">
  <tr>
    <td>The Shell component allows ASP to run executable files like .exe, posing a serious security risk. Even on servers with strict file system permission settings, this component can be used to run programs with elevated privileges.</td>
  </tr>
</table>
<p>WScript.Network <%=okObj("net")%></p>
<table border="0" width="500" cellspacing="1" cellpadding="3">
  <tr>
    <td>WScript.Network makes it possible for ASP scripts to list and create system users (groups). If the above indicator shows "√ Dangerous", this security risk may exist.</td>
  </tr>
</table>
<p>Adodb.Stream <%=okObj("ado")%></p>
<table border="0" width="500" cellspacing="1" cellpadding="3">
  <tr>
    <td>Adodb.Stream is often used to upload Trojans and other unsafe programs, expanding the attacker's capabilities. With necessary permission settings, Adodb.Stream does not threaten system security; it is commonly used in non-component upload utilities.</td>
  </tr>
</table>
<p>FSO <%=okObj("fso")%>, XML V1.0 <%=okObj("x1")%>, V2.6 <%=okObj("x2")%>, V3.0 <%=okObj("x3")%>, V4.0 <%=okObj("x4")%>
</p>
<table border="0" width="500" cellspacing="1" cellpadding="3">
  <tr>
    <td>FSO (Scripting.FileSystemObject) and XML have the ability to list and manage files and folders on the server. If permissions are improperly configured, Trojans can move, modify, or delete files on the server. The FSO component is one of the most commonly used components; disabling it is not the most ideal security measure.</td>
  </tr>
</table>
<p>HappyTime <%=okObj("hap")%></p>
<table border="0" width="500" cellspacing="1" cellpadding="3">
  <tr>
    <td>HappyTime is one of the popular network worm viruses. Its replication consumes significant network bandwidth. When the virus triggers, it may delete useful executable files on the server, causing system failure. If this test shows dangerous, your server may be infected and capable of spreading the HappyTime virus.</td>
  </tr>
</table>
<p>[<a href="http://www.ajiang.net/products/aspcheck/safe.asp">Click here to refer to Ajiang's security configuration guide</a>]
  <%
end sub






' *******************************************************************************
' 　　[ M ] System Users and Processes Detection
' *******************************************************************************
sub userlist()
%>
<h2>System Users (Groups) and Processes Detection</h2>
<p>If system users and processes are listed below, it indicates potential security risks.</p>
<table border="0" width="500" cellspacing="1" cellpadding="3">
  <tr class="backs">
    <td width="100">Type</td>
    <td width="400">Name & Details</td>
  </tr>
  <%
  on error resume next
    for each obj in getObject("WinNT://.")
	err.clear
%>
  <tr>
    <td align=center><!--<%=obj.path%>-->
      <%
    if err then
      Response.Write "System User (Group)"
    else
      Response.Write "System Process"
    end if
%>
    </td>
    <td><%=obj.Name%><%if err=0 then Response.Write " (" & obj.displayname & ")"%><br><%=obj.path%>
    </td>
  </tr>
  <%
	next 
%>
</table>
<p>[<a href="http://www.ajiang.net/products/aspcheck/safe.asp">Click here to refer to Ajiang's security configuration guide</a>]
  <%
end sub




' *******************************************************************************
' 　　[ N ] Main Menu
' *******************************************************************************
sub mmenu()
%>
<h2>Main Menu</h2>
<p>Quick View: <a href="?T=BG">Lite Mode</a> | <a href="?T=BGHIJ">Typical Mode</a> | <a href="?T=ABGHIJKLMCDEF">Full Mode</a></p>
<p>Features: <a href="?T=B">Overview</a>
  | <a href="?T=G">Components</a>
  | <a href="?T=F">Environment</a>
  | <a href="?T=HI">Disk</a>
  | <a href="?T=J">Execution Speed</a>
  | <a href="?T=K">Bandwidth</a>
  | <a href="?T=LHM">Security Status</a></p>
<%
end sub




' *******************************************************************************
' 　　Other Functions & Subroutines
' *******************************************************************************

' Display section
sub BodyGo(gCon)
  select case gCon
  case "A"
    call aspyes()
  case "B"
    call servinfo()
  case "C"
    call applist()
  case "D"
    call seslist()
  case "E"
    call sevalist()
  case "F"
    call wsslist()
  case "G"
    call comlist()
  case "H"
    call disklist()
  case "I"
    call diskspeed()
  case "J"
    call tspeed()
  case "K"
    call tnet()
  case "L"
    call tsafe()
  case "M"
    call userlist()
  case "N"
    call mmenu()
  end select
end sub


' Detect unsafe components
Function okObj(runstr)
  On Error Resume Next
  Response.Write "<span style=""display:none"">"
  okObj = true
  Err = 0
  Execute runstr & ".exec()"
  If 429 = Err Then
    okObj = false
  end if
  Err = 0
  Response.Write "</span>"
  if okObj then
    okObj="<font color=""red"">√ Dangerous</font>"
  else
    okObj="<font color=""green"">× Safe</font>"
  end if
End Function

' Convert string to HTML code
function cHtml(iText)
  cHtml = iText
  cHtml = server.HTMLEncode(cHtml)
  cHtml = replace(cHtml,chr(10),"<br>")
end function

' Convert disk type to English
function cdrivetype(tnum)
  Select Case tnum
    Case 0: cdrivetype = "Unknown"
    Case 1: cdrivetype = "Removable Disk"
    Case 2: cdrivetype = "Local Hard Drive"
    Case 3: cdrivetype = "Network Drive"
    Case 4: cdrivetype = "CD-ROM"
    Case 5: cdrivetype = "RAM Disk"
  End Select
end function

' Convert readiness to checkmark/cross
function cIsReady(trd)
  Select Case trd
    case true: cIsReady="<font class=fonts><b>√</b></font>"
    case false: cIsReady="<font color='red'><b>×</b></font>"
  End Select
end function

' Format byte count into human-readable size
function cSize(tSize)
  if tSize>=1073741824 then
    cSize=int((tSize/1073741824)*1000)/1000 & " GB"
  elseif tSize>=1048576 then
    cSize=int((tSize/1048576)*1000)/1000 & " MB"
  elseif tSize>=1024 then
    cSize=int((tSize/1024)*1000)/1000 & " KB"
  else
    cSize=tSize & "B"
  end if
end function

' Subroutine to check if component is supported and get its version
sub ObjTest(strObj)
  on error resume next
  IsObj=false
  VerObj=""
  set TestObj=server.CreateObject (strObj)
  If -2147221005 <> Err then
    IsObj = True
    VerObj = TestObj.version
    if VerObj="" or isnull(VerObj) then VerObj=TestObj.about
  end if
  set TestObj=nothing
End sub

%>