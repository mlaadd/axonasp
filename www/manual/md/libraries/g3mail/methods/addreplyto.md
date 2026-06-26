# AddReplyTo Method

## Overview
The **AddReplyTo** method appends an email address to the Reply-To headers list. It is provided for Persits.MailSender (ASPEmail) compatibility.

## Syntax
```asp
result = mail.AddReplyTo(email)
```

## Parameters and Arguments
- **email** (String, Required): The email address to receive replies to this message.

## Return Values
Returns a **Boolean** (True).

## Remarks
- You can add one or more Reply-To addresses.
- This is commonly used when you want the recipient to reply to a different mailbox than the sender address.

## Code Example
```asp
<%
Dim mail
Set mail = Server.CreateObject("Persits.MailSender")
mail.AddReplyTo "support@example.com"
%>
```
