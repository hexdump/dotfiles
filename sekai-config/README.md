# sekai-config

**note:** this guide assumes you have a reliable ethernet connection.

## preliminary configuration

### preparing install media

**note:** these instructions are specific for macOS.

first, download the latest archiso image from [https://www.archlinux.org/download/](https://www.archlinux.org/download/); i'm using `2020.01.01-x86_64` for writing this guide.

then, plug in an usb drive and unmount it (if there's only one external disk plugged in, it'll be `/dev/disk2`):

```
$ diskutil unmountdisk /dev/disk2
```

then burn the arch `iso` to the disk with `dd`:

```
$ sudo dd if=archlinux-2020.01.01-x86_64.iso of=/dev/disk2 bs=4m
```


### booting up

push `F9` as the system is booting to select booting from the `USB Device`. on the archiso boot menu, choose `Boot Arch Linux (x86_64)`.

### connect to internet

fire up `dhcpcd` to make sure you have an IP address:

```
$ dhcpcd
```

then check if you're online:

```
$ ping archlinux.org
```


### preparing partitions and filesystems

for partitioning my drive, i use `parted`. fire it up at the command line by typing:
```
$ parted
```

and then in the `(parted)` prompt, follow this guide:

```
(parted) select /dev/sda
Using /dev/sda
(parted) mktable
New disk label type? msdos
Warning: The existing disk label on /dev/sda will be destroyed and all data on this disk will be lost. Do you want to continue?
Yes/No? Yes
(parted) mkpart primary ext3 1MiB 512MiB
(parted) set 1 boot on
(parted) mkpart primary ext3 512MiB 100%
(parted) quit
Information: You may need to update /etc/fstab.
```

then initialize the filesystems:

```
$ mkfs.ext2 /dev/sda1
$ cryptsetup -c aes-xts-plain64 -y --use-random luksFormat /dev/sda2
$ cryptsetup luksOpen /dev/sda2 luks
```

and the partitions on the encrypted filesystem:

```
$ pvcreate /dev/mapper/luks
$ vgcreate vg0 /dev/mapper/luks
$ lvcreate --size 8G vg0 --name swap
$ lvcreate -l +100%FREE vg0 --name root
$ mkswap /dev/mapper/vg0-swap
$ mkfs.ext4 /dev/mapper/vg0-root
```

### mounting filesystems

first, load our swap:

```
$ swapon /dev/mapper/vg0-swap
```

then mount our filesystems in the format that the operating system will have them:

```
$ mount /dev/mapper/vg0-root /mnt
$ mkdir /mnt/boot
$ mount /dev/sda1 /mnt/boot
```

### install the base system

use `pacstrap` to install the base system, as well as `emacs` (for editing config files), `grub` and `lvm2`, and `git`:

```
$ pacstrap -i /mnt base base-devel linux linux-firmware emacs grub lvm2 git nvidia
```

(hit the `return` key when it asks your selection of `members in group base-devel`).

### generate fstab

generate the `fstab`:

```
genfstab -pU /mnt >> /mnt/etc/fstab
```

### system configuration

now, enter the newly created system:

```
$ arch-chroot /mnt /bin/bash
```

configure locale:

```
$ echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
$ echo LANG=en_US.UTF-8 > /etc/locale.conf
$ export LANG=en_US.UTF-8
```

set `/etc/localtime` to your timezone:

```
$ ln -s /usr/share/zoneinfo/America/New_York /etc/localtime
```

synchronize the hardware clock:

```
$ hwclock --systohc --utc
```

set the system hostname:

```
$ echo kikai > /etc/hostname
```

now add our user:

```
useradd -m -g users -G wheel -s /bin/bash hexdump
```

and set their password:

```
$ passwd myusername
```

now enable group `wheel` to use `sudo` by editing `/etc/sudoers`:

```
$ emacs /etc/sudoers
```

**note:** you'll have to use `C-x C-q` to disable read-only mode in the emacs buffer.

and uncomment the line `# %wheel ALL=(ALL) ALL`. exit emacs.

### configure initial ramdisk

edit `/etc/mkinitcpio.conf` with emacs:

```
$ emacs /etc/mkinitcpio.conf
```

under `MODULES`, add `ext4`, so it looks like:

```
MODULES=(ext4)
```

under `HOOKS`, add `encrypt` and `lvm2` before `filesystems`, so it looks like:

```
HOOKS=(base udev autodetect modconf block encrypt lvm2 filesystems keyboard fsck)
```

now exit emacs and regenerate the initial ramdisk.

```
$ mkinitcpio -p linux
```

### set up grub

install grub on our boot volume (`/dev/sda`):

```
grub-install --target=i386-pc --recheck /dev/sda
```

and then use `emacs` to edit `/etc/default/grub` to set the variable `GRUB_CMDLINE_LINUX` to `cryptdevice=/dev/sda2:luks:allow-discards`, so it looks like this:

```
GRUB_CMDLINE_LINUX="cryptdevice=/dev/sda2:luks:allow-discards"
```

then exit emacs and generate the grub config file:

```
grub-mkconfig -o /boot/grub/grub.cfg
```

### install and enable networkmanager

```
sudo pacman -S networkmanager network-manager-applet
```

```
sudo systemctl enable NetworkManager.service
```

### reboot

now exit the chroot:

```
$ exit
```

and reboot the system:

```
$ reboot
```

## secondary configuration

### install xfce

install xfce and lxdm

```
sudo pacman -S xfce4 xfce4-goodies lxdm
```

enable lxdm

```
sudo systemctl enable lxdm
```

and set xfce4 as the window manager for lxdm by using emacs to edit `/etc/lxdm/lxdm.conf`:

```
$ emacs /etc/lxdm/lxdm.conf
```

change the config to assign `session` to `/usr/bin/startxfce4`, so the line looks like:

```
session=/usr/bin/startxfce4
```

### install yay

```
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

### install userland applications

```
$ pacman -S firefox
```
