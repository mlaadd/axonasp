<H2>Sample Form</H2>
<br>
Please provide the following information, then click <strong>Submit</strong>:
<FORM METHOD="POST" ACTION="atumd1.asp#script1"><br>
First Name: <INPUT NAME="fname" SIZE="48"><br>
Last Name: <INPUT NAME="lname" SIZE="48"><br>
Title: <INPUT NAME="title" TYPE=RADIO VALUE="mr">Mr.
        <INPUT NAME="title" TYPE=RADIO VALUE="ms">Ms.
<br><INPUT TYPE=SUBMIT><INPUT TYPE=RESET>
</FORM>
<% If Request.Form("lname")<>"" then %>
<br>
<center>
<table border=2><tr><td>
<H2><CENTER>Thank you</CENTER></H2><P ALIGN=CENTER>
Thank you, 
<%Title = Request.Form("title") 
	LastName = Request.Form("lname") 
	If Title = "mr" Then%> 
		Mr. <%=LastName%>, 
	<%ElseIf Title = "ms" Then%> 
		Ms. <%=LastName%>, 
	<%Else%>
		<%=Request.Form("fname") & " " & LastName %>
	<%End If%>
for your order.<BR>
</td></tr></table></center>
<%End if %>
