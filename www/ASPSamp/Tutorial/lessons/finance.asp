<%@ LANGUAGE = VBScript %>
<HTML> 
<HEAD><TITLE>Future Value Calculation</TITLE> 
</HEAD> 
<BODY BGCOLOR="#FFFFFF"><FONT FACE="ARIAL,HELVETICA">

<% 
' Check to see if an Annual Percentage Rate 
' was entered 
If IsNumeric(Request("APR")) Then 
' Ensure proper form. 
If Request("APR") > 1 Then 
APR = Request("APR") / 100 
Else 
APR = Request("APR") 
End If 
Else 
APR = 0 
End If 

' Check to see if a value for Total Payments 
' was entered 
If IsNumeric(Request("TotPmts")) Then 
TotPmts = Request("TotPmts") 
Else 
TotPmts = 0 
End If

' Check to see if a value for Payment Amount 
' was entered 
If IsNumeric(Request("Payment")) Then 
Payment = Request("Payment") 
Else 
Payment = 0 
End If 

' Check to see if a value for Account Present Value 
' was entered 
If IsNumeric(Request("PVal")) Then 
PVal = Request("PVal") 
Else 
PVal = 0 
End If

If Request("PayType") = "Beginning" Then 
PayType = 1 ' BeginPeriod 
Else 
PayType = 0 ' EndPeriod 
End If 

' Create an instance of the Finance object 
Set Finance = Server.CreateObject("MS.Finance") 

' Use your instance of the Finance object to 
' calculate the future value of the submitted 
' savings plan using the HTML form and the 
' CalcFV method 
FVal = Finance.CalcFV(APR / 12, TotPmts, -Payment, -PVal, PayType) 
%>

<H3>Your savings will be worth <% = FVal %>.</H3>

</FONT>
</BODY> 
</HTML> 
