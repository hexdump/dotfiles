First, we format the disk with `$ fdisk /dev/sda`:

```
(fdisk) g
(fdisk) n
(fdisk) p
(fdisk) 1
(fdisk) <Enter>
(fdisk) +256M
(you may have to type y here to remove a signature)
(fdisk) t
(fdisk) 83

(fdisk) n
(fdisk) <Enter>
(fdisk) <Enter>
(fdisk) <Enter>
(you may have to type y here to remove a signature)
(fdisk) t
(fdisk) 2
(fdisk) 30

(fdisk) w
```

Then, we format the boot partition:

```
mkfs.fat -F32 /dev/sda1
```

Then, we set up our space for encrypted partitions

```
# cryptsetup -c aes-xts-plain64 -y --use-random luksFormat /dev/sda2
# cryptsetup luksOpen /dev/sda2 luks
# pvcreate /dev/mapper/luks
# vgcreate vg0 /dev/mapper/luks
```

Then we create the actual partitions:

```
# lvcreate --size 8G vg0 --name swap
# lvcreate -l +100%FREE vg0 --name root
```

Then, we format the encrypted partitions:

```
mkfs.ext4 /dev/mapper/vg0-root
mkswap /dev/mapper/vg0-swap
```

Then, we prepare the system for chroot:

```
mount /dev/mapper/vg0-root /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
swapon /dev/mapper/vg0-swap
```

Then, we run `dhcpcd` to make sure the internet is working, testing using `ping 1.1.1.1` or similar. Then, we install the base system:

```
pacstrap -i /mnt base base-devel linux linux-firmware lvm2 nano
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
ln -s /user/share/zoneinfo/America/Chicago /etc/localtime
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

Then, do an `bootctl install` for systemd-boot to get its bearings. After this, edit `/boot/loader/entries/arch.conf` to the following:

```
title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options cryptdevice=/dev/sda2:vg0:allow-discards root=/dev/mapper/vg0-root rw
```

and once again run `bootctl install`.

Next, install git with `pacman -S git`. Clone yay with `git clone https://aur.archlinux.org/yay.git`, `cd git`, and `makepkg -si`.

Run `yay -S broadcom-wl`. After running this, run:

```
rmmod b43
rmmod ssb
modprobe wl
```

Now install NetworkManager with `pacman`.


Now set the root password with `passwd`.

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
