board=${1:? "usage: $0 board" }

cd ../bluenet/build
cmake .. -DBOARD_TARGET=$board -DCMAKE_BUILD_TYPE=Debug -DCONFIG_DIR=

make
make depend

cd $board
make depend

cd bootloader
make depend


cd ../..
make -j8

cd $board
make -j8

cd ..

make erase
make write_softdevice
make read_softdevice_version

cd $board

make write_board_version
make write_application

cd bootloader

make write_bootloader
make write_bootloader_address

cd ..

#make build_bootloader_settings
make write_bootloader_settings

make reset
