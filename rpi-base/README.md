# rpi-base

Base configuration guide for Arch Linux on a Raspberry Pi. I use this for all my servers.

## SD Card Preparation

*these instructions are from [here](https://archlinuxarm.org/platforms/armv6/raspberry-pi)*

Start fdisk to partition the SD card:

```bash
# fdisk /dev/sdX
```

At the fdisk prompt, delete old partitions and create a new one:
- Type o. This will clear out any partitions on the drive.
- Type p to list partitions. There should be no partitions left.
- Type n, then p for primary, 1 for the first partition on the drive, press ENTER to accept the default first sector, then type +200M for the last sector.
- Type t, then c to set the first partition to type W95 FAT32 (LBA).
- Type n, then p for primary, 2 for the second partition on the drive, and then press ENTER twice to accept the default first and last sector.
- Write the partition table and exit by typing w.
    
Create and mount the FAT filesystem:

```bash
# mkfs.vfat /dev/sdX1
# mkdir boot
# mount /dev/sdX1 boot
```

Create and mount the ext4 filesystem:

```bash
# mkfs.ext4 /dev/sdX2
# mkdir root
# mount /dev/sdX2 root
```


Download and extract the root filesystem (as root, not via sudo):

**for Raspberry Pi 2, 3**

```bash
# wget http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-2-latest.tar.gz
```

**for Raspberry Pi 4**

```bash
# wget http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-2-latest.tar.gz
```

Now, extract it to our `root` partition and move our `boot` stuff to the `boot` partition:

```bash
# bsdtar -xpf ArchLinuxARM-rpi-latest.tar.gz -C root
# sync
# mv root/boot/* boot
```

Unmount the two partitions:

```bash
# umount boot root
```

## Pre-Configuration

First, we set up our `pacman` keys and perform a full system upgrade:

```bash
$ su root
# pacman-key --init
# pacman-key --populate archlinuxarm
# pacman -Syu
```

and reboot:

```bash
# reboot
```

Then, we create the `hexdump` user and clear out the `alarm` user:

```bash
$ su root
# useradd -m -G wheel hexdump
# passwd hexdump
[enter password]
```

Then, we log off and log back on to the machine as `hexdump` so that
we don't have an active session with the `alarm` user (which would
prevent us deleting that user).

```bash
$ su root
# userdel alarm
# rm -rf /home/alarm
```

We then install `base-devel` (which has `sudo`) and remove the
password for the `root` user (preventing logins as `root`):

```bash
# pacman -S base-devel
# passwd -d root
```

Then, we edit `/etc/sudoers` to uncomment the line:

```
%wheel ALL=(ALL) ALL
```

Without a new login, `sudo` will immediately start working.

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

Then we set our hostname (whatever it is for your system):

```
# echo my-hostname > /etc/hostname
```

Then we edit `/etc/hosts` with `nano` to the following contents:

```
127.0.0.1       localhost
255.255.255.255 broadcasthost
::1             localhost
```

# SSH Configuration

Make sure you've used `ssh-copy-id` to copy your key over to the
server. After this, go into `/etc/ssh/sshd_config` on the server, and
add the line:

```
PasswordAuthentication no
```

# Installations

All of my servers have:

- `tmux`
- `docker`
- `docker-compose`
- `htop`
- `emacs`
- `git`
- `rsync`

These can all be installed via `pacman`.
