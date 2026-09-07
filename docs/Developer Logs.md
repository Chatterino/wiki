# Viewing Logs

In some cases, it might be useful to view logs from Chatterino.
This doesn't require any special build or tools.

To view logs, run Chatterino from the command line.
Because Chatterino is a GUI application, you need to set the `QT_WIN_DEBUG_CONSOLE` environment variable to either `new` (create a new console window) or `attach` (use the current console) on Windows ([Qt documentation][qt-env-vars]).

Through the `QT_LOGGING_RULES` environment variable ([Qt documentation][qt-logging-rules]), you can control which parts of the application emit logs at what level.
In release builds, the default level is "warn". To enable debug logs from just Chatterino, set the rules to `chatterino.*.debug=true`.
Multiple rules can be concatenated with `;`: `chatterino.*.debug=true;chatterino.http.*=false` (enable all debug logs except for HTTP ones).

`QT_MESSAGE_PATTERN` can be used to adjust the format of the logs to include the time or calling function, for example ([Qt documentation][qt-message-pattern]). `%{time} %{category}: %{message}` will show the time and category for each message.

<!-- prettier-ignore-start -->
=== ":fontawesome-brands-windows: Windows PowerShell"
    ``` { .pwsh-session .no-copy }
    > $Env:QT_WIN_DEBUG_CONSOLE="new"
    > $Env:QT_LOGGING_RULES="chatterino.*.debug=true"
    > <path-to>/chatterino.exe
    (a new console window will show)
    ```
=== ":fontawesome-brands-windows: Windows CMD"
    ``` { .doscon .no-copy }
    > set QT_WIN_DEBUG_CONSOLE=new
    > set QT_LOGGING_RULES=chatterino.*.debug=true
    > <path-to>/chatterino.exe
    (a new console window will show)
    ```
=== ":simple-linux:/:simple-apple: Linux/macOS"
    ``` { .console .no-copy }
    $ export QT_LOGGING_RULES="chatterino.*.debug=true"
    $ <path-to>/chatterino
    chatterino.hotkeys: Try add default "close popup window"
    chatterino.hotkeys: Already exists
    ...
    ```
<!-- prettier-ignore-end -->

If you want to get live output of a running Chatterino instance, you can attach a debugger.
You can use the command `/c2-set-logging-rules` to set the rules from Chatterino itself at runtime.
On Windows, [c2-logs] can help with attaching to running instances and changing their logging levels from the command line.

[qt-env-vars]: https://doc.qt.io/qt-6/debug.html#environment-variables-recognized-by-qt
[qt-logging-rules]: https://doc.qt.io/qt-6/qloggingcategory.html#configuring-categories
[qt-message-pattern]: https://doc.qt.io/qt-6/qtlogging.html#qSetMessagePattern
[c2-logs]: https://github.com/nerixyz/c2-logs
