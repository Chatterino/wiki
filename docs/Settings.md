### Where is my Chatterino folder located?
On **Windows**:
`%APPDATA%/Chatterino2`

On **Linux**:
`$HOME/.local/share/chatterino`

On **Mac**:
`$HOME/Library/Application Support/chatterino`


### Files

Commands and Settings have a small backup mechanism that saves the older version in a file like commands.json.bkp-2 incase you want to return to older versions of the file.

- commands.json - Will contain all your chatterino commands
- settings.json - This contains most of your settings, including sensitive data like your login token
- window-layout.json - This contains information which tabs and splits you have open and how they are positioned
- irc.json - When you have a non-twitch IRC connection, this contains the configured servers and settings

## Help

### How do I delete the Chatterino cache / settings?
Navigate to your [Chatterino folder](#where-is-my-chatterino-folder-located) and remove corresponding folders.

 * The *Cache* folder contains cached network requests from Chatterino.
 * The *Logs* folder contains chat logs from chats you've had open in Chatterino.
 * The *Misc* folder contains internal information about the current running instance of Chatterino.
 * The *Settings* folder contains any settings you may have configured in Chatterino (e.g. font size, highlight phrases) and your list of channels open.

### My settings / commands / window layout are not saving
This is usually a case because Chatterino is unable to save settings on your disk. To fix that, try following steps:

1. Run Chatterino as Administrator.
2. Back up your settings by copying them from your [Chatterino folder](#where-is-chatterino-folder-located) to a safe location on your disk and delete them. Restart your computer and try launching Chatterino again.
3. Back up your settings, uninstall Chatterino and install it again, but make sure `Fresh Install` option is checked.
4. Try running Chatterino in portable mode.