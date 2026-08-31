                                      aerc

                                      ---

This module contains the main configuration file for the 'aerc' mail client.
Note that in order to function, the following two files are also necessary,
placed into the same directory as the one found in this module:

* accounts.conf — This file specifies the mail accounts to be used (can be
                  created automatically from inside aerc via the :new-account
                  command).

* binds.conf    — This file specifies the keyboard binds for the application
                  (will be automatically generated if not present).

Note on Location
================

On Linux, the default MOD_ROOT of this module should be okay, but on macOS, the
configuration has to be placed under:

    ~/Library/Preferences/aerc
