# Qutebrowser Tab Manager

tab-manager is a qutebrowser userscript to more powerfully manage single window sessions, written in python.

It saves all session files as html files, so that the files are portable across browsers.

It does not save tab history! The script only saves open tabs. If you need to export tab history for some reason, use the "export" command. see usage.txt or run "help" in the script for details.

Additionally, it includes the ability to export qutebrowser session files to HTML files. With this you can export history and multiple window sessions to HTML files.

FEATURES:
- save sessions
- load sessions
- append open tabs to specified sessions
- open session files in browser as html with hyperlinks
- maintain an index of all sessions
- remove duplicate tabs
- export qutebrowser sessions as HTML for portability
and a little bit more. See usage.txt for details.

## Why?

I have a bad habit of keeping browser tabs open for things I want to read later. I did this on a device I had to wipe and had a very, very hard time saving all open tabs.

What I wanted was a tool that would let me export all open tabs as links in an HTML file to be opened in another browser. So I started down that road, and scope creep led me here.

Also, when I used Firefox/Chromium as my daily browser, I used a Web Extension called "OneTab" that has somewhat similar functionality to this userscript.

I don't find multiwindow sessions or tab history to be useful very often, but what I do find useful is the ability to organize useful information very easily.
So I use this as basically a replacement for qutebrowser's built in session manager.

You can save categories of pages to read later, e.g "bookmarks", "recipes", "cool_github_projects", etc. and add pages to them as you find them. 

You can compartmentalize browsing sessions based on ongoing projects.

You can close whole sessions down to a single HTML page if you have a lot of tabs open for reference but only need one or two at a time.

## Installation and usage

Clone this repository to your qutebrowser userscripts directory (usually ~/.config/qutebrowser/userscripts).
see usage.txt for usage details.

## Known Issues

There are some limitations to qutebrowser that sometimes cause buggy behavior. The asynchronous nature of the browser sometimes causes two URLS to be passed as one, for example. This is a race condition involving reading the FIFO environment variable and asynchronous python.

To "fix" this you can open the script and adjust "wait_time" for a hard wait between executing qutebrowser commands, effectiveness will vary depending on your processor. 0.3 works for me 99.9% of the time.

Bear in mind that this will increase time to perform some operations significantly, e.g restore a session with 10 tabs takes 3 seconds by default, if you up it to 0.5 it will take 5 seconds.

Also there are things that a userscript simply cannot do, due to the way they interact with qutebrowser via FIFO and environmental variables. Opening multiple tabs at once is an example of this.

There is no tab autocompletion of commands or session names unfortunately. I don't know of any way to do this with userscripts in qutebrowser, but it would be nice. 

The built in qutebrowser session manager remembers anchor positions in open pages. This userscript does not do that. All restored pages will open at the top of the page.

If you find any bugs or problems that cannot be attributed to qutebrowser itself, feel free to open an issue, and include any information you think is pertinent.

## Dependencies

All dependencies are in the Python3 standard library. They are sys, os, datetime, time and yaml (for reading qutebrowser session files).

## Contributing

Pull requests are welcome, as are feature requests, but I do err on the side of not implementing new features to prevent scope creep and an unmaintainable codebase. Don't let that scare you from doing it though, it doesn't hurt to ask, I might love your ideas!

Qutebrowser is a very niche browser and as such, tools that extend the browser in powerful ways are hard to come by. If you like this (or anything else I have done) and feel like buying me a beer feel free to send me a few bucks:

XMR: 4AeufJrhpQn7LGW5dZ9tH4FFAtfmRwEDvhYrH5GQDbNxQ9VyWKmdycb5naWcvRTqbm3fkyqrDi23x453stDKzu5YVgPfcbj

BTC legacy: 141HaN7bq781BaB2PRP8mkUndebZXjxiFU

BTC segwit compatible: bc1qx2fa50av3j9hrjnszsnpflmtxqnz08936mq4xx

BCH: qzr9gk7tv274x9u9sft243m729zrjnq0cvpzlelapt

LTC: ltc1qa8re5eh2dklzfhg2x03tswsr5wae68qfxjzacd

ETH: 0x18304c5ed37dacefc920b291f39b06545b5fc258

I will give some portion (at my discretion) of any donations I get to The-Compiler for maintaining Qutebrowser, as well as to other FOSS tools I use.

You can always do that as well! Many of us put a lot of effort into things just because we want to see them exist and make people's lives better, and it is always nice when people appreciate and support us for what we do.
