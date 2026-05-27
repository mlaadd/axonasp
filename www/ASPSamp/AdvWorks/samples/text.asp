<HTML>
<HEAD>
<TITLE>Working with Text Files</TITLE>
</HEAD>
<BODY BGCOLOR=#FFFFFF>
<H3>Working with Text Files</H3>
<%
  Set FileObject = Server.CreateObject("Scripting.FileSystemObject")
  TestFile = Server.MapPath ("/ASPSamp") & "\samples\textwork.txt"
  Set OutStream= FileObject.CreateTextFile (TestFile, True, False)
  OutputString = "This is a test..." & Now()
  OutStream.WriteLine OutputString
  Response.Write "Wrote the string '" & OutputString & "' to the file: '" & TestFile & "'<P>"
  Set OutStream = Nothing

  Response.Write "Reading from file '" & TestFile & "':<BR>"
  Set InStream= FileObject.OpenTextFile (TestFile, 1, False, False)
  While not InStream.AtEndOfStream
	Response.Write Instream.Readline & "<BR>"
	InStream.SkipLine()
  Wend
  Set Instream=Nothing

  Randomize
  TipNumber = Int(10 * Rnd)
  
  Response.Write "<P>The Tip Number is: " & TipNumber & "<P>"

  strtipsfile = (Server.MapPath("/advworks") + "\tips.txt")
  Set InStream = FileObject.OpenTextFile (strtipsfile, 1, False, False)
  While TipNumber > 0
	InStream.SkipLine()
	TipNumber = TipNumber-1
  Wend
  TipOfTheDay = Instream.ReadLine
  Response.Write  "The Tip of the Day is: <BR><B>" & TipOfTheDay & "</B>"
  Set InStream = Nothing
%>
<BR>
<BR>
<!--#include virtual="/ASPSamp/Samples/srcform.inc"-->
</BODY>
</HTML>
