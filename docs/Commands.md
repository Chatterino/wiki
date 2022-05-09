# Commands

Commands are used as shortcuts for long messages. If a message starts with the "trigger" then the message will be replaced with the Command.

## Built-in commands

Chatterino comes with a collection of built-in commands to help with channel management, Twitch interaction, and other misc. features.

### `/block` & `/unblock`

Usage: `/(block|unblock) <user>` 

Blocks or unblocks the specified user. Blocking will hide that user's messages/whispers as well as disassociate them from you on Twitch. For more information about blocking, see [Twitch's help article](https://help.twitch.tv/s/article/how-to-manage-harassment-in-chat?language=en_US#BlockWhispersandMessagesfromStrangers).

### `/chatters`

Usage: `/chatters`

Shows the total amount of chatters currently connected to the channel.

### `/clearmessages`

Usage: `/clearmessages`

Clears all messages from the current split/channel. This command is purely visual and is not related to the clearchat moderator command. 

### `/clip`

Usage: `/clip`

Creates a clip from the last 30 seconds of the current channel. Also provides an edit link to edit a clip from the current point in time.

### `/debug-args`

Usage: `/debug-args`

Displays the arguments that chatterino was launched with.

### `/delete`

Usage: `/delete <msg-id>`

Moderator only, deletes a message in chat with the provided ID. Usually used in mod actions as they can pass through the message ID.

### `/fakemsg`

Usage: `/fakemsg <raw message>`

Displays the provided IRC messsage in chat as if it was sent from Twitch's IRC server.

### `/ignore` & `/uningore`

Usage: `/(ignore|unignore) <user>`

Ignores or unignores messages for the specified user on Twitch. Ignoring will hide that user's messages/whispers. For more information about ignoring, see [Twitch's help article](https://help.twitch.tv/s/article/how-to-manage-harassment-in-chat?language=en_US#UseTheIgnoreFeature).

### `/marker`

Usage: `/marker`

[Editor](https://help.twitch.tv/s/article/Managing-Roles-for-your-Channel#types) only, creates a [stream marker](https://help.twitch.tv/s/article/creating-highlights-and-stream-markers?language=en_US#markers) in the current stream. Streamer must be live to create markers.

### `/openurl`

Usage: `/openurl`

Opens a URL in the default web browser. Useful in custom commands.

### `/popout`

Usage: `/popout [channel]`

Opens the current channel or provided channel's chat in Twitch's popout webchat, using your default browser.

### `/popup`

Usage: `/popup [channel]`

Opens the current channel or provided channel's chat in a new window.

### `/setgame`

Usage: `/setgame <game>`

Broadcaster only, sets the current channel's game to the best match of the provided game name.

### `/settitle`

Usage: `/settitle <title>`

Broadcaster only, sets the current channel's title to the provided text.

### `/streamlink`

Usage: `/streamlink [channel]`

Attempts to open current or specified stream in streamlink. For more information, see [Streamlink's website](https://streamlink.github.io/).

### `/uptime`

Usage: `/uptime`

Displays the uptime of the current channel's livestream.

### `/user`

Usage: `/user <user> [channel]`

Opens the specified user's Twitch usercard for the given channel (or the channel provided) in the default browser.

### `/usercard`

Usage: `/user <user> [channel]`

Opens the specified user's Chatterino usercard for the given channel or the channel provided.

### `/w (Whisper)`

Usage: `/w <user> <message>`

Whispers the provided text to a user on Twitch. See [Chatterino's whisper FAQ item](https://wiki.chatterino.com/Help/#i-am-unable-to-send-whispers-from-chatterino) for whisper-related issues.

## Custom commands

### Example

Add Command `Hello chat :)` with the trigger `/hello`. Now typing `/hello` in chat will send `Hello chat :)` instead of `/hello`.

### Advanced

- The trigger has to be matched at the **start** of the message but there is a setting to also match them at the **end**.
- Triggers don't need to start with `/`

#### Using placeholders

- `{1}`, `{2}`, `{3}` and so on can be used to insert the 1st, 2nd, 3rd, ... word after the trigger.  
  Example: Add Command `/timeout {1} 1` with trigger `/warn`. Now typing `/warn user123` will send `/timeout user123 1`

- Similarly `{1+}` and so on can be used to insert all words starting with the 1st, ... word.  
  Example: Add Command `Have a {1+} day!` with trigger `/day`. Now typing `/day very super nice` will send `Have a very super nice day!`

- You can use `{{1}` if you want to send `{1}` literally.

- `{channel.name}` can be used to insert the name of the current channel.  
  Example: Add Command `/openurl https://twitch.tv/{channel.name}` with trigger `/openchannel`. Now typing `/openchannel` will open the current channel in your browser.  
  _Available in [nightly][nightly] since [9b9fd7d][com1]._

- `{channel.id}` can be used to insert the Twitch account ID of the owner of current channel.  
  _Available in [nightly][nightly] since [9b9fd7d][com1]._

- `{my.name}` can be used to insert the Twitch username of the currently selected account.  
  _Available in [nightly][nightly] since [9b9fd7d][com1]._

- `{my.id}` can be used to insert the Twitch account ID of the currently selected account.  
  _Available in [nightly][nightly] since [9b9fd7d][com1]._

- `{stream.title}` can be used to insert the title set in the current channel. Only works if the channel is live.  
  Example: Add Command `The title is {stream.title}` with trigger `/title`. Now typing `/title` will send a message like `The title is Programming.S04E74.1440p.MP4-XD.NVENC`  
  _Available in [nightly][nightly] since [9b9fd7d][com1]._

- `{stream.game}` can be used to insert the game set in the current channel. Only works if the channel is live.  
  Example: Add Command `I'm currently playing {stream.game}` with trigger `/game`. Now typing `/game` will send a message like `I'm currently playing World of Warcraft`.  
  _Available in [nightly][nightly] since [9b9fd7d][com1]._

[nightly]: ../Help/#what-is-nightly-and-how-to-use-install-it
[com1]: https://github.com/Chatterino/chatterino2/commit/9b9fd7d403a0b3bd047ba7134de158c4e2fecbc7
