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

## Install Python3

MacOS (as of Mojave) installs Python `2.7.10`, which is a *reasonable* version of Python 2 to have. To install Python 3, I recommend `brew`:

```
brew install python3
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

```
osascript -e ‘tell application “Finder” to set desktop picture to POSIX file “/path/to/picture.jpg”’
```


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
