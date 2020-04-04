# Karabiner Configuration

## Enable Input Monitoring permission

Without enabling input monitoring, Karabiner will not work and will instead display the following message:

![Karabiner open, displaying a pop-up window with the message "karabiner_grabber and karabiner_observer require Input Monitoring permission. You have to allow them on System Preferences > Security & Privacy > Privacy > Input Monitoring".](images/karabiner-alert.png)

In order to enable input monitoring, since Karabiner doesn't properly request Input Monitoring through whatever new API macOS has requested, go to Security and Privacy and add the `karabiner_grabber` and `karabiner_observer` executibles access under Accessibility. The executibles are in the folder `/Library/Application Support/org.pqrs/Karabiner-Elements/bin`.

![The `System Preferences > Security & Privacy > Privacy` pane with `karabiner_grabber` and `karabiner_observer` in the list.](/Users/hexdump/dotfiles/tsuru-config/karabiner-config/images/karabiner-acessibility.png)

## Simple Modifications

I rebind `caps_lock` to `left_control` so that I actually have a use for the key and also to prevent emacs pinky.

![Karabiner open, under the tab `Simple Modifications` and with `Target device` set to `For all devices`, and with a mapping `From key` `caps_lock` `To key` `left_control`.](images/simple-modifications-for-all-devices.png)
