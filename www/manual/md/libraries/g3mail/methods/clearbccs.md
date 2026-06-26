# ClearBCCs Method

## Overview
The **ClearBCCs** method clears all recipient email addresses from the BCC (blind carbon copy) list. It is provided for SMTPsvg.Mailer (ASPMail) compatibility.

## Syntax
```asp
mail.ClearBCCs()
```

## Parameters and Arguments
This method does not take any arguments.

## Return Values
Returns a **Boolean** (True).

## Remarks
- This method is a compatibility alias for clearing the BCC recipient list.
- It removes all BCC addresses added via the **AddBCC** method.

## Code Example
```asp
<%
Dim mail
Set mail = Server.CreateObject("SMTPsvg.Mailer")
mail.AddBCC "Alice Smith", "alice@example.com"
mail.ClearBCCs()
%>
```
