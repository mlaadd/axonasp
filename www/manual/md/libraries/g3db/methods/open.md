# Open a Database Connection

## Overview

Opens a database connection pool and validates connectivity with an internal ping.

## Prerequisites

Instantiate the library with `Server.CreateObject("G3DB")`.

## Syntax

```asp
ok = db.Open(driver, dsn)
```

## Parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| **driver** | String | Yes | Database driver name. |
| **dsn** | String | Yes | Driver-specific connection string. |

## Return Value

- **Boolean `True`**: Connection opened and ping validation succeeded.
- **Boolean `False`**: Arguments are missing, driver is unsupported, connection is already open, or open/ping failed.

## Remarks

- Driver names are normalized before opening.
- On failure, error details are available in `LastError`.
- G3DB accepts driver aliases for common providers: `mysql` or `mariadb`, `postgres`, `postgresql`, or `pgsql`, `mssql`, `sqlserver`, or `sql server`, `sqlite` or `sqlite3`, and `oracle`, `ora`, `oci`, or `oci8`.
- Use the driver-specific DSN format that matches the backend:
  - MySQL: `user:pass@tcp(host:port)/dbname?parseTime=true`
  - MSSQL: `server=host;port=1433;user id=user;password=pass;database=dbname`
  - SQLite: `C:\path\to\database.db?_busy_timeout=5000` or a path from configuration
  - Oracle: `oracle://user:pass@host:1521/service_name`
  - PostgreSQL: `host=host port=5432 user=user password=pass dbname=dbname sslmode=disable`

## Example

```asp
<%
Option Explicit
Dim db, ok
Set db = Server.CreateObject("G3DB")

ok = db.Open("mysql", "user:pass@tcp(127.0.0.1:3306)/app?parseTime=true")
If ok Then
    Response.Write "MySQL connected: " & CStr(db.IsOpen) & "<br>"
    db.Close
Else
    Response.Write db.LastError
End If

ok = db.Open("mssql", "server=127.0.0.1;port=1433;user id=sa;password=secret;database=axonasp")
If ok Then
    Response.Write "MSSQL connected: " & CStr(db.IsOpen) & "<br>"
    db.Close
Else
    Response.Write db.LastError & "<br>"
End If

ok = db.Open("sqlite", Server.MapPath("./data/axonasp.db") & "?_busy_timeout=5000")
If ok Then
    Response.Write "SQLite connected: " & CStr(db.IsOpen) & "<br>"
    db.Close
Else
    Response.Write db.LastError & "<br>"
End If

ok = db.Open("oracle", "oracle://axonasp:secret@127.0.0.1:1521/ORCLCDB")
If ok Then
    Response.Write "Oracle connected: " & CStr(db.IsOpen) & "<br>"
    db.Close
Else
    Response.Write db.LastError & "<br>"
End If

ok = db.Open("postgres", "host=127.0.0.1 port=5432 user=postgres password=secret dbname=axonasp sslmode=disable")
If ok Then
    Response.Write "PostgreSQL connected: " & CStr(db.IsOpen) & "<br>"
    db.Close
Else
    Response.Write db.LastError & "<br>"
End If

Set db = Nothing
%>
```

## API Reference

- **Object**: `G3DB`
- **Method**: `Open`
- **Arguments**: `driver` (String, required), `dsn` (String, required)
- **Returns**: Boolean — `True` on success, `False` on failure
