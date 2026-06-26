# ClearRecipients Method

## Overview
The **ClearRecipients** method clears all recipient email addresses from the primary destination list (To). It is provided for SMTPsvg.Mailer (ASPMail) compatibility.

## Syntax
```asp
mail.ClearRecipients()
```

## Parameters and Arguments
This method does not take any arguments.

## Return Values
Returns a **Boolean** (True).

## Remarks
- This method is a compatibility alias for clearing the primary recipient list.
- It removes all recipient addresses added via **AddRecipient** or **AddAddress** methods.

## Code Example
```asp
<%
Dim mail
Set mail = Server.CreateObject("SMTPsvg.Mailer")
mail.AddRecipient "Alice Smith", "alice@example.com"
mail.ClearRecipients()
%>
```
