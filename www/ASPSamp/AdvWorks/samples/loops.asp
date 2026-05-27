<HTML>
<HEAD><TITLE>Scripting for Loops</TITLE></HEAD>
<BODY BGCOLOR=#FFFFFF>
<!-- the following script is from the "Writing ActiveX Server Scripts"
     section of the "ActiveX Server Scripting Guide." -->

<% On Error Resume Next %>

<H3> Repeating a Loop While a Condition Is True</H3><P>

Use the While keyword to check a condition in a Do...Loop statement. You can check the condition before you enter the loop (as shown in the first example following this paragraph), or you can check it after the loop has run at least once (as shown in the second example).<P>

<%
' First example of the While keyword

Counter = 0
MyNum = 20

Do While MyNum > 10
	MyNum = MyNum - 1
	Counter = Counter + 1
Loop
%>
The first loop made <%= Counter %> repetitions.<P>

<%
  ' Second example of the While keyword

Counter = 0
MyNum = 9

Do
	MyNum = MyNum - 1
	Counter = Counter + 1
Loop While MyNum > 10
%>
The second loop made <%= Counter %> repetitions.<P>
<P>

<H3>Repeating a Statement Until a Condition Becomes True</H3>
<P> 
You can use the Until keyword in two ways to check a condition in a Do...Loop statement. You can check the condition before you enter the loop (as shown in the first example following this paragraph), or you can check it after the loop has run at least once (as shown in the second example). As long as the condition is False, the looping occurs.
<P>
<%
' First example of the Until keyword
Counter = 0
MyNum = 20

Do Until myNum = 10
	MyNum = MyNum - 1
	Counter = Counter + 1
Loop
%>
The first loop made <%= Counter %> repetitions.<P>

<%
  ' Second example of the Until keyword
Counter = 0
MyNum = 1
Do
	MyNum = MyNum + 1
	Counter = counter + 1
Loop Until MyNum = 10
%>
The second loop made <%= Counter %> repetitions.<P>
<P>

<H3>Exiting a Do ... Loop Statement from Inside the Loop</H3>
<P>
You can exit a Do ... Loop by using the Exit Do statement. You usually want to exit when you have accomplished the task the loop is performing or in certain situations to avoid an endless loop.<P>

In the following example, myNum is assigned a value that creates an endless loop. The If...Then...Else statement checks for this condition, preventing the endless repetition.
<P>

<%
Counter = 0
MyNum = 9
Do Until myNum = 10
	MyNum = MyNum - 1
	Counter = Counter + 1
	If MyNum < 10 Then Exit Do
Loop
%>
The loop made <%= Counter %> repetitions.
<BR>
<BR>
<BR>
<!--#include virtual="/ASPSamp/Samples/srcform.inc"-->
</BODY>
</HTML>