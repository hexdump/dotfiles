# macOS-config > duti-config

`duti` is software for macOS that can set the application set to open
specific file types. Since I use Finder double-clicking and the macOS
`open` command frequently, setting these defaults is very helpful.

## Installing `duti`

`duti` can be installed through `brew`. Just run:

```bash
$ brew install duti
```

## Finding the bundle ID of your target application

`duti` requires the bundle ID for applications it binds to filetypes.
These bundle IDs can rather easily be found; either through:

```shell
$ osascript -e 'id of app "SomeApp"'
```

or

```shell
$ mdls -name kMDItemCFBundleIdentifier -r SomeApp.app
```

A valid bundle identifier should (very roughly) look like:

```shell
$ com.apple.automator.emacs-cli-hook
```

*Found on a StackOverflow [answer](https://stackoverflow.com/a/39464824) from [@Qing](https://stackoverflow.com/users/6745884/qing).*

## Binding a bundle ID to an application (or many)

To bind a single application to a file extension, run the following command:

```shell
duti -s bundle_id .ext all
```

where `bundle_id` is the bundle ID of the target application, and `.ext` is the extension you wish to bind to that application.

To bind all code files to an application, you can use
the `duti-bulk-map.sh` script included in this directory to map a list
of file extensions to applications, like so:

```bash
$ ./duti-bulk-map.sh com.apple.automator.emacs-cli-hook code-file-extensions.txt
```

I've included a file named `code-file-extensions.txt` which contains
a big list of file extensions for code files. I'm definitely missing
many, so if your favorite extension is missing, *please* make a PR!
