# OS Installation

- Erase the main disk, erase and rename as `Macintosh HD` and format it as *plain* `APFS`.
- Then, choose the `Reinstall MacOS` option on the new disk.
- On installation make sure to choose:
  - "Don't transfer any information now" on the Migration Assistant page
  - Sign in with Apple ID
  - Set username to `lschumm` instead of `liamschumm`
    - Don't allow Apple ID to rest this password
  - Under "Express Set-Up", choose "Customize Settings"
    - Enable Location Services
    - Disable analytics
    - Enable Siri
    - Do not "store files from Documents and Desktop in iCloud Drive"
  - Enable FileVault
    - Do not allow iCloud password to unlock the disk
  - Choose Light theme


# OS Configuration

## Install XCode

Go into the App Store and download XCode.

To install the XCode command line tools, run:

```
xcode-select --install
sudo xcodebuild -license
```


## Install Homebrew

Use the `brew` default installer.

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 
```


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


# Install `python2-pip`

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
```


## Dock Configuration

I personally don't really like the Dock, because it takes up space on my small 11 inch screen. I use Spotlight to open applications, and `Command + Tab` to switch applications/see what's open. This command will set the Dock autohide delay to 1000 seconds, so you have to hover over the bottom of the screen for 1000 seconds to display the dock.

If you *really* need your dock, `Command + Option + D` will manually open it; press it again to hide it.

```
defaults write com.apple.dock autohide-delay -float 1000; killall Dock
```


## Disabling Gatekeeper

Gatekeeper is that annoying "can't be opened because it is from an unidentified developer" thing. To disaple it, run:

```
sudo spctl --master-disable
```

I'm a responsible user and don't download random binaries and execute them; I don't like MacOS second guessing me.


## Setting up File Hierarchy

I actually like to remap my home directory to Desktop, so it's visible on my screen. I remap my `HOME` environment variable to `~/Desktop`.

```
mkdir Desktop/research
mkdir Desktop/blog
```

## Run dotfiles installer

```
cd Desktop
cd dotfiles
./INSTALL
```

## Install wakatime

Install `wakatime` globally using `pip`:

```
sudo pip install wakatime
```

Then, install the `wakatime-mode` package in `emacs`. First run:

```
M-x package-refresh-contents
```

to fetch the latest versions of packages. Then, install the package:

```
M-x package-install [RET] wakatime-mode
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
