# OS (Re-)Installation

- Erase the main disk, erase and rename as `Macintosh SSD` and format it as `APFS (Encrypted)` with `GUID Partition Map`.
- Then, choose the `Reinstall MacOS` option on the new disk.
- On installation make sure to choose:
  - "Don't transfer any information now" on the Migration Assistant page
  - Sign in with Apple ID
  - Set username to `hexdump` instead of `liamschumm`
    - Don't allow Apple ID to rest this password
  - Enable iCloud Keychain
  - Under "Express Set-Up", choose "Customize Settings"
    - Enable Location Services and Find My Mac
    - Under "Screen Time", click "Set Up Later"
    - Disable Siri
    - Under "Place Your Finger", click "Set Up Touch ID Later"
    - Choose Light theme
    - Leave True Tone Display enabled
    - Do not "store files from Documents and Desktop in iCloud Drive"
    - Choose Light theme

# System Configuration

Since XCode takes a while to download and install, you can run through the `macOS Configuration` concurrently with the `Development Tools` section.

## Disable unused iCloud services
Under the `Apple ID` menu in System Preferences, I've disabled the following:

- iCloud Drive
- News
- Stocks
- Home

I accepted the prompts that said I'd lose my data, since I don't have any data in those apps.

## Set Accent Color & Miscellany

<img alt="The `System Preferences > General` preference pane open with the options detailed below selected." src="images/general.png" height="600"/>

In `Settings > General`, I like to set my accent and highlight colors to yellow.

Other things I've configured here as different from the default:

- `Accent color` is set to yellow, my favorite color.
- `Automatically hide and show the menu bar` is checked: I think my mac looks cleaner this way.
- `Show scroll bars` set to `When scrolling`: having the scrollbar while you're not scrolling seems redundant to me.
- `Click in the scroll bar to` set to `Jump to the spot that's clicked`: I personally think this makes more sense than the alternative.
- `Ask to keep changes when closing documents` is checked.
- `Close windows when quitting an app` is checked! I hate when I reopen an application and I have a ton of old windows pop up that I have to close.
- `Recent items` is set to `None`. I don't use the `Recent Items` feature on my mac since launching programs or documents with my keyboard is faster.

## Set Wallpaper

Under `Colors`, I used the `Custom Color...` button to select a plain white background.

## Dock
I've completely disabled my Dock using the following commands:

```shell
$ defaults write com.apple.dock autohide -bool true && killall Dock
$ defaults write com.apple.dock autohide-delay -float 1000 && killall Dock
$ defaults write com.apple.dock no-bouncing -bool TRUE && killall Dock
```

The dock can still be accessed with `Command-Up` or `Command-Option-D` if need be.

## Desktop
I've completely disabled my Desktop with the following commands:

```shell
$ defaults write com.apple.finder CreateDesktop false && killall Finder
```

## Keyboard

### `Keyboard > Keyboard`

I love speedy key repeat rates. I've set `Key Repeat` to the fastest setting, and `Delay Until Repeat` to the shortest setting.

<img alt="Shows the `System Preferences > Keyboard > Keyboard` menu with `Key Repeat` set to the `Fast` setting and `Delay Until Repeat` set to the `Short` setting." src="images/key-repeat.png" height="600"/>

### `Keyboard > Text`

*"On my way!"* - Literally nobody, ever.

I really really dislike my computer changing what I type. I've disabled all automatic options under `Text`. Unfortunately, spellchecking can only be disabled on a per-application basis.

<img alt="The `Keyboard > Text` pane open with `Correct spelling automatically`, `Capitalize words automatically`, `Add periods with double-space`, and `Use smart quotes and dashes` all unselected. The `Replace/With` table is empty." src="images/disable-autocorrect.png" height="600"/>

## Change hostname

Under `System Preferences > Sharing`, change the hostname to the preferred name of your machine:

<img alt="The `Sharing` preferences pane with the text of the `Computer Name` field set to my computer name: `omi`," src="images/change-hostname.png" height="600"/>

## Disable automatic space switching

On macOS, if you open an application that already has windows open on
spaces other than the one you are currently on, it will automatically
switch to the space with that application open. Disabling this also
falls into the category of "computer, please don't do things I don't
want you to do". This option can be set in `System Preferences > Mission Control`,
by unchecking `When switching to an application, switch to a Space with open windows for the application`.

<img alt="The `System Preferences > Mission Control` pane open with `When switching to an application, switch to a Space with open windows for the application` unselected." src="images/disable-auto-swoosh.png" height="600"/>

## Finder

### Desktop View Options

Navigate to your home folder (`lschumm` in my case). Right click in this folder, and you'll get another `Show View Options` to show up. This is different from the one on the Desktop, and will allow you to configure defaults for all of your Finder windows.

I've enabled `Always open in icon view`, set `Sort By` to `Snap to Grid`, and checked `Show Library Folder`. To set these options as the system defaults, I clicked `Use as Defaults`.

<img alt="The Finder `Show View Options` menu with `Always open in icon view` checked, `Sort By` set to `Snap to Grid` and `Show Library Folder` checked. A `Use as Defaults` button appears at the bottom of the window." src="images/home-folder-show-view-options.png" height="600"/>



### `Finder Preferences > General`

In `Finder Preferences > General`, I've configured `New Finder windows show` to `Desktop`, and unchecked `Open folders in tabs instead of new windows`.

<img alt="The `Finder Preferences > General` pane open with `New Finder windows show` set to `Desktop` and `Open folders in tabs instead of new windows` unchecked." src="images/finder-preferences-general.png" height="600"/>

### `Finder Preferences > Sidebar`

By default, Finder puts a lot of stuff in the sidebar. I like to strip this down to only folders I frequently use: I've unchecked everything but `AirDrop`, `Applications`, `Desktop`, `Documents`, `Downloads`, `lschumm` (my home folder), and `External disks`.

<img alt="The `Finder Preferences > Sidebar` pane open with nothing checked but `AirDrop`, `Applications`, `Desktop`, `Documents`, `Downloads`, `lschumm` (my home folder), and `External disks`." src="images/finder-preferences-sidebar.png" height="600"/>

### `Finder Preferences > Advanced`

Under `Finder Preferences > Advanced` I've enabled `Show all filename extensions` and disabled `Show warning before changing an extension`. `When performing a search:` is set to `Search the Current Folder`.

<img alt="The `Finder Preferences > Advanced` pane open with `Show all filename extensions` checked and `Show warning before changing an extension` unchecked. `When performing a search:` is set to `Search the Current Folder`." src="images/finder-preferences-advanced.png" height="600"/>

## Trackpad configuration

Under `Trackpad > Point & Click`, I've enabled `Force Click & haptic feedback` and `Tap to click`.

<img alt="The `Trackpad > Point & Click` pane with `Force Click & haptic feedback` checked and `Tap to click` checked." src="images/trackpad-settings.png" height="600"/>


# Development Tools

## Install XCode

Install XCode from the Mac App Store. After it's installed and you've opened it for the first time, run:

```bash
$ xcode-select --install
```

to install the command line tools.


Then, you have to agree to the license agreement with the following command:

```bash
$ sudo xcodebuild -license
```

## Install Homebrew

Use the `brew` default installer, found at `https://brew.sh`:

```
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

I like to install everything from system utilities to applications through `brew`.

## Set up Git credentials

To set up your `git` name and email, run

```bash
$ EDITOR=nano git config --global --edit
```

## Git Credential Cache Helper

On MacOS, you can set `Keychain.app` as your credential helper for git, so you won't have to keep entering your password:

```bash
git config --global credential.helper osxkeychain
```

## Globally ignore .DS_Store files

Once you've copied my `gitignore-global` file to `~/.gitignore` (rename the file), run the following command:

```bash
$ git config --global core.excludesfile ~/.gitignore
```

## Generate SSH key

To generate an SSH key, run:

```shell
$ ssh-keygen
```

Then, link your SSH key up to GitHub/VPSes/wherever else you use SSH authentication.

## Install gnupg

You need `gnupg` on macOS in order to download from the ELPA package
archive for emacs.

```shell
$ brew install gpg
```

## Set up `ssh` key

To generate an `ssh` keypair, just run:

```shell
$ ssh-keygen
```

# Application Installs

##  Command-Line Applications

```
$ brew install emacs python3 rust duti cmake moreutils nmap
```

## Userland Applications

I like installing apps through `brew cask` because command line stuff is great, and it allows all of my applications to be centrally managed by a utility. Nothing is in the Mac App Store.

```shell
$ brew cask install zsh \
                    telegram \
                    typora \
                    kitty \
                    gimp \
                    xquartz \
                    inkscape \
                    protonvpn \
                    spotify \
                    vlc \
                    deluge \
                    firefox \
                    tor-browser \
                    karabiner-elements \
                    alfred \
                    moom \
                    steam \
                    yed
```

## Set Tor Browser as the Default Browser

In `System Preferences > General`, set the default browser to `Tor Browser.app`.

## Login Items

![The `System Preferences > Users & Groups > Login Items` pane with the items `Alfred 4`, `Moom`, and `Karabiner-Elements`. The `Hide` checkbox next to each item is checked.](images/login-items.png)

## Opening Terminal-Based Emacs on Files

![The opening screen of Automator open, with the type of document chosen to be `Application`.](images/automator-kitty-emacs-hook-1.png)

![Automator open, with the `Actions` search field filled in with `run shell`, and the single result `Run Shell Script` showing.](/images/automator-kitty-emacs-hook-2.png)

![The Automator `Run Shell Script` Action with the command below filled in for the script.](images/automator-kitty-emacs-hook-3.png)

```
nohup /usr/local/bin/kitty /usr/local/bin/emacs $1 >/dev/null 2>&1 &
```

Save this as `cli-emacs-hook.app` in `Applications`.

## Disable Gatekeeper

I think I have decent hygiene as to what I run on my computer, and I don't like macOS requiring every application to be recognized by *them*. I disable Gatekeeper (the service that verifies code signatures) like so:

```shell
$ sudo spctl --master-disable
```
