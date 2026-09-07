                                      sway

                                      ---

This module contains a full configuration for the sway compositor, plus for a
few essentials.

Dependencies
============

The packages that this configuration directly depends upon are the following
(names how they are listed in the package repositories of Arch Linux):

Applications:

* dunst
* grim
* kitty
* nnn
* playerctl
* sway
* swaybg
* swayidle
* swaylock
* tofi (AUR)
* waybar
* wireplumber
* xdg-desktop-portal-wlr

Cosmetics:

* inter-font
* orchis-theme
* otf-font-awesome
* tela-circle-icon-theme-blue
* vimix-cursors

Additional Configuration
========================

The configuration in this module will also load any files placed in the
'config.d' directory of the module root.

Note on Bar Styles
==================

This module includes two separate configurations for waybar,
'.config/waybar/config.net', which shows network status, and
'.config/waybar/config.bat', which shows battery status. The desired one needs
to be symlinked manually to '.config/waybar/config' in the module root after
linking.

Note on Login Management
========================

Login management is probably most easily done using 'greetd' and 'tuigreet',
with, for example, a greeter line like:

tuigreet --cmd '/usr/bin/sway' --time --window-padding=1 --theme 'border=blue;button=green;time=blue' --remember-session

Note on Theming the Virtual Console
===================================

To automatically apply a theme to the virtual console on boot (which is what
can make a greeter like tuigreet actually pretty), the 'base16-setvtrgb' project
[1] can be used.

It is packaged as 'base16-vtrgb' on the AUR and includes both a whole host of
themes, plus an initcpio hook for Arch Linux.

A separate colour scheme that is consistent with the rest of the modules can be
found at [2]. It is packaged for Arch Linux as a part of [3].

[1]: https://github.com/coderonline/base16-vtrgb
[2]: https://github.com/tifrueh/base16-onehalfdark
[3]: https://github.com/tifrueh/PKGBUILDs

Note on Backgrounds
===================

This module includes wallpaper configuration, but no wallpaper images files.
Instead, the desired wallpaper should be placed at (or symlinked to) the file
'~/.local/etc/background'.
