# Bluenet workflow

The bluenet firmware can be found at <https://github.com/crownstone/bluenet>.

This repository contains my own workflow. No need to clutter that repository with my script files. :-)

The scripts in this repository are extremely simple. If they are not, the CMake build system needs love.

For example, the `flash_application.sh` script runs `make` with a few more workers than the default. Then it runs a sequence of make targets `write_application`, `write_bootloader_settings` and `reset`. Of course my shell `history` should be able to store these as well, but then I am searching through hundreds of lines before finding the right one if I did not program for a while.

By having an external workflow repository I do not bother anyone with my forgetfulness.

# Copyright

* Author: A.C. van Rossum
* Copyright: 2020
* License: LGPLv3, Apache License, MIT


