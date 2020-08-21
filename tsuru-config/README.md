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

Then, we format the boot partition:

```
mkfs.fat -F32 /dev/sdb1
mkfs.ext4 /dev/sdb2
```

Then, we set up our space for encrypted partitions

```
# cryptsetup luksFormat /dev/sdb3
# cryptsetup luksOpen /dev/sdb3 lvm
# pvcreate /dev/mapper/lvm
# vgcreate vg /dev/mapper/lvm
# lvcreate -L 8G vg -n swap
# lvcreate -L +100%FREE vg -n root
```

Then, we format the encrypted partitions:

```
mkfs.ext4 /dev/mapper/vg-root
mkswap /dev/mapper/vg-swap
```

Then, we prepare the system for chroot:

```
mount /dev/mapper/vg-root /mnt
mkdir -p /mnt/efi /mnt/boot
mount /dev/sdb1 /mnt/efi
mount /dev/sdb2 /mnt/boot
swapon /dev/mapper/vg0-swap
```

Then, we run `dhcpcd` to make sure the internet is working, testing using `ping 1.1.1.1` or similar. Then, we install the base system:

```
pacstrap -i /mnt base base-devel linux linux-firmware grub efibootmgr lvm2 nano networkmanager intel-ucode
```

Then, we generate a fstab:

```
genfstab -pU /mnt >> /mnt/etc/fstab
```

Then, we chroot into the newly installed environment:

```
arch-chroot /mnt
```

Then, we select a timezone:

```
ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime
```

Then we set up our locale:

```
echo en_US.UTF-8 UTF-8 > /etc/locale.gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
locale-gen
export LANG=en_US.UTF-8
```

Then we synchronize the hardware clock:

```
hwclock --systohc --utc
```

Then we set our hostname

```
echo tsuru > /etc/hostname
```

Then we edit `/etc/hosts` with `nano` to the following contents:

```
127.0.0.1	localhost
255.255.255.255	broadcasthost
::1             localhost
```

Then, we use `nano` to edit `/etc/mkinitcpio.conf`. We add `ext4` to the `MODULES` list and `encrypt lvm2` before `filesystems` in the `HOOKS` list. Then, regenerate with `mkinitcpio -p linux`.

Then, do an `bootctl install` for systemd-boot to get its bearings. After this, edit `/efi/loader/entries/arch.conf` to the following:

```
title Arch Linux
linux /vmlinuz-linux
initrd  /intel-ucode.img
initrd /initramfs-linux.img
options cryptdevice=/dev/sda2:vg0:allow-discards root=/dev/mapper/vg0-root rw

```

Now set the root password with `passwd`, and reboot.

# Deprecated

##  Command-Line Applications

Using brew, install the following:

```bash
$ brew install zsh \
               emacs \
               python3 \
               rust \
               cmake \
               moreutils \
               nmap \
               gpg \
	       imagemagick \
               ffmpeg
```

Using pip (specifically `pip3`), install the following:

```bash
$ sudo pip3 install ptpython \
                    virtualenv
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
                    alfred \
                    yed \
                    arduino \
		    discord \
		    java \
		    libreoffice \
                    bitwarden
```

I then install Pages, Numbers, and Keynote from the Mac App Store.

## Set Firefox as the Default Browser

In `System Preferences > General`, set the default browser to `Firefox.app`.

## Set up Git credentials

To set up your `git` name and email, run:

```bash
$ EDITOR=emacs git config --global --edit
```

Edit the contents to the following:

```bash
[user]
	name = hexdump
	email = contact@hexdump.email
```

## Generate SSH key

To generate an SSH key, run:

```shell
$ ssh-keygen
```

Then, link your SSH key up to GitHub/VPSes/wherever else you use SSH authentication.
