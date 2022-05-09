# Commands

Commands are used as shortcuts for long messages. If a message starts with the "trigger" then the message will be replaced with the Command.

## Built-in commands

Chatterino comes with default commands to perform actions TODO

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
