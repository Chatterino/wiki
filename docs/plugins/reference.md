# Reference

This page provides a reference for Chatterino Lua plugins. It doesn't list the entire API, as the feature is still in development, but it describes the basic structure of a plugin and how to interact with the Chatterino API.

## Directory Structure

Chatterino plugins are located in the `Plugins` directory in the [Chatterino configuration directory](../Settings.md#where-is-my-chatterino-folder-located).
Each plugin uses its own directory with at least an `init.lua` and `info.json` file.
The `info.json` file contains metadata about the plugin, such as the name and version.
The `init.lua` file is the entry point of the plugin and is executed when the plugin is loaded.

```text
Chatterino/
├── Logs/
├── Cache/
├── Misc/
└── Plugins/
    ├── MyPlugin/
    │   ├── data/
    │   │   └── my-data-file.txt
    │   ├── info.json
    │   └── init.lua
    └── AnotherPlugin/
        ├── info.json
        └── init.lua
```

## Plugin Metadata

Each plugin must have an `info.json` file. It contains metadata about the plugin, such as the name, author, version, permissions, and description. The following keys are available:

<div class="no-wrap-tbl" markdown>

| Key           | Required           | Type           | Description                                                                                |
| ------------- | ------------------ | -------------- | ------------------------------------------------------------------------------------------ |
| `$schema`     | :x:                | `string`       | The URL to the JSON schema for the `info.json` file.                                       |
| `name`        | :white_check_mark: | `string`       | The name of the plugin.                                                                    |
| `description` | :white_check_mark: | `string`       | A description of the plugin.                                                               |
| `authors`     | :white_check_mark: | `string[]`     | An array of authors of the plugin.                                                         |
| `version`     | :white_check_mark: | `string`       | The version of the plugin. Must be SemVer compliant. See [https://semver.org/](semver.org) |
| `license`     | :white_check_mark: | `string`       | SPDX identifier for license of this plugin. See [https://spdx.org/licenses/](spdx.org)     |
| `permissions` | :x:                | `Permission[]` | An array of permissions required by the plugin. See [permissions](#permissions).           |
| `homepage`    | :x:                | `string`       | The URL to the plugin's homepage (a GitHub repository for example).                        |
| `tags`        | :x:                | `string[]`     | An array of tags for the plugin.                                                           |

</div>

**Example:**

```json title="info.json"
{
    "$schema": "https://raw.githubusercontent.com/Chatterino/chatterino2/master/docs/plugin-info.schema.json",
    "name": "My Plugin",
    "description": "This is a description of my plugin.",
    "authors": ["Your Name"],
    "version": "1.0.0",
    "license": "MIT",
    "permissions": [{ "type": "FilesystemRead" }, { "type": "Network" }],
    "homepage": "https://github.com/your-username/your-repo",
    "tags": ["fun", "utility"]
}
```

### Permissions

A permission is an object with a `"type"` key describing the type of permission. The following types are available:

-   `FilesystemRead`: Permission to read files from its `data` directory.
-   `FilesystemWrite`: Permission to write files to its `data` directory.
-   `Network`: Permission to make network requests.

## Lua API

The Lua API is still in development. From the standard Lua 5.4 API, the following functions are available:

-   `io` (except `stdin`, `stdout`, and `stderr`)
-   `math`
-   `string`
-   `table`
-   `utf8`

See the [Lua 5.4 manual](https://www.lua.org/manual/5.4/) for more information.

Since the API is still in development, the reference can be found [in the Chatterino repository](https://github.com/Chatterino/chatterino2/blob/master/docs/wip-plugins.md).

### Type Definitions

Chatterino provides type definitions for the [LuaLS](https://luals.github.io/) language server (available as an extension for many popular editors).
The type definitions can be found in the [`docs` directory](https://github.com/Chatterino/chatterino2/blob/master/docs/plugin-meta.lua) of the Chatterino repository.
Currently, you need to copy the file to your plugin directory to get autocompletion and type checking.
In the future, there will be an addon for the language server.
