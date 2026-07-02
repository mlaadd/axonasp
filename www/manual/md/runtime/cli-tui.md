# AxonASP CLI and TUI

## Overview

The AxonASP CLI (`axonasp-cli.exe`) provides a command-line interface for executing ASP, VBScript, and JavaScript code. It features an interactive REPL (Read-Eval-Print Loop) and a direct execution mode.

## Command-Line Arguments

The CLI supports the following flags:

| Flag | Long Flag | Description |
| --- | --- | --- |
| `-r <file>` | `--run <file>` | Runs the specified file directly and returns its output. |
| `-m <mode>` | `--mode <mode>` | Sets the engine mode (`default`, `vbscript`, `javascript`). |
| `-h` | `--help` | Shows the help message. |

### Engine Modes

The `-m` or `--mode` flag allows you to specify how the input file should be processed:

- **default**: Standard ASP mode. Files are treated as HTML with `<% %>` delimiters. This is the default behavior.
- **vbscript**: Pure VBScript mode. Files (typically `.vbs`) are treated as source code only, bypassing ASP delimiter parsing.
- **javascript**: Pure JavaScript mode. Files (typically `.js`) are treated as source code only, bypassing ASP delimiter parsing.

**Example: Running a pure VBScript file**
```powershell
.\axonasp-cli.exe -m vbscript -r tools/maintenance.vbs
```

**Example: Running a pure JavaScript file**
```powershell
.\axonasp-cli.exe -m javascript -r scripts/utils.js
```

### Environment Variables

The CLI reads environment variables to populate ASP request collections:

*   **QUERY_STRING**: Supply raw query parameters to the executed script (populating the `Request.QueryString` collection).

**Example: Running a script with Query String parameters in PowerShell**
```powershell
$env:QUERY_STRING="category=books&tag=scifi&tag=thriller"
.\axonasp-cli.exe -r tests/test_jscript_collection.asp
Remove-Item Env:\QUERY_STRING
```

## Interactive REPL

Starting the CLI without the `-r` flag enters the interactive REPL. You can type ASP code directly and see the results immediately.

The REPL supports standard ASP intrinsic objects (`Response`, `Request`, `Server`, etc.) and all built-in AxonASP libraries.

## TUI (Text User Interface)

When enabled in configuration (`cli.enable_cli = true`), the CLI provides a rich text-based user interface for managing and executing scripts.
