<%
  Response.ContentType = "text/plain"
  Set Conn = Server.CreateObject("ADODB.Connection")
  Conn.Open Session("ConnectionString")
  Set RS = Conn.Execute("{Call SalesByProduct}")
%>11
6
2	Units	Sales
<%
Do While Not RS.EOF
	ProdName = RS("ProductName")
	If Len(ProdName) > 8 Then
		ProdName = Left(ProdName, 6) & ".."
	End If
	Response.Write ProdName & Chr(9) & _
		RS("Total Units") & Chr(9) & _
		RS("Total Sales") & Chr(13) & Chr(10)
	RS.MoveNext
Loop
Conn.Close
%>