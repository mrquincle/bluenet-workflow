board=${1:? "usage: $0 board" }

# By default use 8 cores
export MAKEFLAGS='-j 8'

echo "Run the following commands"

echo "1. cmake .. -DBOARD_TARGET=$board -DCMAKE_BUILD_TYPE=Debug -DCONFIG_DIR= (configuring general build)"
echo "2. make"
echo "3. make depend && cd $board && make depend && cd boatloader && make depend && cd ../.."
echo "4. make && cd $board && make && cd .."
echo "5. make erase"
echo "6. make write_softdevice && make read_softdevice_version"
echo "7. cd $board && make write_board_version"
echo "8. make write_application"
echo "9. cd bootloader && make write_bootloader && make write_bootloader_address && cd .."
echo "10. make write_bootloader_settings"
echo "11. make reset"
echo
echo "12. all of the above"
echo "13. flash application only (combination of 1,2,4,8,10,11)"
echo "14. flash release application (-DCMAKE_BUILD_TYPE=Release)"

echo -n  "Make your choice [1-14]: "

read cmd

cd ../bluenet/build

case $cmd in
	14)
		build_type=Release
		cmd=13
		;;
	*)
		build_type=Debug
		;;
esac

case $cmd in
	12)
		# Configure
		cmake .. -DBOARD_TARGET=$board -DCMAKE_BUILD_TYPE=$build_type -DCONFIG_DIR=
		make

		# Dependencies
		make depend
		cd $board
		make depend
		cd bootloader
		make depend
		cd ../..

		# Build
		make
		cd $board
		make
		cd ..

		# Erase
		make erase

		# Write softdevice
		make write_softdevice
		make read_softdevice_version

		# Write application
		cd $board
		make write_board_version
		make write_application

		# Write bootloader
		cd bootloader
		make write_bootloader
		make write_bootloader_address
		cd ..

		# Write settings
		#make build_bootloader_settings
		make write_bootloader_settings

		# Reset
		make reset
		;;
	1)
		# Configure
		cmake .. -DBOARD_TARGET=$board -DCMAKE_BUILD_TYPE=$build_type -DCONFIG_DIR=
		;;
	2)
		make
		;;
	3)
		# Dependencies
		make depend
		cd $board
		make depend
		cd bootloader
		make depend
		cd ../..
		;;
	4)
		# Build
		make
		cd $board
		make
		cd ..
		;;
	5)
		# Erase
		make erase
		;;
	6)
		# Write softdevice
		make write_softdevice
		make read_softdevice_version
		;;
	7)
		# Write application
		cd $board
		make write_board_version
		cd ..
		;;
	8)
		cd $board
		make write_application
		cd ..
		;;
	9)
		# Write bootloader
		cd $board/bootloader
		make write_bootloader
		make write_bootloader_address
		cd ../..
		;;
	10)
		# Write settings
		cd $board
		#make build_bootloader_settings
		make write_bootloader_settings
		;;
	11)
		# Reset
		make reset
		;;
	13)
		# Just flash application
		cmake .. -DBOARD_TARGET=$board -DCMAKE_BUILD_TYPE=$build_type -DCONFIG_DIR=
		make
		cd $board
		make
		make write_application
		make write_bootloader_settings
		make reset
		;;

	*)
		echo "Unknown option"
		;;
esac

