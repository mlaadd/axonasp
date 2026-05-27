<form method="Post" Action="atumd2.asp#select">
    <input type="hidden" name="Script6" value="True"><p align="center"><input type="Submit" Value="Show Me"></p>
</form>

<% If Request.Form("Script6") = "True" then
	Set dbConnection = Server.CreateObject("ADODB.Connection")
	dbConnection.Open "AdvWorks"
	SQLQuery = "SELECT * FROM Customers"
	Set rsCustomerList = dbConnection.Execute(SQLQuery)
%>
<Center>
<TABLE BORDER=1>
<% Do While Not rsCustomerList.EOF %>
<TR>
<TD><% = rsCustomerList("CompanyName") %></TD>
<TD><% = rsCustomerList("ContactLastName") & ", " & rsCustomerList("ContactFirstName") %>
</TD>
<TD><% = rsCustomerList("ContactLastName") %></TD>
<TD><% = rsCustomerList("City") %></TD>
<TD><% = rsCustomerList("StateOrProvince") %></TD>
</TR>
<%   rsCustomerList.MoveNext 
   Loop %>
</TABLE>
</Center>
<% Else %>
<Center>
<TABLE BORDER=1>
<TR><TD width=199>&nbsp</TD><TD width=105>&nbsp</TD><TD width=52>&nbsp</TD><TD width=110>&nbsp</TD><TD width=27><BR></TD></TR>
<TR><TD width=199>&nbsp</TD><TD width=105>&nbsp</TD><TD width=52>&nbsp</TD><TD width=110>&nbsp</TD><TD width=27><BR></TD></TR>
<TR><TD width=199>&nbsp</TD><TD width=105>&nbsp</TD><TD width=52>&nbsp</TD><TD width=110>&nbsp</TD><TD width=27><BR></TD></TR>
</Table>
</Center>
<%End if%>