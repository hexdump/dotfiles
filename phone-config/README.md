# Phone Configuration Guide

## About

This is the configuration guide for my OnePlus 5 phone, codenamed `goldwasser`. These notes are essentially only for my own personal use, and are posted publicly so I can post references to individual sections. *I take no responsibility for people following these guides on their own devices. If you break or lose something by following these instructions, I am not accountable.* With that being said, if you have the same device(s) and for some reason want to ask questions, feel free to file an issue in this repository and I might be able to help.

## Notes

This configuration guide does not cover bootloader unlocking, nor does it cover firmware updates. I unlocked my phone when I first got it, and it's stayed unlocked ever since. I do recall that it didn't require exploits, only the `fastboot oem unlock` command.

## TWRP installation

*This section uses commands from the Android toolchain, which is available on Arch as `android-tools`.*

First, run:

```sh
$ adb reboot bootloader
```

This should launch us into the bootloader. From here, we run:

```shell
$ sudo fastboot flash recovery name-of-twrp-img.img
```

As of writing this, I am using `twrp-3.4.0-0-cheeseburger_dumpling.img`, downloaded from [here](https://dl.twrp.me/cheeseburger_dumpling/).

```shell
$ sudo fastboot flash recovery name-of-twrp-img.img
```

and then we run

```shell
$ sudo fastboot reboot
```
while holding volume down and power at the same time, to launch us into recovery.

## TWRP Configuration

TWRP will now ask for a password to decrypt data. We will select "cancel", since we are wiping all of the data.

TWRP will now ask whether it should "leave your system partition unmodified". We do not want to do this, so we "Swipe to Allow Modifications".

Now, we enter the "Wipe" menu. We want to wipe everything, so don't swipe just yet. Click "Format Data". Type "yes" to continue. After we're done, don't reboot; press "Back", and use the bottom navigation bar to navigate back to the TWRP main menu.

We will now install the latest build of LineageOS built with microG, downloaded from https://download.lineage.microg.org/cheeseburger/.

The technique we'll be using to load the LineageOS image is called "ADB sideloading". While we're downloading LineageOS, navigate to the "Advanced" section of the TWRP main menu, and select "ADB Sideload".

Once our ZIP is downloaded, do not decompress it. "Swipe to Start Sideload" on the phone, and then on the computer run

```sh
$ adb sideload lineage-zip-file.zip
```

After this is done, return to the main menu once more.

Go into settings, and under "General", unselect "Prompt to install TWRP app if not installed".

Return to the main menu, and click "Reboot", then "Power Off". We should now be on our way to a fresh LineageOS installation, ready for configuration!

## LineageOS Configuration

Once we land on the intro screen, click "Next", and set the following options:

- Use `English (United States)` for our language.
- Set our timezone to to `Central Time`. If the time and date are really wrong, fix them.
- Connect to a Wi-Fi network.
- Choose our only SIM for data.
- Turn on cellular data.
- Location services on LineageOS are not given to apps without prompting you about it first. Thus, I leave them enabled, so I can use location services with apps I trust.
- Disable LineageOS diagnostic and usage data collection. Don't use on screen navigation keys.
- Skip setting up a fingerprint.
- Set a PIN.
- Skip restoring from a backup.

## Post-Installation Configuration

Go into `Settings > About phone`. Tap the `Build number` field 7 times. Enter your PIN, and we're in developer mode!
In System > Advanced > Developer options, we'll make a couple tweaks:
Enable Android debugging, and when it prompts, enable USB debugging.

in Network & Internet > Hotspot & tethering, configure a wifi hotspot. Make sure to enable 5GHz, and disable `Turn off hotspot automatically`, since that's really annoying. Turn the hotspot on, and it'll pop up in our control center. Now turn it off.

in Display, disable adaptive brightness.Under Advanced, set our screen timeout to 5 minutes.

Also under Display > Advanced, disable Tap to sleep, and disable Wake on plug.

## F-Droid Installations

Install Aurora Store.


## Aurora Store

Aurora Store allows you to log in anonymously. Which is totally awesome. Sometimes it'll not work, and you'll have to re sign-in. But that always seems to fix the issue.

From the Play Store, we'll install:


## Telegram

Telegram wants permission to make phone calls to verify your phone number. You can have it send a text to another Telegram session, so this permission is really unnecessary. Deny it. It might ask again, deny it twice.

Don't allow access to contacts. Allow filesystem and photo access.

Do not "Allow Clock to set and clear the alarm which will wake up device from the power off state"

# Ringtones

In Settings > Sound > Advanced, I've set my notification sounds to things that kind of remind me of Wall-E:

- **Phone ringtone:** Zeta
- **Default notification sound:** Carme
- **Default alarm sound:** Helium

# Keyboard
In System > Languages & input > Virtual keyboard > Android Keyboard (AOSP) > Preferences, disable:
- Auto-capitalization
- Double-space period
- Voice input key

In the `System > Languages & input > Virtual keyboard > Android Keyboard (AOSP) > Text Correction`, disable everything.

## Buttons

In `System > Buttons`, set the following options:

### Power Button

- Enable `End Call`.
- Enable `Long press for torch`.

### Home Button

- Set `Long press action` to `No action`.

### Recents Button

- Set `Long press action` to `Recent apps switcher`.

### Volume Buttons

- Disable `Control playback`.
- Enable Keyboard cursor control, with the setting `Volume up/down moves cursor right/left`.
- Enable Show panel on left

## Fennec
On the initial screen on opeinning, set the `Automatic Privacy` setting to `Strict`.

### Settings

Under `Search`, delete all search engines other than DuckDuckGo. Disable all `Address bar` options other than `Search browsing history`.

Under `Tabs`, choose to close tabs after one day.

Under `Customize`, set th ee toolbar to be at the top of the screen. 
Disable everything under `Home` and `Gestures`.

In Logins and passwords, disable saving logins and passwords and disable Autofill. I use BitWarden for my passwords.

Enable `Set as default browser`.

In `Delete browsing data on quit`, enable this feature.

In `Add-ons`, install uBlock Origin and Bitwarden and allow them in private browsing. uBlock Origin does not require any configuration; BitWarden requires a login.