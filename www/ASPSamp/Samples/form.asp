<HTML>
<HEAD><TITLE>Form Sample</TITLE></HEAD>
<BODY BGCOLOR=#FFFFFF>
<H3>Form Sample</H3>
<HR>

<%
On Error Resume Next

If Request.Form("hname") = "" Then

  ' This part of the script allows a person
  ' to enter data on an HTML form.
%>



	<P>This sample shows how to use the Request collection 
	to get information from a posted form.
	<FORM METHOD=POST ACTION="form.asp">

	<P>Your Name:

	<P><INPUT TYPE=TEXT SIZE=50 MAXLENGTH=50 NAME="name"><BR>

	<P>Movies that you like: (you may select more than one)
	<SELECT NAME="movies" MULTIPLE SIZE=3>
	<OPTION SELECTED> Jurassic Park
	<OPTION> The Usual Suspects
	<OPTION> Jacob's Ladder
	</SELECT>

	<INPUT TYPE=HIDDEN NAME="hname" VALUE="hvalue" ><BR>

	<P>Why do you like the movies you've selected?

	<P><TEXTAREA NAME="describe" ROWS=5 COLS=35></TEXTAREA><BR>

	<P><INPUT TYPE=SUBMIT VALUE="Submit Form"><INPUT TYPE=RESET VALUE="Reset Form">
	</FORM>


<% Else

  ' This part of the script shows a person
  ' what was selected.
%>



	<% If Request.Form("name") = "" Then %>
  	<P>You did not provide your name.
	<% Else %>
		<P>Your name is <B><%= Request.Form("name") %></B>
		<% End If %>

		<% If Request.Form("movies").Count = 0 Then %>	
  		<P>You did not select any movies.
	<% Else %>
  		<P>The movies you like are:  <B><%= Request.Form("movies") %></B>

  		<% If Request.Form("describe") = "" Then %>
 		<P>You did not say why you like the movie(s) you have selected.
 	<% Else %>
    		<P>Your description of why you like the movie(s) is:
    		<B><I><%= Request.Form("describe") %></B></I>
  		<% End If %>
	<% End If %>		
<% End If %>

<BR>
<BR>
<!--#include virtual="/ASPSamp/Samples/srcform.inc"-->
</BODY>
</HTML>

