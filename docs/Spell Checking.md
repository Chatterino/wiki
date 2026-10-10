# Spell Checking

<!-- prettier-ignore -->
!!! warning "Beta Warning"
    Spell checking is an experimental feature. Processes described in this page may become outdated in future releases.

TODO

## Obtaining Dictionaries

https://github.com/wooorm/dictionaries/blob/main/readme.md#list-of-dictionaries

 - `index.aff`
 - `index.dic`

## Installing Dictionaries

1. Copy both files (`index.aff` & `index.dic`) to the `Dictionaries` folder inside your [Chatterino Folder](chatterino-folder)
  - Both files must be named the same
  - Chatterino's settings will use the file names as the displayed name of the dictionary, so it's recommended to rename these to match the language (i.e. `en.aff` & `en.dic` for English)
1. Restart Chatterino
1. Open the `Settings` -> `External tools` page
1. Under the `Spell checker` section, select your downloaded dictionary from the `Default dictionary` dropdown
1. Restart chatterino to apply

[chatterino-folder]: Settings.md/#where-is-my-chatterino-folder-located
