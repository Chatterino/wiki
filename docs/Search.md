# Search

Chatterino has a Search Popup which lets you quickly find messages in the chat. You can open it with the `Ctrl+F` shortcut.

## Search filters

You can use several search filters (format `filter:value`) to narrow down your search.  
`Value` can have multiple comma-separated entries (look at examples below).

- `from:<username>` - shows messages from certain users (added in 2.1.4)
- `has:<flags>` - shows messages containing specified elements (added in 2.1.4). List of flags:
    - `link` - filters messages with links
- `in:<channel>` - shows messages that originate from certain channels, useful in `#/mentions` channel (added in 2.3.0)


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
