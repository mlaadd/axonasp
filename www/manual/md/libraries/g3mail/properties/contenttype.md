# ContentType Property

## Overview
The **ContentType** property gets or sets the MIME Content-Type of the email message for the G3MAIL object. It is provided for SMTPsvg.Mailer (ASPMail) compatibility.

## Syntax
```asp
value = mail.ContentType
mail.ContentType = newValue
```

## Parameters and Arguments
- **newValue** (String): The MIME Content-Type string (e.g. "text/html" or "text/plain").

## Return Values
Returns a **String** containing the current Content-Type of the email body.

## Remarks
- If the Content-Type contains the substring "html" (case-insensitive), **IsHTML** is automatically set to True. Otherwise, it is set to False.
- The property defaults to "text/plain".

## Code Example
```asp
<%
Dim mail
Set mail = Server.CreateObject("SMTPsvg.Mailer")
mail.ContentType = "text/html"
mail.Body = "<h1>HTML Message</h1>"
%>
```
