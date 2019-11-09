# Karabiner Configuration

## Simple Modifications

### For all devices

I rebind `Caps Lock` to `Control` so that I actually have a use for the key and also to prevent emacs pinky.

![Karabiner open, under the tab `Simple Modifications` and with `Target device` set to `For all devices`, and with a mapping `From key` `caps_lock` `To key` `left_control`.](images/simple-modifications-for-all-devices.png)

### USB DEVICE (SONiX)

Since my 60% mechanical keyboard for some reason binds the top left key to `Escape` by default (with backtick/tilde as the `Fn+` option), I've rebound `escape` to `grave_accent_and_tilde`. Note that one of the complex modifications maps `Control-G` to `Escape`, so we'll still be able to use it.

![Karabiner open, under the tab `Simple Modifications` and with `Target device` set to `USB DEVICE (SONiX)`, and with a mapping `From key` `escape` `To key` `grave_accent_and_tilde`.](images/simple-modifications-usb-device.png)

## Complex Modifications

After you have opened Karabiner at least once, copy the `.json` files in this directory to `~/.config/karabiner/assets/complex-modifications/`. After restarting Karabiner, go into the `Complex Modifications` tab, click `Add rule`, and enable `arrow-keys`, `emacs-escape`, and `mouse-keys`. After enabling all of these, your `Complex Modifications section should look like this:

![Karabiner open, under the tab `Complex Modifications`, with a rule for each of: `mouse keys allows you to emulate a mouse with only your keyboard.`, `maps emacs' C-g to escape system-wide.`, and `allows you to emulate arrow keys on a 60% keyboard.`](images/complex-modifications.png)