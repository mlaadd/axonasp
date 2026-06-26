# G3MAIL Properties

## Overview

This page lists the properties exposed by `G3MAIL`.

## Properties

| Property | Access | Type | Description |
|---|---|---|---|
| `Body` | Read/Write | String | Message body text. |
| `BodyText` | Read/Write | String | Alias for `Body` (ASPMail compatibility). |
| `CharSet` | Read/Write | String | Character set for the message encoding (ASPEmail compatibility). |
| `ContentType` | Read/Write | String | Message MIME content type (e.g. `text/html`, ASPMail compatibility). |
| `From` | Read/Write | String | Sender email address used in the message header. |
| `FromAddress` | Read/Write | String | Alias for `From` (ASPMail compatibility). |
| `FromName` | Read/Write | String | Display name for the sender. |
| `Host` | Read/Write | String | SMTP host name. |
| `HTMLBody` | Read/Write | String | Message HTML body. |
| `IsHTML` | Read/Write | Boolean | Toggles HTML (`True`) or plain-text (`False`) body mode. |
| `Password` | Read/Write | String | SMTP authentication password. |
| `Port` | Read/Write | Integer | SMTP port number. |
| `RemoteHost` | Read/Write | String | Alias for `Host` (ASPMail compatibility). |
| `BodyFormat` | Read/Write | Integer | Body format selector (`0` for HTML, `1` for plain text). |

## Remarks

- Instantiate the library with `Server.CreateObject("G3MAIL")`.
- Property names are case-insensitive.
