### dotfiles
personal configuration files

they are linked into `${XDG_CONFIG_XXXX}` dirs via an admittedly hideous `link` shell script. the reason for this being that my location changes very frequently.

#### advantages
- configuration is a deployable, version-controlled "package" that can be 'installed' very quickly using the `link` script
- since the entire `XDG` configuration directories are in version control, it forces the user to examine every entry to the `XDG` directories to ensure that nothing is missed (this is both a blessing and a curse: see disadvantages)
- `.gitignore` contains a rolling list of files and directories you don't care about, so they only need to be ignored once.

#### disadvantages
- `XDG` dirs *must* be symlinks. this means, they can't exist at installation time.
- many useless configuration files will be detected upon creation and must be manually ignored (an opt-out of version control model)
- if you decide later you actually *do* want to version control a previously ignored file or directory, you would have to remember to manually remove it from `.gitignore`
