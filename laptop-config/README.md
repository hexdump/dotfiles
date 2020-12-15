# kuro-config

This is the configuration guide for my Thinkpad x240, codenamed
`monae`. I'm installing Arch as single-boot on the internal 128GB M.2
SSD; I've configured this as the primary boot drive as to leave the
Windows 10 Pro installation I got with this computer alone.

## Install Media Preparation

From the Arch Linux website, download the install ISO file. Flash it
to a USB drive with the `dd` command:

```bash
$ dd if=archlinux-2020.08.01-x86_64.iso of=/dev/diskX bs=4M
```

(where `/dev/diskX` is the file descriptor for the USB drive on which
you are preparing the install media).

## BIOS Configuration

Make sure the target boot drive is selected as the first boot option,
and make sure that UEFI booting is standard.

## Booting

This will depend on your laptop, but on mine I have to hit `<Enter>`
when the device starts booting, and then `<F12>` to select the USB
drive as a boot device.

## Verifying Environment

### Verifying Internet Connection

First, make sure you have an internet connection. You'll need to run
the `dhcpcd` command to get a DHCP lease. After you have run this
command, use `curl` or `ping` with a known good URL or IP address
to verify that your internet connection is working.

### Verifying UEFI

Make sure the Arch installation media has been booted with UEFI. To do
this, verify that the `/sys/firmware/efi` folder exists. If it does,
you have booted with UEFI. If it does not, you have not.

## Pre-Installation

**Important: `/dev/sdb` is the disk I would like to install to. Make
sure you find the correct file descriptor for the device you would
like to install to with `fdisk -l`.**

### Disk Partitioning

My partition scheme for Arch is the following:

- 256MB EFI partition
- 256MB Boot partition
- ~110GB Encrypted partition

On this encrypted partition, there are two "virtual" partitions: an
8GB swap partition (I chose to put swap here so it would be
encrypted), as well as another all-encompassing `root` partition where
the system is stored.

First, we format the disk with `$ fdisk /dev/sdb`:

```
(fdisk) g
(fdisk) n
(fdisk) <Enter>
(fdisk) <Enter>
(fdisk) +256M
(you may have to type y here to remove a signature)
(fdisk) t
(fdisk) 1

(fdisk) n
(fdisk) <Enter>
(fdisk) <Enter>
(fdisk) +256M
(you may have to type y here to remove a signature)
(fdisk) t
(fdisk) <Enter>
(fdisk) 20

(fdisk) n
(fdisk) <Enter>
(fdisk) <Enter>
(fdisk) <Enter>
(you may have to type y here to remove a signature)
(fdisk) t
(fdisk) <Enter>
(fdisk) 30

(fdisk) w
```

Then, we format the EFI and boot partitions:

```
mkfs.fat -F32 /dev/sdb1
mkfs.ext4 /dev/sdb2
```

Then, we set up the encrypted partition and the virtual partitions on
it:

```
# cryptsetup luksFormat /dev/sdb3
# cryptsetup luksOpen /dev/sdb3 lvm
# pvcreate /dev/mapper/lvm
# vgcreate vg /dev/mapper/lvm
# lvcreate -L 8G vg -n swap
# lvcreate -L +100%FREE vg -n root
```

Then, we format the encrypted partitions (just as we would any other):

```
mkfs.ext4 /dev/mapper/vg-root
mkswap /dev/mapper/vg-swap
```

## Installation

Then, we mount all of our partitions as they would be mounted in the
system, so we can proceed with our installation.

```
mount /dev/mapper/vg-root /mnt
mkdir -p /mnt/efi /mnt/boot
mount /dev/sdb1 /mnt/efi
mount /dev/sdb2 /mnt/boot
swapon /dev/mapper/vg0-swap
```

Then, we use the `pacstrap` command to install the base packages,
kernel, etc. to the system partitions.

```
pacstrap -i /mnt base base-devel linux linux-firmware grub efibootmgr lvm2 nano networkmanager intel-ucode
```

A couple notes on the package choices:
- `base` + `base-devel` don't include any editor, so i threw `nano` in
there. you could replace that with `emacs` or `vi` or something.
- if you don't install `networkmanager`, there won't be any way to
connect to the internet when you boot.
- `intel-ucode` is important! According to the Arch wiki, "These
updates provide bug fixes that can be critical to the stability of
your system. Without them, you may experience spurious crashes or
unexpected system halts that can be difficult to track down."

After `pacstrap` has finished, we generate a fstab:

```
genfstab -pU /mnt >> /mnt/etc/fstab
```

## Pre-Configuration

Then, we chroot into the newly installed environment (essentially,
allowing us to use the new system by using the kernel from the boot
media):

```
arch-chroot /mnt
```

Set the root user password with the following command:

```bash
# passwd
```

Then, we select a timezone:

```
# ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime
```

Then we set up our locale:

```
# echo en_US.UTF-8 UTF-8 > /etc/locale.gen
# echo LANG=en_US.UTF-8 > /etc/locale.conf
# locale-gen
# export LANG=en_US.UTF-8
```

Then we synchronize the hardware clock:

```
# hwclock --systohc --utc
```

Then we set our hostname

```
# echo kuro > /etc/hostname
```

Then we edit `/etc/hosts` with `nano` to the following contents:

```
127.0.0.1	localhost
255.255.255.255	broadcasthost
::1             localhost
```

Then we enable NetworkManager:

```
# systemctl enable NetworkManager.service
```

Then, we use `nano` to edit `/etc/mkinitcpio.conf`. We add `ext4` to the `MODULES` list and `encrypt lvm2` before `filesystems` in the `HOOKS` list. Then, regenerate with `mkinitcpio -p linux`.

Now, we run `grub-install --efi-directory=/efi` to initially configure the GRUB bootloader.
After this command has been run, we edit `/etc/default/grub`:

- Use the `blkid` command to get the `UUID` of the partition which the
encrypted volumes are stored. Set the variable `GRUB_CMDLINE_LINUX="cryptdevice=UUID=$UUID:vg root=/dev/mapper/vg-root resume=/dev/mapper/vg-swap"`
(where `$UUID` is the `UUID` you found from `blkid`).
- Set `GRUB_ENABLE_CRYPTODISK=y`.

After you have configured the GRUB configuration file, regenerate our
`grub.cfg` like so:

```bash
# grub-mkconfig -o /boot/grub/grub.cfg
```

Now, use `exit` to leave the new Arch system, and shut down your
system with `shutdown -h now`.

## Configuration

### User Setup

We haven't set up a user account yet, so we'll need to log in
initially as root.

Create our user (in my case, `hexdump`, with:

```bash
# useradd -m -G wheel hexdump
```

and set their password with:

```bash
# passwd hexdump
```

Then, install `sudo`:

```bash
# pacman -S sudo
```

and use `nano` to edit `/etc/sudoers` (technically you're supposed to
use `visudo`, and `nano` will complain that this file should be
read-only, but whatever) to uncomment the line:

```
%wheel ALL=(ALL) ALL
```

After we've gotten the account and `sudo` configured, we won't need to
be the root account anymore, so log out and log back in as your user.

### Configuring `yay`

AUR helpers are convenient and relly don't take away any power from
the user. My AUR helper of choice is `yay`. However, `yay` is only in
the AUR, which is kind of a Catch 22. Thus, we'll have to build it
from scratch. First, install `git`:

```bash
$ sudo pacman -S git
```

Then, clone the `yay` repository, and install from it:

```bash
$ git clone https://aur.archlinux.org/yay.git
$ cd yay
$ makepkg -si
$ cd ..
$ rm -rf yay
```

### Configuring fonts

Install some fonts:

```bash
$ sudo pacman -S ttf-dejavu ttf-liberation noto-fonts ttf-fira-code
```

Then, enable the following font presets:

```bash
$ sudo ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d
$ sudo ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d
$ sudo ln -s /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d
```

Enable FreeType subpixel hinting by editing
`/etc/profile.d/freetype2.sh`, and uncommenting the last line:

```
export FREETYPE_PROPERTIES="truetype:interpreter-version=40"
```

Then, copy the following into `/etc/fonts/local.conf`:

```
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
    <match>
        <edit mode="prepend" name="family"><string>Noto Sans</string></edit>
    </match>
    <match target="pattern">
        <test qual="any" name="family"><string>serif</string></test>
        <edit name="family" mode="assign" binding="same"><string>Noto Serif</string></edit>
    </match>
    <match target="pattern">
        <test qual="any" name="family"><string>sans-serif</string></test>
        <edit name="family" mode="assign" binding="same"><string>Noto Sans</string></edit>
    </match>
    <match target="pattern">
        <test qual="any" name="family"><string>monospace</string></test>
        <edit name="family" mode="assign" binding="same"><string>Noto Mono</string></edit>
    </match>
</fontconfig>
```

### Configuring `xorg` + `i3`

Install the following packages:

```bash
$ sudo pacman -S xorg xorg-xinit i3-gaps i3status rofi feh picom
```

Then, paste the following in `~/.xinitrc`:

```
#!/usr/bin/env sh

exec i3
```

And then, to start `i3` on login, put the following in
`~/.bash_profile`:

```
#!/usr/bin/env sh

startx
```

Then, copy the `i3.config` file from this repository to
`~/.config/i3/config`, and copy the `i3status.config` file to
`~/.config/i3status/config`.

Log out and log back in to start `i3`.

### Configuring sound

`ALSA` is part of the kernel, but to use it we'll need to install
utilities for it:

```bash
$ sudo pacman -S alsa-utils
```

Then, we can use the `alsamixer` command to get a command-line
interface to the sound card. On my ThinkPad, the sound card that
shows up has boxes instead of mixers. This is because it's selecting
the sound card for HDMI output. Running `alsamixer -c 1` selects
the right sound card. I use the `asoundconf` utility to set ALSA to
use the right sound card. This utility can be installed with:

```bash
$ sudo pacman -S asoundconf
```

And then the sound card can be set with:

```bash
$ asoundconf set-default-card 1
```

# Credits

- https://gist.github.com/mattiaslundberg/8620837
- https://gist.github.com/glats/ca71bbddc85f6a756e1e

# Theme

Colors are:
- 263a2c,db504a,6c9a8b,a379c9,db9d47,832161,240b36,fffae3,2e0014,777da7
