## Introduction to custom hotkeys

By default Chatterino contains a set of default *hotkeys*. A hotkey can be described using five parameters:
- Its name,
- a [scope][scope],
- an [action][action],
- a key combo,
- and [arguments][arguments]

### What is a scope

Scopes describe where in the app the hotkey's action take place. For example:
- sending a message by pressing enter takes place in the **Split input box**,
- closing the current split takes place in the current **Split**.

### What is an action

An action simply describes what a hotkey does. For example:
- the **reconnect** action in a Split causes Chatterino to reconnect to Twitch/IRC.
- the **zoom** action in a Window causes Chatterino to zoom in or out (depending on the [arguments][arguments] given

### What are hotkey arguments

Hotkey arguments describe the specifics of hotkeys. For example:
- the **zoom** action in a Window takes a single argument (`in` or `out`) which tells Chatterino to either zoom in or zoom out.

[arguments]:#What_are_hotkey_arguments
[action]:#What_is_an_action
[scope]:#What_is_a_scope
