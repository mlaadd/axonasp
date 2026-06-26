# ClearAddresses Method

## Overview
The **ClearAddresses** method clears all recipient email addresses from the primary destination list (To). It is provided for Persits.MailSender (ASPEmail) compatibility.

## Syntax
```asp
mail.ClearAddresses()
```

## Return Values
Returns a **Boolean** (True).

## Code Example
```asp
<%
Dim mail
Set mail = Server.CreateObject("Persits.MailSender")
mail.AddAddress "user@example.com"
mail.ClearAddresses()
%>
```
