<%@ Language=VBScript %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>G3pix AxonASP - Advanced Procedure Signatures Test</title>
    <style>
        body { font-family: Tahoma, Verdana, Arial, sans-serif; padding: 20px; background: #f5f5f5; }
        .container { max-width: 800px; margin: 0 auto; background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        h1 { color: #003399; border-bottom: 2px solid #3366cc; padding-bottom: 8px; }
        .pass { color: #090; font-weight: bold; }
        .fail { color: #c00; font-weight: bold; }
        .section { margin: 15px 0; padding: 10px; background: #f9f9f9; border-left: 4px solid #3366cc; border-radius: 4px; }
        pre { background: #f0f0f0; padding: 8px; border-radius: 4px; overflow-x: auto; }
    </style>
</head>
<body>
    <div class="container">
        <h1>G3pix AxonASP - Advanced Procedure Signatures</h1>
        <p>Testing Optional parameters, ParamArray, and explicit ByRef/ByVal.</p>

        <div class="section">
            <h3>1. Optional Parameters with Default Values</h3>
            <%
                Function Greet(name, Optional title = "Mr.")
                    Greet = "Hello, " & title & " " & name
                End Function

                Response.Write "With title: " & Greet("Smith", "Dr.") & "<br>"
                Response.Write "Without title: " & Greet("Smith")
            %>
        </div>

        <div class="section">
            <h3>2. Multiple Optional Parameters</h3>
            <%
                Function BuildPath(Optional root = "/var/www", Optional file = "index.html")
                    BuildPath = root & "/" & file
                End Function

                Response.Write "Default: " & BuildPath() & "<br>"
                Response.Write "Custom root: " & BuildPath("/home/user") & "<br>"
                Response.Write "Custom both: " & BuildPath("/opt", "app.js")
            %>
        </div>

        <div class="section">
            <h3>3. ParamArray</h3>
            <%
                Function JoinWithSep(sep, ParamArray items())
                    Dim result, i
                    result = ""
                    For i = LBound(items) To UBound(items)
                        If result <> "" Then
                            result = result & sep
                        End If
                        result = result & items(i)
                    Next
                    JoinWithSep = result
                End Function

                Response.Write "Join with ',': " & JoinWithSep(",", 1, 2, 3) & "<br>"
                Response.Write "Join with '-': " & JoinWithSep("-", "a", "b", "c", "d") & "<br>"
                Response.Write "Join single: '" & JoinWithSep(",", 42) & "'<br>"
                Response.Write "Join empty: '" & JoinWithSep(",") & "'"
            %>
        </div>

        <div class="section">
            <h3>4. ByRef vs ByVal</h3>
            <%
                Dim counter
                counter = 10

                Sub IncrementByVal(ByVal x)
                    x = x + 1
                End Sub

                Sub IncrementByRef(ByRef x)
                    x = x + 1
                End Sub

                Sub IncrementDefault(x)
                    x = x + 1
                End Sub

                Dim val
                val = counter
                Call IncrementByVal(val)
                Response.Write "After ByVal: " & val & " (should be 10)<br>"

                val = counter
                Call IncrementByRef(val)
                Response.Write "After ByRef: " & val & " (should be 11)<br>"

                val = counter
                Call IncrementDefault(val)
                Response.Write "After default (ByRef): " & val & " (should be 11)"
            %>
        </div>

        <div class="section">
            <h3>5. Optional with As Type</h3>
            <%
                Function Multiply(Optional a As Integer = 5, Optional b As Integer = 3)
                    Multiply = a * b
                End Function

                Response.Write "Multiply(): " & Multiply() & "<br>"
                Response.Write "Multiply(4): " & Multiply(4) & "<br>"
                Response.Write "Multiply(4, 2): " & Multiply(4, 2)
            %>
        </div>

        <div class="section">
            <h3>6. Combined: Required + Optional + ParamArray</h3>
            <%
                Function LogMessage(level, msg, Optional timestamp = "now", ParamArray tags())
                    Dim result, i
                    result = "[" & level & "] " & msg
                    If timestamp <> "now" Then
                        result = result & " @" & timestamp
                    End If
                    If IsArray(tags) And UBound(tags) >= LBound(tags) Then
                        result = result & " {"
                        For i = LBound(tags) To UBound(tags)
                            If i > LBound(tags) Then result = result & ", "
                            result = result & tags(i)
                        Next
                        result = result & "}"
                    End If
                    LogMessage = result
                End Function

                Response.Write "Basic: " & LogMessage("INFO", "Started") & "<br>"
                Response.Write "With tags: " & LogMessage("WARN", "High memory", "now", "server1", "memory") & "<br>"
                Response.Write "With time and tags: " & LogMessage("ERROR", "Crash", "12:00", "critical", "server2")
            %>
        </div>

        <h2>Results</h2>
        <p>If you can see all sections above without errors, the advanced procedure signatures are working correctly.</p>
    </div>
</body>
</html>
