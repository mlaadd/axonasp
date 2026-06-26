# ClearBcc Method

## Overview
The **ClearBcc** method clears all recipient email addresses from the BCC (blind carbon copy) list. It is provided for Persits.MailSender (ASPEmail) compatibility.

## Syntax
```asp
mail.ClearBcc()
```

## Return Values
Returns a **Boolean** (True).

## Code Example
```asp
<%
Dim mail
Set mail = Server.CreateObject("Persits.MailSender")
mail.AddBcc "user@example.com"
mail.ClearBcc()
%>
```
