# AddRecipient Method

## Overview
The **AddRecipient** method adds a primary recipient to the destination (To) list. It is provided for SMTPsvg.Mailer (ASPMail) compatibility.

## Syntax
```asp
result = mail.AddRecipient(name, email)
```

## Parameters and Arguments
- **name** (String, Required): The display name of the recipient (e.g. "John Doe").
- **email** (String, Required): The email address of the recipient (e.g. "john@example.com").

## Return Values
Returns a **Boolean** (True).

## Remarks
- **CRITICAL:** The parameter order is `(name, email)`. This is the inverse of ASPEmail's `AddAddress(email, name)` method.
- The G3MAIL object automatically detects the reversed order when invoked as **AddRecipient** or when SMTPsvg.Mailer alias is used.

## Code Example
```asp
<%
Dim mail
Set mail = Server.CreateObject("SMTPsvg.Mailer")
mail.AddRecipient "Alice Smith", "alice@example.com"
%>
```
