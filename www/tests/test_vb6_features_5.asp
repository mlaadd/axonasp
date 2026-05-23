<%@ Language="VBScript" %>
<%
' AxonASP Phase 5 Test: Interface Polymorphism (Implements)

Class ILogger
    Sub Log(msg)
    End Sub
End Class

Class ConsoleLogger
    Implements ILogger
    
    Sub ILogger_Log(msg)
        Response.Write "[ILogger] " & msg & "<br>"
    End Sub
    
    Sub Log(msg)
        Response.Write "[Console] " & msg & "<br>"
    End Sub
End Class

Response.Write "<h1>Phase 5: Interface Polymorphism</h1>"

' Test 1: Explicit Interface Typing
Dim logger As ILogger
Set logger = New ConsoleLogger
logger.Log "Interface call" ' Should call ILogger_Log

' Test 2: Late Bound (Untyped)
Dim lateLogger
Set lateLogger = New ConsoleLogger
lateLogger.Log "Late bound call" ' Should call Log

' Test 3: Interface with Property
Class ISettings
    Property Get Name()
    End Property
End Class

Class AppSettings
    Implements ISettings
    
    Property Get ISettings_Name()
        ISettings_Name = "AxonASP v2"
    End Property
End Class

Dim settings As ISettings
Set settings = New AppSettings
Response.Write "App Name: " & settings.Name & "<br>"

Response.Write "<br>Test 5 Completed."
%>
