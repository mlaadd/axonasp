# G3MAIL Methods

## Overview

This page summarizes every method exposed by `G3MAIL` in G3Pix AxonASP.

## Methods

| Method | Returns | Description |
|---|---|---|
| `AddAddress(address)` | Boolean | Adds one recipient address to the To list. Returns `True`. |
| `AddAddress(email, [name])` | Boolean | Adds one recipient address to the To list. Supports email-only or email + name parameters. |
| `AddAttachment(filepath)` | Boolean | Attaches a file to the email. |
| `AddBcc(email, [name])` | Boolean | Adds one recipient address to the BCC list. |
| `AddBCC(name, email)` | Boolean | ASPMail alias for `AddBcc` with reversed parameters. |
| `AddCC(email, [name])` | Boolean | Adds one recipient address to the CC list. |
| `AddCC(name, email)` | Boolean | ASPMail alias for `AddCC` with reversed parameters. |
| `AddRecipient(name, email)` | Boolean | ASPMail alias for `AddAddress` with reversed parameters. |
| `AddReplyTo(email)` | Boolean | Adds a Reply-To address to the email headers. |
| `AddRelatedBodyPart(filepath, cid)` | Object | Embeds a related resource (e.g. an image) with Content-ID. |
| `Clear()` | Boolean | Clears all recipients, subject, body, attachments, and related parts. |
| `ClearAddresses()` | Boolean | ASPEmail method to clear the To recipient list. |
| `ClearAttachments()` | Boolean | ASPEmail method to clear all attached files. |
| `ClearBcc()` | Boolean | ASPEmail method to clear the BCC recipient list. |
| `ClearBCCs()` | Boolean | ASPMail method to clear the BCC recipient list. |
| `ClearCC()` | Boolean | ASPEmail method to clear the CC recipient list. |
| `ClearCCs()` | Boolean | ASPMail method to clear the CC recipient list. |
| `ClearRecipients()` | Boolean | ASPMail method to clear the To recipient list. |
| `Send()` | Boolean or String | Sends using configured properties. |
| `SendMail()` | Boolean or String | ASPMail alias for `Send()`. |

## Remarks

- Instantiate the library with `Server.CreateObject("G3MAIL")`.
- Method names are case-insensitive.
- `Send` does not return Empty for operational failure; it returns an error string.
