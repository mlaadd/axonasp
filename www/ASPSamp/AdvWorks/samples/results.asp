<%
'---- CursorTypeEnum Values ----
Const adOpenForwardOnly = 0
Const adOpenKeyset = 1
Const adOpenDynamic = 2
Const adOpenStatic = 3

'---- LockTypeEnum Values ----
Const adLockReadOnly = 1
Const adLockPessimistic = 2
Const adLockOptimistic = 3
Const adLockBatchOptimistic = 4

sql = Request("sql")
If sql = "" Then
	Response.Redirect("Query.asp")
End If
Set Conn = Server.CreateObject("ADODB.Connection")
Set RS = Server.CreateObject("ADODB.RecordSet")
Conn.Open "ADOSamples"
RS.Open sql, Conn, adOpenKeyset,adLockReadOnly 

RS.PageSize = 5 ' Number of rows per page
if Request("Action") = "" Then
	FormAction = "Results.asp"
else
	Response.Redirect("Query.asp?sql=" & Server.URLEncode(sql))
end if
ScrollAction = Request("ScrollAction")
if ScrollAction <> "" Then
	PageNo = mid(ScrollAction, 5)
	if PageNo < 1 Then 
		PageNo = 1
	end if
else
	PageNo = 1
end if
RS.AbsolutePage = PageNo
%>
<HTML>
<HEAD><TITLE>Simple ADO Page Scrolling Example - Results</TITLE></HEAD>
<BODY BGCOLOR=#FFFFFF>
<H1>Simple ADO Page Scrolling Example - Results</H1>
<HR>

<H2>Page <%=PageNo%></H2>
<P>
<FORM METHOD=GET ACTION="<%=FormAction%>">
<% Do while not (RS is nothing) %>
	<TABLE BORDER=1>
	<TR>
	<% For i = 0 to RS.Fields.Count - 1 %>
		<TD><FONT COLOR="BLUE"><B><%=RS(i).Name %></B></FONT></TD>
	<% Next %>
	</TR>
	<% 
	RowCount = rs.PageSize
	Do While Not RS.EOF and rowcount > 0 
	%>
	<TR>
	<% For i = 0 to RS.Fields.Count - 1 %>
		<TD>
		<% 
		'  Note:  The following is a bit of a hack...If the column name contains
		' the string "URL" anywhere in it, assume it is a URL to a gif or jpg
		' file and generate the HTML to get the image and display.   This works
		' for the Products table in the Adventure Works database, but is not a
		' general purpose solution.
		If InStr(RS(i).Name, "URL") > 0 Then 
			Response.Write "<img src=""" & RS(i) & """>"
		Else
			Response.Write RS(i)
		End If
		%>
		</TD>
	<% Next %>
	</TR>
	<%
	RowCount = RowCount - 1
	RS.MoveNext
	Loop
	%>
	</TABLE>
	<P>
	<%
	set RS = RS.NextRecordSet
Loop

Conn.Close
set rs = nothing
set Conn = nothing
%>
</TABLE>
<P><P>
<INPUT TYPE="HIDDEN" NAME="sql" VALUE="<%=sql%>">
<% if PageNo > 1 Then %>
<INPUT TYPE="SUBMIT" NAME="ScrollAction" VALUE="<%="Page " & PageNo-1%>">
<% end if %>
<% if RowCount = 0 Then %>
<INPUT TYPE="SUBMIT" NAME="ScrollAction" VALUE="<%="Page " & PageNo+1%>">
<% end if %>
<INPUT TYPE="SUBMIT" NAME="Action" VALUE="Another Query">
</FORM>
<!--#include virtual="/ASPSamp/Samples/srcform.inc"--> 
</BODY>
</HTML>
