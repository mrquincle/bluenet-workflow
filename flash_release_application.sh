board=${1:? "usage: $0 board" }

cd ../build
cmake .. -DBOARD_TARGET=$board -DCMAKE_BUILD_TYPE=Release -DCONFIG_DIR=

make -j4

cd $board
make -j4

make write_application

make build_bootloader_settings
make write_bootloader_settings

make reset
