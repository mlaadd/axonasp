# ClearCC Method

## Overview
The **ClearCC** method clears all recipient email addresses from the CC (carbon copy) list. It is provided for Persits.MailSender (ASPEmail) compatibility.

## Syntax
```asp
mail.ClearCC()
```

## Return Values
Returns a **Boolean** (True).

## Code Example
```asp
<%
Dim mail
Set mail = Server.CreateObject("Persits.MailSender")
mail.AddCC "user@example.com"
mail.ClearCC()
%>
```
