# Search

Chatterino has Search Popup which lets you quickly find messages in the chat. You can open it with shortcut `Ctrl+F`.

## Search filters

You can use several search filters to narrow down your search:

- `from:<username>` - shows messages only from certain username. Can be multiple usernames separated with a comma
- `has:<flags>` - shows messages only containing specified elements, list of flags:
    - `link` - filters messages with links
- `in:<channel>` - (works only in `#/mentions` channel) only shows messages that originate from certain channels

## Examples

Shows messages from user `fourtf` containing word `"merge"`  
`from:fourtf merge`  
![from:fourtf merge](https://cdn.zneix.eu/wUhTO9y.png)

Shows messages from users `pajbot` and `zneix` that have links containing word `"chatterino"`  
`has:link from:pajbot,zneix chatterino`  
![has:link from:pajbot,zneix chatterino](https://cdn.zneix.eu/FEfPoJj.png)
