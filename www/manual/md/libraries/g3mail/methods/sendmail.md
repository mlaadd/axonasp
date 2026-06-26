# SendMail Method

## Overview
The **SendMail** method connects to the configured SMTP server and sends the email payload. It is an alias for the **Send** method, provided for SMTPsvg.Mailer (ASPMail) compatibility.

## Syntax
```asp
result = mail.SendMail()
```

## Return Values
Returns a **Boolean** (True on success) or a **String** describing the error on failure.

## Remarks
- Requires standard SMTP host, sender, and recipient properties to be set.
- Under the hood, this relies on `gomail.v2` for secure payload delivery.

## Code Example
```asp
<%
Dim mail, result
Set mail = Server.CreateObject("SMTPsvg.Mailer")
mail.RemoteHost = "smtp.example.com"
mail.FromAddress = "sender@example.com"
mail.AddRecipient "John", "john@example.com"
mail.Subject = "Hello"
mail.BodyText = "Body content"

result = mail.SendMail()
%>
```
