# OS (Re-)Installation

- Erase the main disk, erase and rename as `Macintosh HD` and format it as *encrypted* `APFS`.
- Then, choose the `Reinstall MacOS` option on the new disk.
- On installation make sure to choose:
  - "Don't transfer any information now" on the Migration Assistant page
  - Sign in with Apple ID
  - Set username to `lschumm` instead of `liamschumm`
    - Don't allow Apple ID to rest this password
  - Under "Express Set-Up", choose "Customize Settings"
    - Enable Location Services
    - Disable analytics
    - Disable Siri
    - Do not "store files from Documents and Desktop in iCloud Drive"
  - Choose Light theme

# System Configuration

Since XCode takes a while to download and install, you can run through the `macOS Configuration` concurrently with the `Development Tools` section.

## Set Accent Color & Miscellany

<img alt="The `System Preferences > General` preference pane open with the options detailed below selected." src="images/general.png" width="600" align="center"/>

In `Settings > General`, I like to set my accent and highlight colors to yellow.

Other things I've configured here as different from the default:

- `Sidebar icon size` set to `Medium`: I like big icons, especially on my Retina screen.
- `Automatically hide and show the menu bar` is checked: I think my mac looks cleaner this way.
- `Show scroll bars` set to `When scrolling`: having the scrollbar while you're not scrolling seems redundant to me, and looks ugly on my `Terminal` windows.
- `Click in the scroll bar to` set to `Jump to the spot that's clicked`: I personally think this makes more sense than the alternative.
- `Ask to keep changes when closing documents` is checked.
- `Close windows when quitting an app` is checked! I hate when I reopen an application and I have a ton of old windows pop up that I have to close.
- `Recent items` is set to `None`. I don't use the `Recent Items` feature on my mac since launching programs or documents with my keyboard is faster.

## Black Borders

There's a setting in macOS's `Accessibility > Display` pane to `Increase contrast`. This gives you super sweet black borders on windows and popups that I really like. Clicking `Increase contrast` will also select `Reduce transparency`.

<img alt="The `Accessibility > Display` pane open with `Increase contrast` checked and `Reduce transparency` checked and greyed out to indicate you can't uncheck it." src="images/black-borders.png" width="600" align="center"/>
 
## Dock

I like automatically hiding my dock because I think it looks clean, and saves screen real estate.

<img alt="The `Dock` preference pane open with `Automatically hide and show the Dock` unselected." src="images/hide-dock.png" width="600" align="center"/>

## Keyboard

### `Keyboard > Keyboard`

I love speedy key repeat rates. I've set `Key Repeat` to the fastest setting, and `Delay Until Repeat` to the shortest setting.

<img alt="Shows the `System Preferences > Keyboard > Keyboard` menu with "Key Repeat" set to the "Fast" setting, and "Delay Until Repeat" set to the "Short" setting." src="images/key-repeat.png" width="600" align="center"/>

### `Keyboard > Modifier Keys`

Since I use `emacs`, I have to keep my emacs pinky in check (seriously, after starting a summer intership I started to get it within a week). I've swapped my `Caps Lock` and `Control` keys globally. *Note that* this will not apply to other keyboards than the one you have selected in `Select keyboard`.

<img alt="The `Keyboard > Modifier Keys` pane open with `Caps Lock` and `Control` swapped." src="images/remap-control.png" width="600" align="center"/>

### `Keyboard > Text`

*"On my way!"* - Literally nobody, ever.

I really really dislike my computer changing what I type. I've disabled all automatic options under `Text`. Unfortunately, spellchecking can only be disabled on a per-application basis.

<img alt="The `Keyboard > Text` pane open with `Correct spelling automatically`, `Capitalize words automatically`, `Add periods with double-space`, and `Use smart quotes and dashes` all unselected. The `Replace/With` table is empty." src="images/disable-autocorrect.png" width="600" align="center"/>

## Change hostname

Under `System Preferences > Sharing`, change the hostname to the preferred name of your machine:

<img alt="The `Sharing` preferences pane with the text of the `Computer Name` field set to my computer name: `omi`," src="images/change-hostname.png" width="600" align="center"/>

## Disable automatic space switching

On macOS, if you open an application that already has windows open on
spaces other than the one you are currently on, it will automatically
switch to the space with that application open. Disabling this also
falls into the category of "computer, please don't do things I don't
want you to do". This option can be set in `System Preferences > Mission Control`,
by unchecking `When switching to an application, switch to a Space with open windows for the application`.

<img alt="The `System Preferences > Mission Control` pane open with `When switching to an application, switch to a Space with open windows for the application` unselected." src="images/disable-auto-swoosh.png" width="600" align="center"/>

## Finder

### Desktop View Options

If you right click on your desktop and click `Show View Options`, you'll be able to set Finder's view options for the Desktop. For *everything* in Finder, I like to have `Sort By` set to `Snap to Grid`, since it lets you organize files how you like but also keeps them neat.

<img alt="The Finder `Show View Options` menu with `Sort By` set to `Snap to Grid`." src="images/desktop-view-options.png" width="600" align="center"/>

Then, navigate to your home folder (`lschumm` in my case). Right click in this folder, and you'll get another `Show View Options` to show up. This is different from the one on the Desktop, and will allow you to configure defaults for all of your Finder windows.

I've enabled `Always open in icon view`, set `Sort By` to `Snap to Grid`, and checked `Show Library Folder`. To set these options as the system defaults, I clicked `Use as Defaults`.

<img alt="The Finder `Show View Options` menu with `Always open in icon view` checked, `Sort By` set to `Snap to Grid` and `Show Library Folder` checked. A `Use as Defaults` button appears at the bottom of the window." src="home-folder-show-view-options.png" width="600" align="center"/>

### `Finder Preferences > General`

In `Finder Preferences > General`, I've configured `New Finder windows show` to `Desktop`, and unchecked `Open folders in tabs instead of new windows`.

<img alt="The `Finder Preferences > General` pane open with `New Finder windows show` set to `Desktop` and `Open folders in tabs instead of new windows` unchecked." src="images/finder-preferences-general.png" width="600" align="center"/>

### `Finder Preferences > Sidebar`

By default, Finder puts a lot of stuff in the sidebar. I like to strip this down to only folders I frequently use: I've unchecked everything but `AirDrop`, `Applications`, `Desktop`, `Documents`, `Downloads`, `lschumm` (my home folder), and `External disks`.

<img alt="The `Finder Preferences > Sidebar` pane open with nothing checked but `AirDrop`, `Applications`, `Desktop`, `Documents`, `Downloads`, `lschumm` (my home folder), and `External disks`." src="images/finder-preferences-sidebar.png" width="600" align="center"/>

### `Finder Preferences > Advanced`

Under `Finder Preferences > Advanced` I've enabled `Show all filename extensions` and disabled `Show warning before changing an extension`.

<img alt="The `Finder Preferences > Advanced` pane open with `Show all filename extensions` checked and `Show warning before changing an extension` unchecked." src="images/finder-preferences-advanced.png" width="600" align="center"/>

# Development Tools

## Install XCode

Install XCode from the Mac App Store. After it's installed and you've opened it for the first time, run:

```bash
$ xcode-select --install
```

to install the command line tools.

## Install Homebrew

Use the `brew` default installer, found at `https://brew.sh`:

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

I like to install everything from system utilities to applications through `brew`.

## Set up Git credentials

To set up your `git` name and email, run

```
git config --global --edit
```

## Install Python3

MacOS (as of Mojave) installs Python `2.7.10`, which is a *reasonable* version of Python 2 to have. To install Python 3, I recommend `brew`:

```
brew install python3
```


## Install `python2-pip`

When `brew` installed `python3`, it also installed `pip3`. However, MacOS' default version of Python *does not* include pip. It does include `easy_install`, which can be used to install `pip`:

```
sudo easy_install pip
```


## Install the latest version of Emacs

MacOS (as of Mojave) installs Emacs `22.1.1`, which is ancient; probably because of it moving to GPLv3 `:(`. Install `emacs26` with `brew`:

```
brew install emacs
```

## App Installation

I like installing apps through `brew cask` because command line stuff is great, and it allows all of my applications to be centrally managed by a utility. Nothing is in the Mac App Store.

```
brew cask install telegram
brew cask install gimp
brew cask install deluge
```

## Enable zsh as default shell

## Enable meta key in terminal

To use `option` as the meta key in Terminal, enable it in `Terminal > Preferences > Profiles > Keyboard`:

<img alt="Shows the `Terminal > Preferences > Profiles > Keyboard` pane with "Use Option as Meta key" selected"" src="images/use-option-as-meta-key.png" width="600" align="center"/>

## Trackpad configuration

Under `Trackpad > Point & Click`, I've enabled `Force Click & haptic feedback` and `Tap to click`.

<img alt="The `Trackpad > Point & Click` pane with `Force Click & haptic feedback` checked and `Tap to click` checked." src="images/trackpad-settings.png" width="600" align="center"/>

## Git Credential Cache Helper

On MacOS, you can set `Keychain.app` as your credential helper for git, so you won't have to keep entering your password:

```
git config --global credential.helper osxkeychain
```

## Install gnupg

You need `gnupg` on macOS in order to download from the ELPA package
archive for emacs.

```brew
$ brew install gpg
```

## Install java

`brew cask` will allow you install the latest version of the Java JDK:

```bash
$ brew cask install java
```

## Node/NPM installation and configuration

First, install `nvm` through `brew`:

```bash
brew install nvm
```

Then, install the latest version of node.js with:

```bash
nvm install node
```

## Postgres Setup

I use `brew` to install postgres:

```bash
$ brew install postgres
```

<!-- tf? now it's linked? ok... -->
`brew`'s version of postgres, (`stable 11.4` as the time of me writing this), does some things funky. First, sometimes it seems to not properly link its binaries. 
To remedy this, first try relinking `postgres`:

```bash
$ brew unlink postgres && brew link postgres
```

If the `psql`/`pg_ctl`/etc binaries are still not in your `PATH`, you can manually add them:

```bash
$ PATH="$PATH:/usr/local/Cellar/postgresql/11.4
```

Then, it initializes an account under *your username* with all privileges,
instead of one named `postgres`. To create a `postgres` user with all privileges, open `psql` and do the following:

```bash
$ createdb myusername
$ psql
psql (11.4)
Type "help" for help.

myusername=# create user postgres;
CREATE ROLE
myusername=# alter user postgres SUPERUSER CREATEROLE CREATEDB REPLICATION BYPASSRLS
ALTER ROLE
```
