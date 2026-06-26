# RemoteHost Property

## Overview
The **RemoteHost** property gets or sets the SMTP server address of the G3MAIL object. This property is an alias for the **Host** property, provided for SMTPsvg.Mailer (ASPMail) compatibility.

## Syntax
```asp
value = mail.RemoteHost
mail.RemoteHost = newValue
```

## Parameters and Arguments
- **newValue** (String): The SMTP server address or hostname.

## Return Values
Returns a **String** containing the current SMTP server host.

## Remarks
- Setting **RemoteHost** updates the internal SMTP server address of the G3MAIL instance.
- This property is case-insensitive.

## Code Example
```asp
<%
Dim mail
Set mail = Server.CreateObject("SMTPsvg.Mailer")
mail.RemoteHost = "smtp.example.com"
%>
```
