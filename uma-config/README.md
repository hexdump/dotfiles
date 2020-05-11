# Manjaro Installation
- Press F9 and boot from USB
- Boot with standard settings
- Start installation
- American English
- America/Chicago for region
- Default keyboard configuration
- Erase disk, with `Swap (with Hibernate)`. Do not encrypt system.
- Fill in user information, set the hostname, and select `Use the same password for the administrator account.`
- Select `No office suite`
- Install, then restart the computer.

# BIOS Setup
- Press F10 on boot to enter the BIOS
- Under `Advanced > Power-On Options`, enable `After Power Loss`.
- Under `Advanced > BIOS Power-On`, enable all days and set the boot time to `00:00`. Ensure the BIOS clock is set correctly.
- Under `Storage > Boot Order`, set `Hard Drive` as the first entry.
- Save your changes and exit the BIOS.


- Disable `Launch at start` for Manjaro Hello
- Enable bluetooth by clicking the icon in the menu bar. Allow it to be enabled automatically.

- In `Manjaro Settings Manager > Time and Date`, enable `Set time and date automatically` and `Hardware clock in local time zone`.

# Installation
```
$ sudo pip3 install virtualenv
```