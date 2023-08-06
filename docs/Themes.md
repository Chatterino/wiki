# Themes

<!-- prettier-ignore -->
!!! warning "Beta Warning"
    Custom themes are not yet stable. There may be breaking changes in the future (see [Migrations](#migrations)).

Chatterino supports custom-made themes since [nightly][nightly] [`5d0bdc1`][5d0bdc1].

Custom themes are JSON files that are stored in the `Themes` folder inside your [Chatterino directory][chatterino-dir].

## Creating A Theme

To create a theme, it's best to use one of the built-in themes as the starting point.
You can find them in the [`resources/themes`][res-themes] folder inside the source-code.
Copy one into the `Themes` folder and restart Chatterino.
When you open the settings and select a theme, you should see one prefixed with `Custom:`.

### Schema

Chatterino themes have a JSON schema that must match in order for the theme to be displayed correctly.
Many editors support JSON schemas out of the box and warn you about invalid values and provide completions.

If you used one of the base themes, then the `$schema` key inside the JSON is invalid, since its value is configured to work inside the Chatterino source-code. You should change the value of `$schema` to `https://github.com/Chatterino/chatterino2/raw/master/docs/ChatterinoTheme.schema.json` as shown below. If you want to pin the schema to a specific version, replace `master` with your desired version (for example `v2.4.4`).

```js
{
    "$schema": "https://github.com/Chatterino/chatterino2/raw/master/docs/ChatterinoTheme.schema.json",
    // ...
}
```

### Auto Reloading

When developing themes, you often want to reload your changes and see how they look.
To aid you in doing that, Chatterino can automatically reload your theme.
Use the `/c2-theme-autoreload` command in any chat to toggle auto-reload.

<!-- prettier-ignore -->
!!! warning
    Make sure to disable auto-reloading after you're done with your changes to reduce resource usage.

### Colors

Colors in themes can be specified in various ways.
All values that expect a `qt-color` accept one of the following values.
Make sure you're using the [schema](#schema) to get editor feedback.
Technically, the values are passed to [`QColor`](https://doc.qt.io/qt-6/qcolor.html#fromString) which does the parsing.

#### Hex Colors

`A`, `R`{ style="color: red" }, `G`{ style="color: green" }, and `B`{ style="color: blue" } are single hex digits (0-9, a-f, A-F).

-   <code>#<span style="color: red">R</span><span style="color: green">G</span><span style="color: blue">B</span></code>
-   <code>#<span style="color: red">RR</span><span style="color: green">GG</span><span style="color: blue">BB</span></code>
-   <code>#AA<span style="color: red">RR</span><span style="color: green">GG</span><span style="color: blue">BB</span></code> _This format is different from the CSS Color Moudle Level 4 [`<hex-color>`](https://developer.mozilla.org/docs/Web/CSS/hex-color), where the alpha value is at the end._

-   <code>#<span style="color: red">RRR</span><span style="color: green">GGG</span><span style="color: blue">BBB</span></code>
-   <code>#<span style="color: red">RRRR</span><span style="color: green">GGGG</span><span style="color: blue">BBB</span></code>

#### Named Colors

-   **[SVG color keyword names](https://www.w3.org/TR/SVG11/types.html#ColorKeywords)** - For example `red`{ style="color: red" }, `mediumspringgreen`{ style="color: mediumspringgreen" }. Note that these color names are technically case-insensitive and accept spaces, but this isn't supported by the [schema](#schema), which only accepts lower-case names.
-   `transparent`

## Migrations

This section contains added, updated, and removed properties in a release, and commit for [nightly] versions.

[nightly]: Help.md/#what-is-nightly-and-how-to-use-install-it
[5d0bdc1]: https://github.com/Chatterino/chatterino2/commit/5d0bdc195e42863c5176d8ba3c0ecd2409d50805
[chatterino-dir]: Settings.md/#where-is-my-chatterino-folder-located
[res-themes]: https://github.com/Chatterino/chatterino2/tree/master/resources/themes
