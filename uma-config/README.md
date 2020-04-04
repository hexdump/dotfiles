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

# Installing Applications

Enable `snapd`:

```bash
$ sudo apt update
$ sudo apt install snapd
```

```bash

```