board=${1:? "usage: $0 board" }

cd ../bluenet/build
cmake .. -DBOARD_TARGET=$board -DCMAKE_BUILD_TYPE=Debug -DCONFIG_DIR=

make -j8

cd $board
make -j8

make write_application

#make build_bootloader_settings
make write_bootloader_settings

make reset
