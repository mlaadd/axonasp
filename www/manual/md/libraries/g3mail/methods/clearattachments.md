# ClearAttachments Method

## Overview
The **ClearAttachments** method clears all attached files from the email payload. It is provided for Persits.MailSender (ASPEmail) compatibility.

## Syntax
```asp
mail.ClearAttachments()
```

## Return Values
Returns a **Boolean** (True).

## Code Example
```asp
<%
Dim mail
Set mail = Server.CreateObject("Persits.MailSender")
mail.AddAttachment "C:\file.pdf"
mail.ClearAttachments()
%>
```
