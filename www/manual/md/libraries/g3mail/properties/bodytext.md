# BodyText Property

## Overview
The **BodyText** property gets or sets the text body of the email message for the G3MAIL object. This property is an alias for the **Body** property, provided for SMTPsvg.Mailer (ASPMail) compatibility.

## Syntax
```asp
value = mail.BodyText
mail.BodyText = newValue
```

## Parameters and Arguments
- **newValue** (String): The text content of the email body.

## Return Values
Returns a **String** containing the current message body text.

## Remarks
- Setting **BodyText** updates the internal message body of the G3MAIL instance and resets **IsHTML** to False.
- This property is case-insensitive.

## Code Example
```asp
<%
Dim mail
Set mail = Server.CreateObject("SMTPsvg.Mailer")
mail.BodyText = "This is a plain text body using ASPMail compatibility."
%>
```
