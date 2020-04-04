# uma-config

This is the guide for the configuration of *uma*, my desktop Linux computer.

**note:** this guide assumes you have a reliable ethernet connection.

# preliminary configuration

## preparing install media

**note:** these instructions are specific for macOS.

first, download the latest elementaryos image from [https://elementary.io](https://elementary.io); i'm using `2020.01.01-x86_64` for writing this guide.

then, plug in an usb drive and unmount it (if there's only one external disk plugged in, it'll be `/dev/disk2`):

```
$ diskutil unmountdisk /dev/disk2
```

then burn the arch `iso` to the disk with `dd`:

```
$ sudo dd if=archlinux-2020.01.01-x86_64.iso of=/dev/disk2 bs=4m
```

## booting

push `F9` as the system is booting to select booting from the `USB Device`.

# Installation

- Click `Install elementary` to install elementaryOS on the hard drive.
- Choose `English (US)` in both columns for the keyboard layout.
- Select `Install third-party software for graphics and Wi-Fi hardware and additional media formats`.
- For `Installation type`, choose `Erase disk and install elementary`. Check `Encrypt the new elementary installation for security`, and click `Continue`.
- Set a security key.
- Install on `sda`.
- Click `Install Now`.
- Click `Continue` when it asks about changes to disks.
- Select Chicago as the time zone.
- Create a user with name and username `hexdump`. Name the computer `uma`. Personally, I use the same passphrase for my disk encryption as I do for my user password.

# Post-Installation

When presented with the introductory window, click `Skip All`, then `Get Started`.

# Install `snap`

Enable `snapd`:

```bash
$ sudo apt-get update
$ sudo apt-get install snapd
```

Then reboot:

```bash
$ sudo reboot
```

# Install `software-properties-common`

```bash
$ sudo apt-get install software-properties-common
```

# Remove Dock

```bash
$ sudo apt-get remove plank
```

Then log out and log back in.

# Install applications

```bash
$ sudo apt-get install emacs
```

```bash
$ sudo snap install telegram-desktop
```

```bash
$ wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
$ sudo add-apt-repository 'deb https://typora.io/linux ./'
$ sudo apt-get update
$ sudo apt-get install typora
```

```bash
$ sudo snap install gimp \
                    inkscape \
                    spotify \
                    vlc \
                    firefox \
                    discord
```

```
$ sudo apt-get install steam
```

```
$ sudo apt-get install torbrowser-launcher
```

```
$ sudo add-apt-repository ppa:deluge-team/ppa
$ sudo apt-get update
$ sudo apt-get install deluge
```

Download Tor Browser from the website (no, really, there's literally no way to do this through package managers. I don't understand it either).

```
$ tar xvf tor-browser-linux64-9.0.7_en-US.tar.xz
$ mv tor-browser_en-US/* ~/.local/share/applications/.
$ /usr/share/applications/start-tor-browser.desktop --register-app
```

# Terminal Configuration

Right click on the title bar of an open terminal window and select the white circle to make the terminal light theme.

# Configure keybindings

Put the following in `~/.Xmodmap`:

```
keycode 9 = grave asciitilde
keycode 66 = Control_L
```

Then, in `System Settings > Applications > Startup` add the custom command:

```
/usr/bin/xmodmap /home/hexdump/.Xmodmap
```

# Set desktop wallpaper
Set the desktop wallpaper in this folder, `desktop.png` to the wallpaper.