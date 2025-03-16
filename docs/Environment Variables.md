# Environment Variables

Below I have tried to list all environment variables that can be used to modify the behaviour of Chatterino. Used for things that I don't feel like fit in the settings system.

### CHATTERINO2_RECENT_MESSAGES_URL

Used to change the URL that Chatterino2 uses when trying to load historic Twitch chat messages (if the setting is enabled).  
Default value: `https://recent-messages.robotty.de/api/v2/recent-messages/%1` (an [open-source service](https://github.com/robotty/recent-messages2) written and currently run by [@RAnders00](https://github.com/RAnders00) - [visit the homepage for more details about the service](https://recent-messages.robotty.de/))  
Arguments:

-   `%1` = Name of the Twitch channel

### CHATTERINO2_LINK_RESOLVER_URL

Used to change the URL that Chatterino2 uses when trying to get link information to display in the tooltip on hover.  
Default value: `https://braize.pajlada.com/chatterino/link_resolver/%1`  
Arguments:

-   `%1` = Escaped URL the link resolver should resolve

### CHATTERINO2_TWITCH_EMOTE_SET_RESOLVER_URL

Used to change the URL that Chatterino2 uses when trying to get emote set information
Default value: `https://braize.pajlada.com/chatterino/twitchemotes/set/%1/`  
Arguments:

-   `%1` = Emote set ID

### CHATTERINO2_TWITCH_SERVER_HOST

String value used to change what Twitch chat server host to connect to.  
Default value: `irc.chat.twitch.tv`

### CHATTERINO2_TWITCH_SERVER_PORT

Number value used to change what port to use when connecting to Twitch chat servers.  
Currently known valid ports for secure usage: 6697, 443.  
Currently known valid ports for non-secure usage (CHATTERINO2_TWITCH_SERVER_SECURE set to false): 6667, 80.  
Default value: `443`

### CHATTERINO2_TWITCH_SERVER_SECURE

Bool value used to tell Chatterino whether to try to connect securely (secure irc) to the Twitch chat server.  
Default value: `true`

### CHATTERINO2_PROXY_URL

Used to set a proxy for network interactions of Chatterino. Both HTTP and SOCKS5[^1] proxies are supported. The URL supports username and password authentication. Example: `http://username:password@127.0.0.1:1080` or `socks5://127.0.0.1` (defaults to port `1080`).

[^1]: When using a SOCKS5 proxy, WebSockets (Twitch PubSub, 7TV EventAPI, and BTTV EventSockets) are **not proxied**. Only IRC and HTTP requests are proxied.

### QT_LOGGING_RULES

Used to enable/disable logging at run time. For example: `QT_LOGGING_RULES="chatterino.*.debug=true"` to enable debug logging in release builds. (It's on by default in debug builds). See [Qt docs](https://doc.qt.io/qt-6/qloggingcategory.html#configuring-categories) and [Logging](Logging.md) for more details.

### QT_MESSAGE_PATTERN

Used to customize logging at run time. For example: `QT_MESSAGE_PATTERN="%{time hh:mm:ss.zzz} %{category}: %{function} %{message}"` enables a timestamp and function name in log messages. See [Qt docs](https://doc.qt.io/qt-6/qtlogging.html#qSetMessagePattern) and [Logging](Logging.md) for more details.
