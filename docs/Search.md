# Search

Chatterino has Search Popup which lets you quickly find messages in the chat. You can open it with shortcut `Ctrl+F`.

## Search filters

You can use several search filters to narrow down your search:

- `from:<username>` - shows messages only from certain username. Can be multiple usernames separated with a comma
- `has:<flags>` - shows messages only containing specified elements, list of flags:
    - `link` - filters messages with links
- `in:<channel>` - (useful in `#/mentions` channel) shows messages that originate from certain channels


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
