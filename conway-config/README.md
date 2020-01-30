first, write the latest openbsd iso (6.6 in the case of this guide) `install66.fs`

then, write this to a usb drive with the following command (`pv` can be omitted as long as the whole command is `sudo`):

```
$ dd if=install66.fs | pv | sudo dd of=/dev/disk2
```

