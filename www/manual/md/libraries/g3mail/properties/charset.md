# CharSet Property

## Overview
The **CharSet** property gets or sets the character encoding set of the email message for the G3MAIL object. It is provided for Persits.MailSender (ASPEmail) compatibility.

## Syntax
```asp
value = mail.CharSet
mail.CharSet = newValue
```

## Parameters and Arguments
- **newValue** (String): The character set name (e.g. "utf-8", "iso-8859-1").

## Return Values
Returns a **String** containing the current character set.

## Remarks
- If **CharSet** is specified, it will be mapped into the Content-Type headers of the message payload (e.g., `text/plain; charset=utf-8` or `text/html; charset=utf-8`).

## Code Example
```asp
<%
Dim mail
Set mail = Server.CreateObject("Persits.MailSender")
mail.CharSet = "utf-8"
%>
```
