# tobira-config

This is the configuration guide for *tobira*, my webserver and reverse proxy.

# Initial Configuration

Download the latest version of Raspbian and burn it to an SD card with at least 32GB of storage. Once it is done burning, mount the `boot` volume and create an empty file named `ssh` at the root of that volume. Plug the SD card into the Raspberry Pi, connect it using ethernet to the network. Wait a minute for it to boot, then use your router admin panel to look for the IP assigned to hostname `raspberrypi`. Connect using `ssh` to this ip with the username `pi` and password `raspberry`.

First, update all packages and restart:

```bash
$ sudo apt update && sudo apt upgrade && sudo reboot
```

Then update the hostname in *both* `/etc/hostname` and `/etc/hosts` by replacing all instances of `raspberrypi` with `tobira` in the files.

Create the user `hexdump` with adduser:

```bash
$ sudo adduser hexdump
```

Then allow user `hexdump` to use `sudo` by adding it to the `sudo` group:

```bash
$ sudo usermod -aG sudo hexdump
```

Log out of our `pi@tobira` session and log in under `hexdump`. Now, delete the `pi` account:

```bash
$ userdel pi
```

# NGINX Configuration

# Samba Configuration