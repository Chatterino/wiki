# Crash Analysis

When running on Windows, Chatterino will automatically save information about a crash in a [minidump](https://docs.sentry.io/platforms/native/guides/minidumps/).

Crashdumps are saved inside the `Crashes/reports` folder in your [Chatterino folder](./Settings.md/#where-is-my-chatterino-folder-located).

Minidumps contain the stacks of all threads, their state (registers), the exception associated with the crash, and some metadata about the CPU and the OS. If you are unsure if your crashdump contains sensitive information, ask a Chatterino developer on the [Discord server](https://discord.gg/qq7DDxjste).

There are several ways of analyzing crashes. To get started, you need to have a symbol (PDB) file for your installation. **These files are unique per build** meaning that you need to download the file (this is especially important when using nightly builds). For GitHub builds, you can find the PDB file in the release - it's zipped in an archive ending in `.pdb.7z`. For simplicity, extract the `.pdb` to the location of your `chatterino.exe`.

## WinDbg

For analyzing with a GUI, install [WinDbg](https://learn.microsoft.com/windows-hardware/drivers/debugger/). After the installation, you should be able to open the crashdumps (`.dmp` files) right from the Windows Explorer. By default, you won't get much information.

To add names to functions (symbols), open the settings (_Home > Settings_), go to _Debugging Settings_, and add the directory you extracted your symbol file to the _Symbol path_. If there's no `srv*` entry, consider adding one - this will try to load symbols from servers for system libraries.

To add source-files, clone the repository and checkout the source-tree at the version of your executable. Then add this path to _Source Path_ in the _Debugging Settings_.

_Note:_ You might need to reload your window to have your changes be picked up.

<details>
<summary>Example Settings</summary>

<img alt="Example screenshot of WinDbg settings" src="/images/crashes/windbg-settings.png" />

</details>

## minidump-stackwalk

If you want to use the terminal or don't have a Windows machine, you can use [`minidump-stackwalk`](https://github.com/rust-minidump/rust-minidump/tree/main/minidump-stackwalk). Install [`minidump-stackwalk`](https://crates.io/crates/minidump-stackwalk) and [`dump_syms`](https://crates.io/crates/dump_syms) with cargo ([installation](https://doc.rust-lang.org/cargo/getting-started/installation.html)): `cargo install <app>`.

First, you need to generate a symbol-store from the PDB file with `dump_syms`:

```sh
dump_syms chatterino.exe -s <store-path> # (1)!
```

1. This can be any folder you want. Symbols will be extracted here.

After you dumped the symbols, run:

```sh
minidump-stackwalk <path-to-crashdump> --symbols-path <store-path>
```

Since Chatterino has quite a few threads, the output will be long. Most of the time, you're interested in the first thread (GUI thread) since it's the crashing thread.
