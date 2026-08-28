# Weather Example Plugin

This example plugin demonstrates how to create a simple plugin that fetches the current weather for a given location using the [Open Meteo API](https://open-meteo.com).
This demonstrates how to create a plugin that fetches data from an external API and saves settings to a file.

In the end, we'll create three commands: `/get-weather-at`, `/set-location`, and `/get-weather`. `/get-weather-at` fetches the weather for a given location using latitude and longitude, `/set-location` sets the location for the user, and `/get-weather` fetches the weather for the user's location.

## Reading parameters

To start, let's implement the `/get-weather-at` command.
This command takes two parameters: the latitude and longitude of the location to fetch the weather for.
We can read these parameters from the `ctx` object passed to the command handler.
The `#!lua ctx.words` table contains the command and its arguments.
The first element is the command itself, and the rest are the arguments.
Thus, the latitude and longitude are `#!lua ctx.words[2]` and `#!lua ctx.words[3]`, respectively.

In addition to the lua script, we'll need to create a `info.json` file to store the metadata of the plugin.
The `info.json` file contains information about the plugin, such as the name, author, version, and description.

<!-- prettier-ignore-start -->
=== ":octicons-file-code-16: `init.lua`"
    ```lua
    --8<-- "docs/plugins/snippets/weather-0-read-params.lua"
    ```

    1. The `%f` format specifier is used to format a floating-point number (a number with a comma).
=== ":material-code-json: `info.json`"
    ```json
    --8<-- "docs/plugins/snippets/weather-start.json"
    ```
=== ":material-file-tree: Directory Structure"
    ```text
    Plugins/
    └── Weather/
        ├── info.json
        └── init.lua
    ```
<!-- prettier-ignore-end -->

Try it out!

<!-- prettier-ignore -->
```markdown
> /get-weather-at 1.23 4.56
latitude: 1.230000 longitude: 4.560000
> /get-weather-at 1.23
Usage: /get-weather-at [latitude] [longitude]
```

## Fetching weather data

Next, we'll fetch the weather data from the Open Meteo API.

Before we can fetch the weather data, we need to add the `Network` permission to the plugin.
In your `info.json` file, add `#!json "permissions": [{type: "Network"}]` to the JSON object.

```json title="info.json" hl_lines="8-12"
--8<-- "docs/plugins/snippets/weather-http.json"
```

We'll use the `c2.HTTPRequest` class provided by Chatterino to make an HTTP request to the API.
The API requires the latitude and longitude of the location to fetch the weather for.
We'll construct the URL using the latitude and longitude parameters and make a `GET` request to fetch the weather data.

An example response from the API looks like this (simplified for brevity):

```json
{
    "current": {
        "temperature_2m": 0.6
    }
}
```

To parse the JSON response, we'll use [`json.lua`](https://github.com/rxi/json.lua), a simple JSON parser for Lua.
We'll create a new file `json.lua` and add the [JSON parser code](https://github.com/rxi/json.lua/blob/dbf4b2dd2eb7c23be2773c89eb059dadd6436f94/json.lua) to it (additionally, the code is provided at the bottom, in [The final result](#the-final-result)).

We can import the JSON parser in our `init.lua` script using the `require` function.
Then, we'll parse the JSON response and extract the temperature from it.

```lua title="init.lua"
--8<-- "docs/plugins/snippets/weather-1-make-request.lua"
```

1. These are annotations for the [Lua language server](https://luals.github.io/).
   They are not part of the code. Using these annotations, the language server can provide better autocompletion and type checking.
2. Make sure to execute the request. Otherwise, the request will not be sent.

Now, we can use the `get_weather_at` function to fetch the weather for a given location:

```lua title="init.lua" hl_lines="7-12"
--8<-- "docs/plugins/snippets/weather-2-invoke-request.lua"
```

Try it out!

<!-- prettier-ignore -->
```markdown
> /get-weather-at 1.23 4.56
It is currently 27.0°C
> /get-weather-at -30 20
It is currently 15.8°C
```

## Named locations

Remembering the latitude and longitude of a location can be cumbersome.
Let's add a command `/set-location` that allows users to set a named location.
In addition to weather info, Open Meteo provides a Geocoding API that can convert a location name to latitude and longitude.
We'll use this API to fetch the latitude and longitude for a given location name.

An example response from the Geocoding API looks like this (simplified for brevity):

```json
{
    "results": [
        {
            "name": "Berlin",
            "latitude": 52.52437,
            "longitude": 13.41053,
            "country": "Germany"
        }
    ]
}
```

Since we'll be adding user-input to the URL, we need to encode it to ensure it's safe to use in a URL.
We added a `urlencode` that facilitates this.

```lua title="init.lua"
--8<-- "docs/plugins/snippets/weather-3-urlencode.lua"
```

1. Replace all characters that are not alphanumeric nor spaces, with a percent sign (`%`) followed by two hexadecimal digits.
2. Replace spaces with a plus sign (`+`).

Now, we can use this to escape the location name and fetch the latitude and longitude for a given location:

```lua title="init.lua"
--8<-- "docs/plugins/snippets/weather-4-geocoding.lua"
```

1. A helper type for a place returned by the Geocoding API. If you know TypeScript, this is similar to an `interface`.
2. If no place is found, the API doesn't include the `results` field in the response.
   We check for this case and return an error message.

In the `/set-location` command, we can now print the name and country of the location:

```lua title="init.lua"
--8<-- "docs/plugins/snippets/weather-5-print-location.lua"
```

1. To combine all arguments, we use concatenate all elements of the `#!lua ctx.words` table starting from the second element (index 2) with a space separator (the first element is the command itself).

Try it out!

<!-- prettier-ignore -->
```markdown
> /set-location Oslo
Your location is Oslo in Norway.
> /set-location Amsterdam
Your location is Amsterdam in Netherlands.
> /set-location NonExistentCity
Failed to find your location: No matching locations found!
```

## Saving and loading settings

In the `/set-location` and `/get-weather` commands, we need to access the user's location.
To persist this information across sessions, we'll save the location to a file.
We'll use Lua's `io` library to read and write to a file.

Similar to network requests, we need to add the `FilesystemRead` and `FilesystemWrite` permissions to the plugin.

```json title="info.json" hl_lines="12-17"
--8<-- "docs/plugins/snippets/weather-full.json"
```

We save the JSON object of the place we [got from the Geocoding API](#named-locations) to a file. With `io.open`, we open the file in our own `/data` directory. This is scoped to our plugin. To write to a file, we pass `#!lua "w"` as the second argument and to read from a file, we pass `#!lua "r"`. We then write the JSON object to the file using `file:write`.

```lua title="init.lua"
--8<-- "docs/plugins/snippets/weather-6-save-load-location.lua"
```

Now we can use `save_location` in the `/set-location` command to save the location to a file:

```lua title="init.lua" hl_lines="3-11"
--8<-- "docs/plugins/snippets/weather-7-set-location.lua"
```

Analogously, we can use `load_location` in the `/get-weather` command to load the location from a file:

```lua title="init.lua" hl_lines="2"
--8<-- "docs/plugins/snippets/weather-8-get-weather.lua"
```

Try it out!

<!-- prettier-ignore -->
```markdown
> /set-location Berlin
Updated your location to Berlin in Germany.
> /get-weather
It is currently 4.4°C in Berlin.
> /set-location Paris
Updated your location to Paris in France.
> /get-weather
It is currently 7.5°C in Paris.
```

As a next step, you could merge the `/get-weather-at` and `/get-weather` commands into a single command that fetches the weather for the user's location if no arguments are provided.
If two numbers are provided, it fetches the weather for the given latitude and longitude.
And if string arguments are provided, it fetches the weather for the given location name.

## The final result

<!-- prettier-ignore -->
=== ":material-code-json: `info.json`"
    ```json
    --8<-- "docs/plugins/snippets/weather-full.json"
    ```
=== ":octicons-file-code-16: `init.lua`"
    ```lua
    --8<-- "docs/plugins/snippets/weather-full.lua"
    ```
=== ":octicons-file-code-16: `json.lua`"
    ```lua
    --8<-- "docs/plugins/snippets/json.lua"
    ```
=== ":material-file-tree: Directory Structure"
    ```text
    Plugins/
    └── Weather/
        ├── data/ (created at runtime)
        │   └── location.json
        ├── info.json
        ├── init.lua
        └── json.lua
    ```
