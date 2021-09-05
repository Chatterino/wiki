# Commands
Commands are used as shortcuts for long messages. If a message starts with the "trigger" then the message will be replaced with the Command.

#### Example
Add Command `Hello chat :)` with the trigger `/hello`. Now typing `/hello` in chat will send `Hello chat :)` instead of `/hello`.

## Advanced

- The trigger has to be matched at the **start** of the message but there is a setting to also match them at the **end**.
- Triggers don't need to start with `/`

#### Using placeholders
- `{1}`, `{2}`, `{3}` and so on can be used to insert the 1st, 2nd, 3rd, ... word after the trigger.

  Example: Add Command `/timeout {1} 1` with trigger `/warn`. Now typing `/warn user123` will send `/timeout user123 1`

- Similarly `{1+}` and so on can be used to insert all words starting with the 1st, ... word.

  Example: Add Command `Have a {1+} day!` with trigger `/day`. Now typing `/day very super nice` will send `Have a very super nice day!`

- You can use `{{1}` if you want to send `{1}` literally.

- `{channel}` can be used to insert the name of the current channel

    Example: Add Command `/openurl https://twitch.tv/{channel}` with trigger `/openchannel`. Now typing `/openchannel` will open the current channel in your browser.

- `{channelid}` can be used to insert the Twitch account ID of the owner of current channel
- `{myid}` can be used to insert the Twitch account ID of the currently selected account
- `{myname}` can be used to insert the Twitch username of the currently selected account
- `{game}` can be used to insert the game set in the current channel

    Example: Add Command `I'm currently playing {game}` with trigger `/game`. Now typing `/game` will send a message like `I'm currently playing World of Warcraft`.

- `{title}` can be used to insert the title set in the current channel

    Example: Add Command `The title is {title}` with trigger
