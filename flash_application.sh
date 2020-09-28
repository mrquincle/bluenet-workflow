board=${1:? "usage: $0 board" }

cd ../bluenet/build
cmake .. -DBOARD_TARGET=$board -DCMAKE_BUILD_TYPE=Debug -DCONFIG_DIR=

make -j4

cd $board
make -j4

make write_application write_bootloader_settings reset
