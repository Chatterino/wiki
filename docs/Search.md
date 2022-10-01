# Search

Chatterino has a Search Popup which lets you quickly find messages in the chat. You can open it with the `Ctrl+F` shortcut.

## Search filters

You can use several search filters (format `filter:value`) to narrow down your search.  
`value` can have multiple comma-separated entries (look at examples below).  
Surround `value` in quotation marks to use whitespaces within it, useful for dealing with the regex filter.

- `from:<username>` - shows messages from certain users (added in 2.1.4)
- `has:<flags>` - shows messages containing specified elements (added in 2.1.4). List of flags:
    - `link` - filters messages with links
- `in:<channel>` - shows messages that originate from certain channels, useful in `#/mentions` channel (added in 2.3.0)
- `is:<flags>` - shows certain types of messages (added in 2.3.1). List of flags:
    - `deleted` or `disabled` - filters deleted messages
    - `sub` or `subscription` - filters subscription messages
    - `timeout` or `ban` - filters moderation messages
    - `highlighted` - filters highlighted messages
    - `system` - filters system messages (grey text ones like: "Now hosting username", "streamer is live", etc.)
    - `first-msg` - filters a user's first message in the channel
    - `elevated-msg` - filters a user's elevated message in the channel (Paid Twitch Feature)[^1]
- `regex:<regex>` - shows messages matching a given regex
- `badge:<value>` - shows messages from users that have a given badge[^2]
- `subtier:<value>` - shows messages from users that are subscribed at a given tier[^2]

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

[^1]: Available since [nightly][nightly] [d024a1e](https://github.com/Chatterino/chatterino2/commit/d024a1ef7e1b7ed866a5662d562233453cf220b6)

[nightly]: ../Help/#what-is-nightly-and-how-to-use-install-it
