# firefox-config

## Installation

Install Firefox via `pacman`:

```shell
$ pacman -S firefox
```

Open Firefox. Don't use any of Firefox's splash screen configuration.

## Profiles Configuration

I keep my personal and university work separate in my browser. Navigating to `about:profiles` in Firefox will let you manage your profiles. Firefox comes with an extra profile named `default`, which we'll rename to `university`. Rename the `default-release` profile to `personal`.

**Note that** all of the further configuration in this guide will only be saved in the profile in which you make these changes. Thus, you'll have to do everything here twice.

## Preferences

### General

- Disable `Ctrl+Tab cycles through tabs in recently used order`.
- Enable `When you open a link in a new tab, switch to it immediately`.
- Make sure that `Search for text when you start typing` is disabled. I'm not sure if at one point this was enabled by default, but at one point I had it enabled and it was absolutely terrible.
- Disable `Recommend extensions as you browse`.
- Disable `Recommend features as you browse`.

### Home

Although a cool landing page could be nice, I'm content with just a blank page.

- Set `Homepage and new windows` to `Blank Page`.
- Set `New tabs` to `Blank Page`.
- Uncheck everything under `Firefox Home Content`.

### Search

- Set `Default Search Engine` to DuckDuckGo.
- Disable `Provide search suggestions`.
- Leave `Search Shortcuts` as they are.

### Privacy & Security

- Set `Enhanced Tracking Protection` to `Strict`.
- Set `Send websites a "Do Not Track" signal that you don't want to be tracked` to `Always`.
- Disable everything under `Logins and Passwords`. I prefer to use Bitwarden for my passwords instead of any in-browser functionality.
- Under `Firefox Data Collection and Use`, disable everything.

## Add-Ons

I download add-ons from the official [Add-ons for Firefox](https://addons.mozilla.org/en-US/firefox/) site. I enable the `Allow this extension to run in Private Windows` option for all extensions.

- Bitwarden - Free Password Manager: This is a great, self-hostable password manager. I use the [bitwarden-rs](https://github.com/dani-garcia/bitwarden_rs) fork for my server.
- uBlock Origin: This is the best ad-blocker. It blocks URLs for ads from loading at all, increasing browser performance and limiting tracking. It also seems like a decent project.
- Privacy Possum: I use this instead of EFF's Privacy Badger because I believe its approach is more effective; sending trackers falsified information seems like it would work better at making my online identity harder to piece together than just submitting as little data as possible.
- Block Site: I use this to block time-wasting sites.
- Firefox Color: This is an easy theme maker for Firefox.

## Firefox Color

My theme is as follows (configure it under `Custom colors`):

- Toolbar Color: `6C9A8B`
- Background Color: `263A2C`
- Search Bar Color: `FFFAE3`
- Tab Highlight Color: `6C9A8B`
- Popup Text: `240B36`
- Toolbar Icons and Text: `FFFAE3`
- Background Tab Text Color: `DB9D47`
- Search Text: `240B36`
- Popup Background: `FFFAE3`

## Toolbar

To customize the toolbar, right click on an empty space and select `Customize`.

I remove everything from the toolbar, including spaces, leaving only the URL bar on the left and the overflow menu on the right. In my overflow menu, I put:

- Downloads
- Bitwarden
- uBlock Origin
- Privacy Possum
- Block Site

After you're done customizing, load a page. In the search bar there's a bookmark star icon and a icon for Mozilla's Pocket service. When you right click on both of these, you can remove them from the search bar.

## Add More Search Engines

For some reason, in the `Search Engines` part of Firefox's preferences, the `Find more search engines` link redirects you to the Firefox store and shows you completely unrelated extensions. To *actually* add more search engine options, go to the pages that you would like to add, and click the three horizontal dots in the URL bar, there is an `Add Search Engine` button. Once you've done that, you'll also have to add keywords for this search engine in `Preferences > Search > Search Shortcuts`. The search engines I add are:

- GitHub, with the keyword `@github`,
- Genius, with the keyword `@genius`.

## DuckDuckGo Configuration

DuckDuckGo lets you set a theme [here](https://duckduckgo.com/settings#appearance)! Here are my settings:
- `Font` is `sans-serif` (which actually maps to a serif font on my system, but this is more portable) which is selected via the `Custom` option which reveals a text box,
- `Background Color` is set to `#fffae3`,
- `Header Color` is set to `#6c9a8b`,
- `Result Title Font` is set to `sans-serif`,
- `Result Title Color` is set to `#240b36`,
- `Result Visited Title Color` is set to `#db9d47`,
- `Result Description Color` is set to `#240b36`,
- `Result URL Color` is set to `#db9d47`,
- `Result Hover, Module, and Dropdown Background Color` is set to `#fffae3`,
- `Site Icons` is set to `Off`.