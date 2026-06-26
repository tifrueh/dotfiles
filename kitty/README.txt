                                     kitty

                                      ---

This module contains all configuration concerning the kitty terminal. There are
two peculiarities that are worth noting:

* The main 'kitty.conf' loads /all/ .conf files that are contained within
  'kitty.d' in the /linked/ module root. Consequently, any machine-dependent
  configuration may be placed there.

* The 'if.conf' configuration is never loaded by default, but it can be used as
  a replacement configuration for playing text adventures or the like in kitty.

For everything to work correctly, the following two fonts need to be installed:

* SauceCodePro Nerd Font
* VT323 (only necessary for 'if.conf')
