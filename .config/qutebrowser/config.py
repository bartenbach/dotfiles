# NOTE: config.py is intended for advanced users who are comfortable
# with manually migrating the config file on qutebrowser upgrades. If
# you prefer, you can also configure qutebrowser using the
# :set/:bind/:config-* commands without having to write a config.py
# file.
config.load_autoconfig(True)

#-------------------------
# general configuration
#-------------------------
c.qt.highdpi = True
c.zoom.default = '150%'

c.url.default_page = "https://google.com"
c.url.searchengines = {
    'DEFAULT':  'https://google.com/search?hl=en&q={}',
    '!a':       'https://www.amazon.com/s?k={}',
    '!d':       'https://duckduckgo.com/?ia=web&q={}',
    '!dd':      'https://thefreedictionary.com/{}',
    '!e':       'https://www.ebay.com/sch/i.html?_nkw={}',
    '!fb':      'https://www.facebook.com/s.php?q={}',
    '!gh':      'https://github.com/search?o=desc&q={}&s=stars',
    '!gist':    'https://gist.github.com/search?q={}',
    '!gi':      'https://www.google.com/search?tbm=isch&q={}&tbs=imgo:1',
    '!gn':      'https://news.google.com/search?q={}',
    '!ig':      'https://www.instagram.com/explore/tags/{}',
    '!m':       'https://www.google.com/maps/search/{}',
    '!p':       'https://pry.sh/{}',
    '!r':       'https://www.reddit.com/search?q={}',
    '!sd':      'https://slickdeals.net/newsearch.php?q={}&searcharea=deals&searchin=first',
    '!t':       'https://www.thesaurus.com/browse/{}',
    '!tw':      'https://twitter.com/search?q={}',
    '!w':       'https://en.wikipedia.org/wiki/{}',
    '!yelp':    'https://www.yelp.com/search?find_desc={}',
    '!yt':      'https://www.youtube.com/results?search_query={}'
}
c.url.start_pages = ["https://google.com"]
c.url.open_base_url = True # no params opens searchengine

c.downloads.location.directory = '~/down'
c.downloads.location.prompt = True
c.downloads.location.remember = True
c.downloads.location.suggestion = 'both'
c.downloads.position = 'bottom'
c.downloads.remove_finished = 10000

c.fileselect.handler = 'external'
c.editor.command = [
        'alacritty',
        '--class', 'quteSelect,quteSelect',
        '-e', 'nvim',
        '-f', '{file}'
        ]
c.fileselect.single_file.command = [
        'alacritty',
        '--class', 'quteSelect,quteSelect',
        '-e', 'vifm',
        '--choose-files={}'
        ]
c.fileselect.multiple_files.command = [
        'alacritty',
        '--class', 'quteSelect,quteSelect',
        '-e', 'vifm',
        '--choose-files={}'
        ]
c.fonts.default_family = ['xos4 Terminus:style Regular', 'JetBrains Mono' ]
c.hints.auto_follow = 'unique-match'
c.keyhint.delay = 0
c.spellcheck.languages = ['en-US']
c.tabs.last_close = 'close'
c.tabs.show = 'always'
c.window.hide_decoration = True
c.window.transparent = True

# don't just leave insert mode or do other bizarre things with insert mode
c.input.insert_mode.auto_leave = True
c.input.insert_mode.auto_load = False
c.input.insert_mode.leave_on_load = True

#------------------
# content settings
#------------------
c.content.pdfjs = True
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')
config.set('content.cookies.accept', 'never', 'https://www.stackoverflow.com/*')

config.set('content.headers.accept_language', '', 'https://matchmaker.krunker.io/*')

config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:90.0) Gecko/20100101 Firefox/90.0', 'https://accounts.google.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')

config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')

config.set('content.javascript.enabled', False, '*://*')
config.source('whitelist.py')

config.set('content.notifications.enabled', False, 'https://*')

# if JS is whitelisted, enable clipboard access
config.set('content.javascript.can_access_clipboard', True)

config.set('content.blocking.whitelist', ["*://click.e.progressive.com/*"])

#------------
# appearance
#------------
# super buggy, causes forms to be invisible
#c.colors.webpage.darkmode.enabled = False
#c.colors.webpage.bg = 'gray'
#c.colors.webpage.darkmode.policy.images = 'smart'
#c.colors.webpage.darkmode.threshold.text = 150
#c.colors.webpage.darkmode.threshold.background = 205

# instead, we will "suggest" that the website use dark with its own css
c.colors.webpage.preferred_color_scheme = 'dark'

c.fonts.downloads = 'default_size default_family'
c.fonts.hints = 'bold 7pt default_family'
c.fonts.keyhint = '7pt default_family'
c.colors.tabs.even.bg = "black"
c.colors.tabs.even.fg = "white"
c.colors.tabs.odd.bg = "black"
c.colors.tabs.odd.fg = "white"
c.colors.tabs.pinned.even.bg = "black"
c.colors.tabs.pinned.even.fg = "white"
c.colors.tabs.pinned.odd.bg = "black"
c.colors.tabs.pinned.odd.fg = "white"
c.colors.tabs.pinned.selected.even.bg = "magenta"
c.colors.tabs.pinned.selected.even.fg = "white"
c.colors.tabs.pinned.selected.odd.bg = "magenta"
c.colors.tabs.pinned.selected.odd.fg = "white"
c.colors.tabs.selected.odd.bg = "magenta"
c.colors.tabs.selected.odd.fg = "white"
c.colors.tabs.selected.even.bg = "magenta"
c.colors.tabs.selected.even.fg = "white"
c.colors.webpage.bg = ""

#---------------
# key bindings
#---------------
keybinds = {
    "normal": {
        "J": "tab-prev",
        "K": "tab-next",
        "d": "tab-close --force",
        "<Ctrl-V>": None,
        "gJ": "tab-move -",
        "gK": "tab-move +",
        "R": "reload --force",
        "co": "download-open",
        "ce": "config-edit",
        "cs": "config-source",
        "ge": "set-cmd-text :open {url:pretty}",
        "gE": "set-cmd-text :open -t -r {url:pretty}",
        "xo": "set-cmd-text -s :open -p",
        "xO": None,
        "'": "set-cmd-text -s :quickmark-load",
        ",m": "spawn mpv {url}",
        ",p": "mode-enter passthrough",
        ",M": "hint links spawn mpv {hint-url}",
        ",a": "spawn -d youtube-dl -x -o /home/blake/snd/%(title)s-%(id)s.%(ext)s -- {url}",
        "cu": "spawn alacritty --class 'quteSelect,quteSelect' -e nvim -f /home/blake/.config/qutebrowser/whitelist.py"
    }
}

for mode, binds in keybinds.items():
    for k, v in binds.items():
        if v is None:
            config.unbind(k, mode=f"{mode}")
        else:
            config.bind(k, v, mode=f"{mode}")
