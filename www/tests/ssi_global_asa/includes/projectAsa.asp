<% ' Nested SSI include inside projectAsa.asp %>
<!--#include virtual="/tests/ssi_global_asa/common/globalAsaFunctions.asp" -->
<%
Sub Application_OnStart()
    Application("ProjectID") = "12345"
    ' Call function from the nested include
    InitGlobalConfig()
End Sub
%>