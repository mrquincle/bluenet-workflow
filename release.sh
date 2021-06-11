board=${1:? "usage: $0 board" }

cd ../build

cd $board

make generate_dfu_package_bootloader 
make generate_dfu_package_application 
make generate_dfu_package_all
make install
