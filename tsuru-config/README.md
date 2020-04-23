# tsuru-config

This is the guide for the configuration of *tsuru*, my MacBook Air.

# OS (Re-)Installation

## Erasing Disk

Erase the main disk, erase and rename as `Macintosh SSD` and format it as `APFS` (encryption will be done later via FileVault) with `GUID Partition Map`.

## Start Installation
Choose the `Reinstall MacOS` option on the new disk.

## First Boot Configuration
- On installation make sure to choose:
  - Don't migrate any data
  - Sign in with Apple ID
  - Set username and full name to `hexdump`.
    - Don't allow Apple ID to reset this password
  - Under "Express Set-Up", choose "Customize Settings"
    - Enable Location Services
    - Disable all analytics
    - Under "Screen Time", click "Set Up Later"
    - Disable Siri
    - Disable iCloud storage
    - Enable FileVault disk encryption, but do not allow iCloud account unlocking
    - Under "Place Your Finger", click "Set Up Touch ID Later"
    - Set up ApplePay
    - Choose Light theme
    - Leave True Tone Display enabled

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
- `Show scroll bars` set to `When scrolling`: having the scrollbar while you're not scrolling seems redundant to me.
- `Click in the scroll bar to` set to `Jump to the spot that's clicked`: I personally think this makes more sense than the alternative.
- `Ask to keep changes when closing documents` is checked.
- `Close windows when quitting an app` is checked! I hate when I reopen an application and I have a ton of old windows pop up that I have to close.
- `Recent items` is set to `None`. I don't use the `Recent Items` feature on my mac since launching programs or documents with my keyboard is faster.

## Set Wallpaper

Drag the `wallpaper.jpg` file from the this `tsuru-config` folder into the wallpaper preview of the `Desktop & Screen Saver` preference pane.

## Dock
I've completely disabled my Dock using the following commands:

```shell
$ defaults write com.apple.dock autohide -bool true && killall Dock
$ defaults write com.apple.dock autohide-delay -float 1000 && killall Dock
$ defaults write com.apple.dock no-bouncing -bool TRUE && killall Dock
```

The dock can still be accessed with `Command-Up` or `Command-Option-D` if need be.

## Desktop
I've completely disabled my Desktop icons with the following commands:

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

Navigate to the Desktop folder in the Finder. Right click in this folder, and you'll get `Show View Options` to show up. Set `Sort By` to `Snap to Grid`.

<img alt="The Finder Desktop `Show View Options` menu with `Sort By` set to `Snap to Grid`." src="images/desktop-show-view-options.png" height="600"/>

Navigate to your home folder (`hexdump` in my case). Right click in this folder, and you'll get another `Show View Options` to show up. This is different from the one on the Desktop, and will allow you to configure defaults for all of your Finder windows.

I've enabled `Always open in icon view`, set `Sort By` to `Snap to Grid`, and checked `Show Library Folder`. To set these options as the system defaults, I clicked `Use as Defaults`.

<img alt="The Finder `Show View Options` menu with `Always open in icon view` checked, `Sort By` set to `Snap to Grid` and `Show Library Folder` checked. A `Use as Defaults` button appears at the bottom of the window." src="images/home-folder-show-view-options.png" height="600"/>

### `Finder Preferences > General`

In Finder's `Preferences > General`, I've configured `New Finder windows show` to `Desktop`, and unchecked `Open folders in tabs instead of new windows`.

<img alt="The `Finder Preferences > General` pane open with `New Finder windows show` set to `Desktop` and `Open folders in tabs instead of new windows` unchecked." src="images/finder-preferences-general.png" height="600"/>

### `Finder Preferences > Sidebar`

By default, Finder puts a lot of stuff in the sidebar. I like to strip this down to only folders I frequently use: I've unchecked everything but `AirDrop`, `Applications`, `Desktop`, `Documents`, `Downloads`, `lschumm` (my home folder), and `External disks`.

<img alt="The `Finder Preferences > Sidebar` pane open with nothing checked but `AirDrop`, `Applications`, `Desktop`, `Downloads`, `hexdump` (my home folder), and `External disks`." src="images/finder-preferences-sidebar.png" height="600"/>

### `Finder Preferences > Advanced`

Under `Finder Preferences > Advanced` I've enabled `Show all filename extensions` and disabled `Show warning before changing an extension`. `When performing a search:` is set to `Search the Current Folder`.

<img alt="The `Finder Preferences > Advanced` pane open with `Show all filename extensions` checked and `Show warning before changing an extension` unchecked. `When performing a search:` is set to `Search the Current Folder`." src="images/finder-preferences-advanced.png" height="600"/>

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

## Configure Terminal

I use pretty much the stock terminal, with only two modifications. The first is making the background slightly transparent; which can be set by going to the `Terminal > Preferences` pane:

<img alt="The `Terminal > Preferences` pane." src="images/terminal-config.png" height="600"/>

Click on `Color & Effects` in order to bring up the color selection dialogue; set it to 65% opacity and 40% blur.

<img alt="The `Color & Effects` pane with plain white with 65% opacity and 40% blur." src="images/terminal-config-color.png" height="600"/>

Click on `Keyboard` and enable `Use Option as Meta Key`.

<img alt="The `Keyboard` pane open with `Use Option as Meta Key` selected." src="images/use-option-as-meta-key.png" height="600"/>

# Application Installs

##  Command-Line Applications

```
$ brew install zsh \
               emacs \
               python3 \
               rust \
               duti \
               cmake \
               moreutils \
               nmap \
               gpg
```

## Userland Applications

I like installing apps through `brew cask` because command line stuff is great, and it allows all of my applications to be centrally managed by a utility. Nothing is in the Mac App Store.

```shell
$ brew cask install telegram \
                    signal \
                    typora \
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
                    yed \
                    arduino \
		    discord
```

I then install Pages, Numbers, and Keynote from the Mac App Store.

## Set Tor Browser as the Default Browser

In `System Preferences > General`, set the default browser to `Tor Browser.app`.


## Set up Git credentials

To set up your `git` name and email, run:

```bash
$ EDITOR=emacs git config --global --edit
```

Edit the contents to the following:

```
[user]
    name = hexdump
    email = contact@hexdump.email
```

## Git Credential Cache Helper

On MacOS, you can set `Keychain.app` as your credential helper for git, so you won't have to keep entering your password:

```bash
git config --global credential.helper osxkeychain
```

## Globally gitignore .DS_Store files

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

## Login Items

![The `System Preferences > Users & Groups > Login Items` pane with the items `Karabiner-Elements`, `ProtonVPN`, and `Alfred 4`. The `Hide` checkbox next to each item is checked.](images/login-items.png)

## Opening Terminal-Based Emacs on Files

![The opening screen of Automator open, with the type of document chosen to be `Application`.](images/automator-terminal-emacs-hook-1.png)

![Automator open, with the `Actions` search field filled in with `applescript`, and the single result `Run AppleScript` showing.](images/automator-terminal-emacs-hook-2.png)

![The Automator `Run AppleScript` Action with the script below filled in.](images/automator-terminal-emacs-hook-3.png)

```applescript
on run {input, parameters}
	
	tell application "Terminal"
		do script "/usr/local/bin/emacs" & " " & POSIX path of input
	end tell
	
end run
```

Save this as `cli-emacs-hook.app` in `Applications`.

## Disable Gatekeeper

I think I have decent hygiene as to what I run on my computer, and I don't like macOS requiring every application to be recognized by *them*. I disable Gatekeeper (the service that verifies code signatures) like so:

```shell
$ sudo spctl --master-disable
```

## Install office apps

Install Pages, Numbers, and Keynote from the macOS app store.
