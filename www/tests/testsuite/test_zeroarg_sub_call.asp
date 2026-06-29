<%
Option Explicit

Dim t
Set t = Server.CreateObject("G3TestSuite")
t.Describe "Zero-argument bare Sub and Function calls"

Dim runSequence
runSequence = ""

Sub GreetBackward()
    runSequence = runSequence & "GreetBackward Called| "
End Sub

' Test zero-argument sub call defined before call site
GreetBackward

' Test zero-argument sub call defined after call site (forward reference)
GreetForward

Sub GreetForward()
    runSequence = runSequence & "GreetForward Called| "
End Sub

' Test zero-argument function call defined before call site
Function FuncBackward()
    runSequence = runSequence & "FuncBackward Called| "
End Function
FuncBackward

' Test zero-argument function call defined after call site (forward reference)
FuncForward
Function FuncForward()
    runSequence = runSequence & "FuncForward Called| "
End Function

t.AssertEqual "GreetBackward Called| GreetForward Called| FuncBackward Called| FuncForward Called| ", runSequence, "All bare zero-arg sub/func calls should execute in order"
%>
