<%@ Language=VBScript %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>G3Pix AxonASP - G3PDF Persits.Pdf Compatibility Test</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: Tahoma, 'Segoe UI', Geneva, Verdana, sans-serif;
                padding: 30px;
                background: #f5f5f5;
                line-height: 1.6;
            }

            .container {
                max-width: 1000px;
                margin: 0 auto;
                background: #fff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            h1 {
                color: #333;
                margin-bottom: 10px;
                border-bottom: 2px solid #667eea;
                padding-bottom: 10px;
            }

            h2 {
                color: #555;
                margin-top: 30px;
                margin-bottom: 15px;
            }

            .box {
                border-left: 4px solid #667eea;
                padding: 15px;
                margin-bottom: 15px;
                background: #f9f9f9;
                border-radius: 4px;
            }

            .pass {
                border-left-color: #4caf50;
                background: #e8f5e9;
            }

            .fail {
                border-left-color: #f44336;
                background: #ffebee;
            }

            .info {
                border-left-color: #2196f3;
                background: #e3f2fd;
            }

            pre {
                background: #f4f4f4;
                padding: 10px;
                border-radius: 4px;
                overflow-x: auto;
            }

            code {
                background: #f0f0f0;
                padding: 2px 6px;
                border-radius: 3px;
            }
        </style>
    </head>

    <body>
        <div class="container">
            <h1>G3PDF Persits.Pdf Compatibility Test</h1>
            <div class="info">
                <strong>Test Objective:</strong> Verify the Persits.Pdf object model compatibility layer.
                This test exercises CreateDocument, Pages.Add, Canvas.DrawText, DrawLine, DrawBox,
                Font loading, Save, and SendBinary.
            </div>

            <%
        Dim testCount, passCount, failCount
        testCount = 0
        passCount = 0
        failCount = 0

        Sub RunTest(name)
            testCount = testCount + 1
            Response.Write "<div class=""box"">"
            Response.Write "<strong>Test " & testCount & ": " & name & "</strong><br>"
        End Sub

        Sub Pass(msg)
            passCount = passCount + 1
            Response.Write "<span style=""color:green;font-weight:bold;"">PASS:</span> " & msg & "<br>"
            Response.Write "</div>"
        End Sub

        Sub Fail(msg)
            failCount = failCount + 1
            Response.Write "<span style=""color:red;font-weight:bold;"">FAIL:</span> " & msg & "<br>"
            Response.Write "</div>"
        End Sub

        ' ======== TEST 1: CreateObject with Persits.Pdf PROGID ========
        RunTest "CreateObject with Persits.Pdf PROGID"
        Dim pdf
        Set pdf = Server.CreateObject("Persits.Pdf")
        If IsObject(pdf) Then
            Pass "Successfully created Persits.Pdf object"
        Else
            Fail "Failed to create Persits.Pdf object"
        End If

        ' ======== TEST 2: CreateDocument ========
        RunTest "CreateDocument returns PdfDocument"
        Dim doc
        Set doc = pdf.CreateDocument()
        If IsObject(doc) Then
            Pass "CreateDocument returned an object"
        Else
            Fail "CreateDocument did not return an object"
        End If

        ' ======== TEST 3: Pages.Add ========
        RunTest "Pages.Add creates a new page"
        Dim page
        Set page = doc.Pages.Add()
        If IsObject(page) Then
            Pass "Pages.Add returned a PdfPage object"
        Else
            Fail "Pages.Add did not return a PdfPage object"
        End If

        ' ======== TEST 4: Canvas property ========
        RunTest "Canvas property returns PdfCanvas"
        Dim canvas
        Set canvas = page.Canvas
        If IsObject(canvas) Then
            Pass "Canvas returned a PdfCanvas object"
        Else
            Fail "Canvas did not return a PdfCanvas object"
        End If

        ' ======== TEST 5: Fonts loading ========
        RunTest "Fonts loading returns PdfFont"
        Dim font
        Set font = pdf.Fonts("Arial")
        If IsObject(font) Then
            Pass "Fonts returned a PdfFont object"
        Else
            Fail "Fonts did not return a PdfFont object"
        End If

        ' ======== TEST 6: Font properties ========
        RunTest "Font properties"
        If font.Name = "Arial" Then
            Pass "Font.Name = " & font.Name
        Else
            Fail "Font.Name expected 'Arial', got '" & font.Name & "'"
        End If

        font.Size = 16
        If font.Size = 16 Then
            Pass "Font.Size set to 16"
        Else
            Fail "Font.Size expected 16, got " & font.Size
        End If

        font.Bold = True
        If font.Bold Then
            Pass "Font.Bold set to True"
        Else
            Fail "Font.Bold expected True"
        End If

        ' ======== TEST 7: Canvas.DrawText with param string ========
        RunTest "Canvas.DrawText with param string"
        On Error Resume Next
        canvas.DrawText "Hello from Persits.Pdf Compatibility Layer!", "x=10; y=50; width=180; alignment=center; size=16", font
        If Err.Number = 0 Then
            Pass "DrawText executed successfully"
        Else
            Fail "DrawText error: " & Err.Description
        End If
        On Error Goto 0

        ' ======== TEST 8: Canvas.DrawLine with param string ========
        RunTest "Canvas.DrawLine with param string"
        On Error Resume Next
        canvas.DrawLine "x=10; y=100; x1=180; y1=100; color=#0000FF; width=0.5"
        If Err.Number = 0 Then
            Pass "DrawLine executed successfully"
        Else
            Fail "DrawLine error: " & Err.Description
        End If
        On Error Goto 0

        ' ======== TEST 9: Canvas.DrawBox with param string ========
        RunTest "Canvas.DrawBox with param string"
        On Error Resume Next
        canvas.DrawBox "left=50; top=150; right=180; bottom=250; color=#FF0000; width=1"
        If Err.Number = 0 Then
            Pass "DrawBox executed successfully"
        Else
            Fail "DrawBox error: " & Err.Description
        End If
        On Error Goto 0

        ' ======== TEST 10: PdfDocument.Save ========
        RunTest "PdfDocument.Save"
        Dim savePath, fso
        savePath = Server.MapPath("/tests/test_persits_output.pdf")
        On Error Resume Next
        doc.Save savePath
        If Err.Number = 0 Then
            Set fso = Server.CreateObject("Scripting.FileSystemObject")
            If fso.FileExists(savePath) Then
                Pass "PDF saved successfully to " & savePath
                'fso.DeleteFile savePath
            Else
                Fail "File was not created at " & savePath
            End If
        Else
            Fail "Save error: " & Err.Description
        End If
        On Error Goto 0

        ' ======== TEST 11: PdfDocument.SendBinary ========
        RunTest "PdfDocument.SendBinary"
        On Error Resume Next
        Dim binData
        binData = doc.SendBinary()
        If Err.Number = 0 Then
            If LenB(binData) > 0 Then
                Pass "SendBinary returned " & LenB(binData) & " bytes"
            Else
                Fail "SendBinary returned empty data"
            End If
        Else
            Fail "SendBinary error: " & Err.Description
        End If
        On Error Goto 0

        ' ======== TEST 12: Native G3PDF methods still work ========
        RunTest "Native G3PDF methods still work alongside Persits methods"
        On Error Resume Next
        pdf.AddPage
        pdf.SetFont "Arial", "B", 12
        pdf.Cell 40, 10, "Native G3PDF Cell", 1, 0, "C", False, ""
        If Err.Number = 0 Then
            Pass "Native G3PDF methods work correctly"
        Else
            Fail "Native G3PDF methods error: " & Err.Description
        End If
        On Error Goto 0

        ' ======== SUMMARY ========
        Response.Write "<h2>Test Summary</h2>"
        Response.Write "<div class=""box"">"
        Response.Write "<strong>Total:</strong> " & testCount & " | "
        Response.Write "<span style=""color:green;""><strong>Passed:</strong> " & passCount & "</span> | "
        Response.Write "<span style=""color:red;""><strong>Failed:</strong> " & failCount & "</span><br>"
        If failCount = 0 Then
            Response.Write "<span style=""color:green;font-size:1.2em;"">All tests passed!</span>"
        Else
            Response.Write "<span style=""color:red;font-size:1.2em;"">Some tests failed. Review details above.</span>"
        End If
        Response.Write "</div>"

        ' Cleanup
        Set canvas = Nothing
        Set page = Nothing
        Set font = Nothing
        Set doc = Nothing
        Set pdf = Nothing
        %>
        </div>
    </body>

</html>