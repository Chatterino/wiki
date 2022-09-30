## Introduction to Filters

Filters can be applied to splits to provide a selective view of messages. Filters are created in the Settings page and are applied by opening the Split menu (three dots) and selecting "Set filters". Applied filters are saved when you close and open Chatterino.

Multiple filters can be applied to a Split. A message must pass all applied filters for it to be displayed.

Simple filters are available through the Channel Filter Creator dialog. Advanced filters take inspiration from many programming languages, and the full description of keywords and operators can be found below.

## Example filters

- `message.content contains "hello"`
  - Only messages that contain the phrase `hello`
- `message.length < 40 || author.subbed`
  - Messages that are less than 40 characters log, OR are sent by a subscriber.
- `channel.name == "somestreamer" && author.badges contains "moderator"`
  - Messages that originated in the channel `somestreamer` AND are from users with a moderator badge

## Filter syntax

A filter must be a valid expression. An expression is comprised of conditions and values which are evaluated to a single `True` or `False` value to decide whether to filter a message. Evaluating to something other than `True` or `False` will lead to all messages being filtered out.

### Values

A value can be an integer (`123`, `5`), a string (`"hello"`, `"this is a string"`), a variable (`author.name`, `message.length`), a list of values (`{123, "hello", author.name}`), or a regular expression (`r"\d\d\d\d"`).

Lists are surrounded by braces (`{}`) and list items are separated by commas. A list item can be a value (e.g. `"hello"`) or an expression wrapped in parentheses (e.g. `(author.sub_length * message.length)`).

Regular expressions are similar to strings, but are denoted with an `r` before the opening quotation mark (e.g. `r"something"`). To make a regular expression case-insensitive, use `ri` before the opening quotation mark (e.g. `ri"something"`).

When a filter is evaluated, variables are replaced with the values they represent.

**Literals:**

| Name   | Example                               |
| ------ | ------------------------------------- |
| Int    | `123`, `5`                            |
| String | `"Hello there"`, `"Escaped \" quote"` |
| RegEx  | `r"\d\d\d\d"`, `ri"something.*"`      |
| List   | `{"list item", 123}                   |

### Operators

Binary operators act on two values:

- `1 + 2`
- `author.subbed && flags.highlighted`
- `"long sentence" contains "ten"`

Unary operators act on one value:

- `!author.subbed`

The following operators are available:

| Operator     | Description                                             |
| ------------ | ------------------------------------------------------- |
| `&&`         | And                                                     |
| `||`         | Or                                                      |
| `!`          | Not                                                     |
| `==`         | Equals                                                  |
| `!=`         | Not equals                                              |
| `<`          | Less than                                               |
| `<=`         | Less than or equal to                                   |
| `>`          | Greater than                                            |
| `>=`         | Greater than or equal to                                |
| `contains`   | String, List, or Map contains                           |
| `startswith` | String or List starts with text or string, respectively |
| `endswith`   | String or List ends with text or string, respectively   |
| `match`      | Match string with regular expression                    |
| `+`          | Add (or string concatenation)                           |
| `-`          | Subtract                                                |
| `*`          | Multiply                                                |
| `/`          | Divide (integer)                                        |
| `%`          | Modulus                                                 |

### Variables

The following variables are available:

| Variable                | Type         | Description                                                                                                |
| ----------------------- | ------------ | ---------------------------------------------------------------------------------------------------------- |
| **Author**              |              | User who sent the message                                                                                  |
| `author.badges`         | List<String> | List of author's badges                                                                                    |
| `author.color`          | Color\*      | Color code of author, or none                                                                              |
| `author.name`           | String       | Display name of author                                                                                     |
| `author.no_color`       | Bool         | Whether the author has no color set (i.e. gray name)                                                       |
| `author.subbed`         | Bool         | Whether author is subscribed                                                                               |
| `author.sub_length`     | Int          | How long author has been subscribed (or zero)                                                              |
| **Channel**             |              | The channel where the message was sent                                                                     |
| `channel.name`          | String       | Channel name                                                                                               |
| `channel.watching`      | Bool         | Whether the channel is being watched (requires Chatterino extension)                                       |
| `channel.live`          | Bool         | Whether the channel is currently live                                                                      |
| **Flags**               |              | Message-specific flags                                                                                     |
| `flags.highlighted`     | Bool         | Whether the message is highlighted                                                                         |
| `flags.points_redeemed` | Bool         | Whether the message was redeemed through channel points                                                    |
| `flags.sub_message`     | Bool         | Whether the message is a sub/resub/gift message                                                            |
| `flags.system_message`  | Bool         | Whether the message is a system message (i.e. timeout/ban/info)                                            |
| `flags.reward_message`  | Bool         | Whether the message is a redeemed channel point reward message                                             |
| `flags.first_message`   | Bool         | Whether the message is the author's first message in the channel                                           |
| `flags.whisper`         | Bool         | Whether the message is a whisper                                                                           |
| `flags.reply`           | Bool         | Whether the message is a reply                                                                             |
| `flags.automod`         | Bool         | Whether the message has automod information or actions[^1]                                                     |
| **Message**             |              | Actual message sent                                                                                        |
| `message.content`       | String       | Message content                                                                                            |
| `message.length`        | Int          | Message length                                                                                             |

\*Note: To compare a `Color`, compare it to a color hex code string: `author.color == "#FF0000"`

### Data types

Generally, data types won't be much of an issue. However, mismatching data types can cause confusing results.

For example:

- `"abc" + 123 == "abc123"` but `123 + "abc" != "123abc"`
- `1 + "2" == 3` and `1 + "2" == "3"`.

Chatterino will try to transform incompatible types for operations, but it isn't always successful.
If two types can't mix, `False` or `0` will be returned, depending on the context.

Double check the table above to see the types of each variable to prevent unexpected results.

### Regular Expressions

Chatterino can match string variables to a regular expression, returning whether the expression matched or, optionally, the value of a capture group.

#### Simple matching

`"some string" match r"some regex"` returns `True` or `False`.

For example: `message.content match r"\d\d"`

#### Group capturing

`"some string" match {r"some regex", capture number}` returns `False` if no match or the value of the nth captured group.

For example: `message.content match {r"(\d\d)/(\d\d)/(\d\d\d\d)", 3}` matches the year component of a date like `12/31/2020`.

`(message.content match {r"(\d\d)/(\d\d)/(\d\d\d\d)", 3}) == "2020"` will filter only messages that contain a written date with 2020 as the year.

### About the order of operations

The order of operations in filters may not be exactly what you expect.

- Expressions in parentheses are evaluated first
- Math operations are evaluated from left to right, not by MDAS. `2 + 3 * 4` yields `20`, not `14`.
- `a && b || c && d` is evaluated as `(a && b) || (c && d)`
- `a || b && c || d` is evaluated as `a || (b && c) || d`

Basically, if you're unsure about the order of operations, use extra parentheses.

[^1]: Available since [nightly][nightly] [dcd42cb](https://github.com/Chatterino/chatterino2/commit/dcd42cb28bde2efc17d9afa0e36d6f5f1d3971de)

[nightly]: ../Help/#what-is-nightly-and-how-to-use-install-it
