# MacOS Setup Scripts

These scripts complete my MacOS configuration by changing a bunch of MacOS settings (apply_os_settings.sh) and installing my base applications (install_apps.sh) and then configuring a few apps (apply_app_settings.sh).

This is completely catered to my own taste and installs applications that I use. If you're like to use this form of automated install, go over each script and have a look at the settings it configures and the apps that it installs to personalise it to your needs.

These scripts will work on a freshly installed MacOS device. It uses [Homebrew](https://brew.sh) and the [Mac App Store CLI](https://github.com/mas-cli/mas) to install applications.

There's also the directory 'offline-apps/' and the install_apps.sh script runs to all downloaded .pkg files and installs them as well. At the bottom of install_apps.sh is also a list of URLs to DMG files that it will download, mount and detect whether to just move it to /Applications or use the installer cli.

# Steps

- sh apply_os_settings.sh
- reboot
- sh install_apps.sh
- reboot
- sh apply_app_settings.sh
- reboot