# router-config

configuration for my entrypoint to all of my services. my router is a Raspberry
Pi running Raspbian Buster Lite (`2019-09-26`).

## setup

first, do a full update and upgrade of all installed packages:

```bash
$ sudo apt-get update && sudo apt-get upgrade
```

then reboot:

```bash
$ sudo reboot
```

## shairplay config

make sure you have all of the required packages:

```bash
$ sudo apt-get install autoconf automake libtool
$ sudo apt-get install libltdl-dev libao-dev libavahi-compat-libdnssd-dev
$ sudo apt-get install avahi-daemon
```

then clone the `shairplay` repository:

```bash
$ git clone https://github.com/juhovh/shairplay
```

and build it:

```bash
$ ./autogen.sh
$ ./configure
$ make
$ sudo make install
```

```
sudo apt-get install tmux
sudo apt-get install 
```
