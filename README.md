# DavDev Scripts
shell scripts collected since Ubuntu Hardy Heron was released, useful for reference purposes, some of them are a little outdated, but some are still current and quite useful.

## Script List
| Script Name             | Description                                                                 |
|--------------------------|-----------------------------------------------------------------------------|
| `200patch.sh`             | Applies kernel enhancements by modifying .bashrc and /etc/rc.local. Requires root privileges. |
| `batch-unrar.sh`          | Extracts all .rar files in the current directory and its subdirectories.     |
| `blip_unembed.sh`         | Converts a Blip.tv embed URL to the original URL and FLV URL, or an original URL to the FLV URL, then downloads the FLV file. Requires curl. |
| `bridge.sh`               | Manages a network bridge between eth0 and usb0.  Sets the bridge up or down based on the contents of .bridge_status.txt. Requires root privileges. |
| `capture.sh`              | Captures screen recordings using recordmydesktop and ffmpeg, outputting to /dev/video2. Requires root privileges. |
| `color-bash.sh`           | Prints a color table of 8 background and 8 foreground colors with bold options. |
| `comics.sh`               | Downloads daily comic strips from various websites (arcamax, ucomics, comics.com, dilbert.com) and saves them to the user's Desktop. Requires wget. |
| `compile_full_vim.sh`     | Compiles a full-featured Vim from source. Requires various development packages. Requires root privileges. |
| `conky.sh`                | Starts the conky system monitor after a 30-second delay. Requires conky to be installed. |
| `convertwma-ogg.sh`       | Converts a WMA file to an OGG file using mplayer and oggenc.               |
| `createasoundrc.sh`       | Creates a default audio device configuration file (~/.asoundrc) based on available sound cards. |
| `Fixkey.sh`               | Adds an APT key using zenity for user input. Requires zenity and apt.       |
| `Fixxkey.sh`              | Adds an APT key using zenity for user input. Requires zenity and apt.       |
| `genDeployCodeberg`       |                                                                             |
| `genDeployKey`            |                                                                             |
| `getmusic.sh`             | Downloads music from MySpace. Requires wget and rtmpdump.                  |
| `git-submodule-remove`    |                                                                             |
| `godownload.sh`           | Downloads and installs Go.  Detects the user's shell and adds necessary environment variables. Requires wget and tar. |
| `i3-resurrect`            |                                                                             |
| `Install_QuickStart.sh`   | Downloads and installs QuickStart. Requires wget and tar.  Installs zenity if not already present. Requires root privileges. |
| `install-build-deps.sh`   | Installs build dependencies for Chromium. Requires root privileges.  Supports Ubuntu 8.04, 8.10, and 9.04 on x86 architectures. |
| `install-wine-deps.sh`    | Installs Wine build dependencies. Requires root privileges. Supports Ubuntu 7.10, 8.04, 8.10, and 9.04. |
| `move_files.sh`           | Moves files from the current directory to a specified destination directory. Prompts the user for file name and destination. |
| `pi-upgrade.sh`           | Updates and upgrades Raspbian. Requires root privileges.                   |
| `randomac.sh`             | Changes the MAC address of eth0 to a random address. Requires root privileges. |
| `remove_old_kernels.sh`   | Removes old Linux kernels.  Prints a list of kernels to be removed in a dry run; use `sudo remove_old_kernels.sh exec` to actually remove them. Requires root privileges. |
| `sort_files.sh`           | Sorts files alphabetically in a specified directory. Prompts the user for file name and destination directory.  The script uses `find` and `mv` to move files. |
| `soundcloud.sh`           | Downloads music from SoundCloud. Requires wget.                            |
| `sources.sh`              | Generates a custom sources.list file using dialog for user input. Requires dialog.  Provides options for various repositories (Abiword, Amarok, AWN, Cairo Dock, Chromium, Conky, Exaile, FreeNX, GNOME-Colors, Google Linux, GNOME-Do, Medibuntu, OpenOffice, Opera, Oracle, Playdeb, PlayOnLinux, Skype, SMPlayer, Terminator, Ubuntu Tweak, VirtualBox, VLC, Wine, XBMC, KDE). |
| `tedtalks_downloader.sh`  | Downloads TED Talks videos. Requires wget or curl.                        |
| `ubucleaner.sh`           | Cleans the APT cache, removes old configuration files, and removes old kernels. Requires root privileges. |
| `ubuntu-install-etoile.sh`| Installs Etoile. Requires various development packages and Subversion. Requires root privileges. |
| `ubuntuTasks.sh`          | Performs various Ubuntu tasks based on user selections via zenity.  Options include uninstalling Mono, installing SBackup, installing restricted extras and codecs, installing MS Core Fonts, installing FileZilla, installing Wine, installing VLC, installing K3B, and enabling 5.1 surround sound. Requires zenity and aptitude. Requires root privileges. |
| `vacuum.sh`               | Runs VACUUM on all SQLite databases found in the user's Firefox profile directories.  Checks if Firefox is running before proceeding. |
| `vacuummoz.sh`            | Runs VACUUM on all SQLite databases in the user's Firefox and Thunderbird profile directories. Checks if Firefox and Thunderbird are running before proceeding. |
| `vimeo_downloader.sh`     | Downloads videos from Vimeo. Requires wget or curl.                       |
| `virtualnetconfig.sh`     | Configures a virtual network interface. Requires root privileges.         |
| `vmscript.sh`             | Configures a virtual network interface. Requires root privileges.         |
| `ZenTwitter.sh`           | Updates a Twitter status using zenity for user input and curl. Requires zenity and curl. |
