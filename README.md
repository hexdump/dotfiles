# OS Installation

- Erase the main disk, erase and rename as `Macintosh HD` and format it as *encrypted* `APFS`.
- Make a secondary 40GB partition named `WINDOWS` for pentesting Windows.
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


# OS Configuration

## Install Homebrew

Use the `brew` default installer.

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

This will install the XCode command line tools as well.

## Change hostname

Under `System Preferences > Sharing`, change the hostname to the preferred name of your machine (I use the last names of famous computer scientists):

![Shows the Computer Name field of the Sharing preferences pane with the text set to my computer name: `dijkstra`](images/change_hostname.png)

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

MacOS (as of Mojave) installs Emacs `22.1.1`, which is ancient. Install `emacs26` with `brew`:

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

## Setting up File Hierarchy

I actually like to remap my home directory to Desktop, so it's visible on my screen. I remap my `HOME` environment variable to `~/Desktop`.

```
mkdir Desktop/research
git clone https://github.com/lschumm/blog blog
```

## Run dotfiles installer

```
cd Desktop
cd dotfiles
./install
```

## Make Finder show all file extensions

Not showing file extensions on some files is really needlessly confusing. Disable it in `Finder > Preferences`. I also like disabling warnings when changing extensions.

![Shows the `Finder > Prefences` pane with "Show all filename extensions" selected, and "Show warning before changing an extension" unselected.](images/finder_preferences.png)

## Set key repeat rate

I like setting my key repeat rate and key repeat time to very fast settings. You can set this under `System Preferences > Keyboard > Keyboard`.

![Shows the `System Preferences > Keyboard > Keyboard` menu with "Key Repeat" set to the "Fast" setting, and "Delay Until Repeat" set to the "Short" setting.](images/key_repeat.png)

## Enable meta key in terminal

To use `option` as the meta key in Terminal, enable it in `Terminal > Preferences > Profiles > Keyboard`:

![Shows the `Terminal > Preferences > Profiles > Keyboard` pane with "Use Option as Meta key" selected"](images/use_option_as_meta_key.png)

## Trackpad configuration

I like to set my trackpad sensitivity very high, and enable tap to click. You can configure this in `System Preferences > Trackpad`:

![The `System Preferences > Trackpad > Point & Click` menu with "Tap to click" enabled and "Tracking speed" set to "Fast".](images/trackpad.png)

## Mouse sensitivity

*Note: you need a mouse connected to configure this.*

I like my mouse sensitivity really high. You can configure this in `System Preferences > Mouse`:

![Shows the `System Preferences > Mouse` menu with "Tracking speed" set to "Fast", and "Scrolling speed" set to "Fast".](images/mouse_sensitivity.png)


## Autocorrect

I hate autocorrect changing and capitalizing my words. This can be changed in the `System Preferences > Keyboard` pane:

![Shows the `System Preferences > Keyboard` menu with "Correct spelling automatically", "Capitalize words automatically", "Add period with double-space", "Use smart quotes and dashes" disabled, and all replacement phrases deleted.](images/keyboard_settings.png)

## Git Credential Cache Helper

On MacOS, you can set `Keychain.app` as your credential helper for git, so you won't have to keep entering your password:

```
git config --global credential.helper osxkeychain
```

## BootCamp

Download the official Windows ISO file for Windows 10 from Microsoft, run and install Windows 10 Home.
