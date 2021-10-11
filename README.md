## dotfiles


A collection of my personal dotfiles from `$HOME`

These keep evolving over the years, and there are actually several branches of this repository
- master: I'm going to just use this mainly from now on
- desktop: My Linux desktop dotfiles
- laptop: A separate single-headed version of my desktop branch
- macbook: Dotfiles from my Macbook Pro

All branches are obsolete except for master.

Master now contains a (hideous) shell script that essentially makes the repository a deployable real-time package.

The linker symlinks all dotfiles and $XDG_CONFIG_HOME, so that the repository no longer requires manual updates. It simply *is* the dotfiles that are being used. There is no more file copying.
