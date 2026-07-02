<script language="VBScript" runat="server">
Sub InitGlobalConfig()
    If Application("ProjectID") <> "" Then
    Application("ConfigLoaded") = True
    End If
End Sub
</script>