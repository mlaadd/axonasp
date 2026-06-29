# Manage Server Configuration with AxonAdmin

## Overview

The `axonadmin` executable is a dedicated command-line and web-based configuration management tool for the AxonASP project. It provides an interactive visual dashboard to edit configuration parameters dynamically and features a headless creation mode to bootstrap default settings. It makes it easy to manage the `axonasp.toml` configuration file, which governs the behavior of the AxonASP server and its associated components.

## Syntax

Run `axonadmin` from the command line using the following syntax:

```cmd
axonadmin.exe [flags]
```

## Parameters and Arguments

The tool accepts the following command-line flags:

* **-edit <path>**
  Specifies the absolute or relative path to the `axonasp.toml` configuration file to edit in UI mode. If omitted, the tool automatically resolves the path using the standard search sequence.
* **-create <path>**
  Generates a new default `axonasp.toml` file at the specified target path. If no path is specified, the file is created at `./config/axonasp.toml` by default.
* **-noui**
  Runs the tool in headless mode. This flag must be used in conjunction with the **-create** flag.
* **-h, -help**
  Displays the standard command-line help menu containing usage details.

## Remarks

### UI Execution Mode
When run without headless flags, `axonadmin` starts an HTTP configuration server on **localhost:8088** and automatically opens the system's default web browser. In Linux, the user must have a graphical environment and a default browser installed for this feature to work. The user can then interact with the configuration dashboard to modify settings, which are saved back to the specified `axonasp.toml` file.

### Path Resolution Sequence
If the **-edit** flag is omitted, the tool attempts to find the configuration target in the following order:
1. `config/axonasp.toml` relative to the current working directory.
2. `../config/axonasp.toml` relative to the current working directory.
3. `../../config/axonasp.toml` relative to the current working directory.
4. `config/axonasp.toml` relative to the location of the executing binary.

If no file is found, the default configuration schema is loaded in memory for editing and can be saved to a new file using the **-create** flag. You can also specify a custom path for the configuration file using the **-edit** or **-create** flags.

## Code Example

```cmd
:: Create a default configuration in a custom path in headless mode
axonadmin.exe -create C:\axonasp\config\my_config.toml -noui

:: Open the visual configuration editor for a specific file
axonadmin.exe -edit C:\axonasp\config\my_config.toml
```
