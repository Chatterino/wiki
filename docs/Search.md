# Search

Chatterino has a Search Popup which lets you quickly find messages in the chat. You can open it with the `Ctrl+F` shortcut.

## Search filters

You can use several search filters (format `filter:value`) to narrow down your search.  
`value` can have multiple comma-separated entries (look at examples below).  
Surround `value` in quotation marks to use whitespaces within it, useful for dealing with the regex filter.  
Starting in 2.4.1 the ability to negate searches is possible. (format `!filter:value`)

-   `from:<username>` - shows messages from certain users
-   `has:<flags>` - shows messages containing specified elements. List of flags:
    -   `link` - filters messages with links
-   `in:<channel>` - shows messages that originate from certain channels, useful in `#/mentions` channel
-   `is:<flags>` - shows certain types of messages. List of flags:
    -   `deleted` or `disabled` - shows deleted messages
    -   `sub` or `subscription` - shows subscription messages
    -   `timeout` or `ban` - shows moderation messages
    -   `highlighted` - shows highlighted messages
    -   `system` - shows system messages (grey text ones like: "Now hosting username", "streamer is live", etc.)
    -   `first-msg` - shows a user's first message in the channel
    -   `elevated-msg` - shows a user's elevated message in the channel (Paid Twitch Feature)[^1]
    -   `cheer-msg` - shows messages containing bits[^1]
    -   `redemption` - shows messages that cost the user Twitch channel points[^1]
    -   `reply` - shows messages sent using the Twitch reply feature[^1]
-   `regex:<regex>` - shows messages matching a given regex
-   `badge:<value>` - shows messages from users that have a given badge[^1]
-   `subtier:<value>` - shows messages from users that are subscribed at a given tier[^1]

## Examples

#### Shows messages from user `fourtf` containing word `merge`

`from:fourtf merge`  
![from:fourtf merge](images/search/example1.png)

#### Shows messages from users `pajbot` and `zneix` that have links containing word `chatterino`

`has:link from:pajbot,zneix chatterino`  
![has:link from:pajbot,zneix chatterino](images/search/example2.png)

#### Shows messages only from channels `pajlada` and `supinic` from user `supibot`

`in:pajlada,supinic from:supibot`  
![`in:pajlada,supinic from:supibot`](images/search/example3.png)

#### Shows subscription messages

`is:sub`  
![`is:sub`](images/search/example4.png)

#### Shows deleted messages containing word `vanish`

`is:deleted vanish`  
![`is:deleted vanish`](images/search/example5.png)

#### Shows timeout/ban messages

`is:timeout`  
![`is:timeout`](images/search/example6.png)

#### Shows highlighted messages

`is:highlighted`  
![`is:highlighted`](images/search/example7.png)

#### Shows messages matching a given regex

`regex:^gachi\w*$`  
![`regex:^gachi\w*$`](images/search/example8.png)

#### Shows messages from users who have the "Listening only" badge

`badge:no_video`  
![`badge:no_video`](images/search/example-badge-no_video.png)

#### Shows messages from users who are tier-3 subscribed

`subtier:3`  
![`subtier:3`](images/search/example-subtier-3.png)

#### Shows messages from users who are NOT gazatu

`!from:gazatu`  
![`!from:gazatu`](images/search/example-negate-search-1.png)

#### Shows messages that do NOT contain links

`!has:link`  
![`!has:link`](images/search/example-negate-search-2.png)

[^1]: Added in 2.4.0

[nightly]: ../Help/#what-is-nightly-and-how-to-use-install-it
