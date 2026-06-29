<%@ Language=VBScript %>
<%
Option Explicit

Sub GreetBackward()
    Response.Write "GreetBackward Called| "
End Sub

' Test zero-argument sub call defined before call site
GreetBackward

' Test zero-argument sub call defined after call site (forward reference)
GreetForward

Sub GreetForward()
    Response.Write "GreetForward Called| "
End Sub

' Test zero-argument function call defined before call site
Function FuncBackward()
    Response.Write "FuncBackward Called| "
End Function
FuncBackward

' Test zero-argument function call defined after call site (forward reference)
FuncForward
Function FuncForward()
    Response.Write "FuncForward Called| "
End Function
%>
