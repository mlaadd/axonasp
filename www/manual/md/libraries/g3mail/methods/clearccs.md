# ClearCCs Method

## Overview
The **ClearCCs** method clears all recipient email addresses from the CC (carbon copy) list. It is provided for SMTPsvg.Mailer (ASPMail) compatibility.

## Syntax
```asp
mail.ClearCCs()
```

## Parameters and Arguments
This method does not take any arguments.

## Return Values
Returns a **Boolean** (True).

## Remarks
- This method is a compatibility alias for clearing the CC recipient list.
- It removes all CC addresses added via the **AddCC** method.

## Code Example
```asp
<%
Dim mail
Set mail = Server.CreateObject("SMTPsvg.Mailer")
mail.AddCC "Alice Smith", "alice@example.com"
mail.ClearCCs()
%>
```
