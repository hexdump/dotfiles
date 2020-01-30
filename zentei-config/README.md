# zentei-config

## preparing install media

first, download the latest raspbian lite image from [https://www.raspberrypi.org/downloads/raspbian/](https://www.raspberrypi.org/downloads/raspbian/); i'm using `2019-09-26` for writing this guide.

then, plug in an sd card and unmount it (if there's only one disk, it'll be `/dev/disk2`):

```
$ diskutil unmountdisk /dev/disk2
```

then burn the raspbian `img` to the disk with `dd`:

```
$ sudo dd if=2019-09-26-raspbian-buster-lite.img of=/dev/disk2 bs=4m
```

## preparing system

log in as the `pi` user, password `raspberry`. do a full system update and upgrade:

```
$ sudo apt-get update && sudo apt-get upgrade
```

then reboot:

```
$ sudo reboot
```

now login and create a new user `hexdump`:

```
$ sudo adduser hexdump sudo
```

log out and log in as `hexdump`, then delete the `pi` user:

```
sudo userdel pi
```

## configuring internet connection

get the mac address for the wifi adapter (look for the `wlan0` entry):

```
$ ifconfig
```

then register the device on umass' device registration page at [https://clearpass.it.umass.edu/guest/mac_create.php](https://clearpass.it.umass.edu/guest/mac_create.php):




