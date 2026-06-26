# FromAddress Property

## Overview
The **FromAddress** property gets or sets the sender's email address of the G3MAIL object. This property is an alias for the **From** property, provided for SMTPsvg.Mailer (ASPMail) compatibility.

## Syntax
```asp
value = mail.FromAddress
mail.FromAddress = newValue
```

## Parameters and Arguments
- **newValue** (String): The sender's email address.

## Return Values
Returns a **String** containing the current sender address.

## Remarks
- Setting **FromAddress** updates the internal sender email address of the G3MAIL instance.
- This property is case-insensitive.

## Code Example
```asp
<%
Dim mail
Set mail = Server.CreateObject("SMTPsvg.Mailer")
mail.FromAddress = "sender@example.com"
%>
```
