# input-config

This is a guide to my mouse/keyboard tweaks.

## Disable Middle Mouse Button

I don't really need the middle mouse button click functionality. *Where* in fact the area is on my trackpad that counts as "middle click" seems to be ever evoving and never in one place for long. Besides, since I have my terminal configured to actually allow `Control-C` without holding down shift, I'm pretty much set for all my copying and pasting needs. The code for mapping a middle mouse button click to copy and paste are actually application-specific, so we have to disable it globally.

I disable the middle mouse paste on both my TrackPoint buttons and on the trackpad. What would also work is simply disabling it on the trackpad but keeping it for the TrackPoint buttons, since you can bind the buttons separately. I've just decided to get rid of it unilaterally.

We'll be using the `xinput` utility to remap (really, unmap) our middle mouse button. Let's see what devices are currently connected:

```shell
$ xinput list
⎡ Virtual core pointer                    	id=2	[master pointer  (3)]
⎜   ↳ Virtual core XTEST pointer              	id=4	[slave  pointer  (2)]
⎜   ↳ Synaptics TM3075-002                    	id=12	[slave  pointer  (2)]
⎜   ↳ TPPS/2 IBM TrackPoint                   	id=13	[slave  pointer  (2)]
⎣ Virtual core keyboard                   	id=3	[master keyboard (2)]
    ↳ Virtual core XTEST keyboard             	id=5	[slave  keyboard (3)]
    ↳ Power Button                            	id=6	[slave  keyboard (3)]
    ↳ Video Bus                               	id=7	[slave  keyboard (3)]
    ↳ Sleep Button                            	id=8	[slave  keyboard (3)]
    ↳ Integrated Camera: Integrated C         	id=9	[slave  keyboard (3)]
    ↳ AT Translated Set 2 keyboard            	id=10	[slave  keyboard (3)]
    ↳ ThinkPad Extra Buttons                  	id=11	[slave  keyboard (3)]
```

You cannot set a `button-map` for a `master pointer`, only `slave pointer`s (apologies for the terminology, not my choice). The IDs of the TrackPoint and Trackpad pointers are `12` and `13`, so for each of these we will run `xinput-set-button-map`:

```shell
$ xinput set-button-map 12 1 0 3 4 5 6 7 8 9 10
$ xinput set-button-map 13 1 0 3 4 5 6 7 8 9 10
```

Normally, the sequence of numbers after the pointer ID will be `1` through `10`. Number `2` is the middle mouse click function, and setting it to `0` will map it to a "nothing" action, while retaining the other functionality of the middle mouse button.

We put these in our `~/.config/i3/config` file to be run whenever we boot into a desktop (thus able to use a mouse).
