Having issues with Chatterino or need general assistance? Check the below troubleshooting below corresponding to your operating system for assistance!

[Report a bug/issue](https://github.com/Chatterino/chatterino2/issues/new?assignees=&labels=bug%2C+needs+triage&template=bug_report.md&title=) | [Make a feature suggestion](https://github.com/Chatterino/chatterino2/issues/new?assignees=&labels=enhancement%2C+needs+triage&template=feature-suggestion.md&title=) | [Join the Discord](https://discord.gg/3vmJRwy)

### Basic troubleshooting
Prior to starting on the below, you should first try the basic troubleshooting steps listed here. These steps can resolve a variety of issues:

- Ensure that your Chatterino is up to date.
- [Windows] Try running Chatterino in administrator mode.
- [Windows] Ensure that you have **BOTH** the x86 and x64 Visual C++ Redistributables installed **AND** have restarted your PC after installation:
    - x64: <https://aka.ms/vs/16/release/vc_redist.x64.exe>
    - x86: <https://aka.ms/vs/16/release/vc_redist.x86.exe>
    - Chocolatey: `choco install vcredist140`

### I am having an issue with the Chatterino extension
Chatterino extension issues should be posted [here](https://github.com/Chatterino/chatterino-browser-ext/issues/new).

### Chatterino not starting/Crashing upon startup
- [Windows] Try running Chatterino in administrator mode.
- [Windows] Adding Chatterino to your anti-virus/malware whitelist.
- [Windows] If nothing else works, try resetting your settings using the `Fresh Install` option in the installer.

### Does using Chatterino accumulate Twitch channel points?
Unfortunately not. This is a limitation due to Twitch using internal APIs for channel points.<br>
This will however work with most chatbots, as they simply take you being connected to chat as "watching the stream".

### Can I use Chatterino as my chat overlay for my stream?
You definitely can, but it's not recommended. We suggest using a service similar to [KapChat](https://nightdev.com/kapchat).

### Why are my messages being sent in webchat, but not in Chatterino?
There's a few things to cover here:

- If your message is not sent in Chatterino, it is likely not sent in webchat either. Webchat renders messages whether they are sent or not, Chatterino will only render the message if it is accepted by the server.
- If you're trying to type in a chat where there are a lot of active chatters, then your message may be dropped by Twitch's chat servers (due to the volume).
- If an alt account has been banned in that chat, you have likely been shadowbanned by Twitch in that channel. Which prevents any of your other accounts from speaking in that channel.
- If you have spammed too much in another chat, you have likely been temporarily shadowbanned by Twitch in channels where you are not: Subscribed, VIP or Moderator.

If all else fails, you may be having [connection issues](#chatterino-is-failing-to-connect-to-chat) to Twitch or your network may be blocking the necessary IRC ports in order to connect.

<!--### Chatterino is failing to connect to chat-->

### Chatterino is repeatedly dis/connecting from Twitch chat
If you are having troubles with Chatterino repeatedly connecting/disconnecting, it is likely due to the large amount of channels you are connected to. The maximum channel limit is usually around the 100 mark, but may differ from user to user.
Try closing splits in Chatterino in order to fix this.

### I am unable to send whispers from Chatterino
If you are getting the `Your settings prevent you from sending this whisper` error message, it may be due to:

- You turning on the `Block Whispers from Strangers` option in your [Twitch account security settings](https://www.twitch.tv/settings/security).
- Your account is too new to be able to whisper strangers. If you wish to whisper a user, you must first add them as a friend. This was a spam protection measure put in place by Twitch. This is not a Chatterino bug.

### FFZ/BTTV emotes are not working
You need to be logged in to see emotes.
Try hitting F5 once to manually refresh the emotes.

Chatterino only makes a connection to the necessary APIs to fetch these emotes, if you are still having issues fetching them, then your network may be blocking requests to those APIs.

### I have link information turned on, but am unable to see the information when hovering over a link
- The server (braize) used to fetch the link information may be down. Braize uptime can be found [here](https://braize.pajlada.com/chatterino/health/uptime).
- Your network may be having issues connecting to braize. Try restarting your PC and router.

### How do I get the supporter badge?
Donate €10 to fourtf [here](https://streamelements.com/fourtf/tip).

### Login expired error
If you're getting the `Login expired for user <user>! Try adding your account again.` error, simply re-add your account and it will start working again.

### How do I add Chatterino as an OBS dock?
This is not natively supported, but there is a work around:

1. Add a dock into OBS for standard Twitch chat.
2. Turn on `Always on top` in Chatterino.
3. Click the 3 dots up the top of a channel split and click `Popup`.
4. Move and resize the chat to overlay on top of the standard Twitch chat.

### Where is my Chatterino folder located?
On **Windows**:
`%APPDATA%/Chatterino2`

On **Linux**:
`$HOME/.local/share/chatterino`

On **Mac**:
`$HOME/Library/Application Support/chatterino`

### How do I delete the Chatterino cache / settings?
Navigate to your [Chatterino folder](#where-is-chatterino-folder-located) and remove corresponding folders.

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
