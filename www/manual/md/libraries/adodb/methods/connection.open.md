# Connection.Open Method

Opens the database connection using the configured connection string.

## Syntax

```asp
conn.Open [connectionString]
```

## Parameters and Arguments

| Parameter | Type | Required | Description |
|---|---|---|---|
| `connectionString` | String | No | Overrides `ConnectionString` for this call. |

## Return Value

Empty. The method does not return a value.

## Remarks

- Method names are case-insensitive.
- If no parameter is provided, `ConnectionString` must already be set.
- After a successful call, `State` becomes `1`.
- AxonASP accepts connection strings for common database providers through its ADODB layer.
- Use a MySQL connection string with `Driver=MySQL` or another value that resolves to the MySQL driver, plus `Server`, `Port`, `Database`, `Uid`, and `Pwd` values.
- Use a SQL Server connection string with `Driver=SQL Server`, `Driver=MSSQL`, or `Provider=SQLOLEDB`, plus the server, database, user name, and password values.
- Use a SQLite connection string with the `sqlite:` prefix or `Driver=SQLite` and a file path or `:memory:` data source.
- Use a PostgreSQL connection string with `Driver=PostgreSQL`, plus `Host`, `Port`, `Database`, `Uid`, and `Pwd` values.
- Use an Access connection string with `Provider=Microsoft.ACE.OLEDB.12.0` or `Provider=Microsoft.Jet.OLEDB.4.0`. **This example works only on Windows** because the ACE and Jet providers depend on Windows COM components.
- If the provider or driver is missing, `Open` raises a provider error.

## Code Example

```asp
<%
Option Explicit
Dim conn

' MySQL
Set conn = Server.CreateObject("ADODB.Connection")
conn.ConnectionString = "Driver=MySQL;Server=127.0.0.1;Port=3306;Database=axonasp;Uid=root;Pwd=secret;"
conn.Open
Response.Write "MySQL state: " & CStr(conn.State) & "<br>"
conn.Close

' MSSQL
conn.ConnectionString = "Driver=SQL Server;Server=127.0.0.1;Database=axonasp;Uid=sa;Pwd=secret;"
conn.Open
Response.Write "MSSQL state: " & CStr(conn.State) & "<br>"
conn.Close

' SQLite
conn.ConnectionString = "sqlite:" & Server.MapPath("./data/axonasp.db")
conn.Open
Response.Write "SQLite state: " & CStr(conn.State) & "<br>"
conn.Close

' PostgreSQL
conn.ConnectionString = "Driver=PostgreSQL;Host=127.0.0.1;Port=5432;Database=axonasp;Uid=postgres;Pwd=secret;"
conn.Open
Response.Write "PostgreSQL state: " & CStr(conn.State) & "<br>"
conn.Close

' Access
' Windows only: Microsoft ACE or Jet OLE DB must be installed on the host.
conn.ConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & Server.MapPath("./data/axonasp.accdb") & ";Persist Security Info=False;"
conn.Open
Response.Write "Access state: " & CStr(conn.State) & "<br>"
conn.Close

Set conn = Nothing
%>
```