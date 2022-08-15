#!/bin/sh

board=${1:? "usage: $0 board" }

build_type=Release

echo "Run the following commands"

echo "1. cmake .. -DBOARD_TARGET=$board -DCMAKE_BUILD_TYPE=$build_type -DCONFIG_DIR= -DFACTORY_IMAGE=OFF && make (configuring in build)"
echo "2. cd $board && make (compiling the target)"
echo "3. all of the above"

echo -n  "Make your choice [1-3]: "

read cmd

cd ../bluenet/build

case $cmd in
	1)
		cmake .. -DBOARD_TARGET=$board -DCMAKE_BUILD_TYPE=$build_type -DCONFIG_DIR= -DFACTORY_IMAGE=OFF
		make -j
		;;
	2)
		cd $board
		make -j
		;;
	3)
		cmake .. -DBOARD_TARGET=$board -DCMAKE_BUILD_TYPE=$build_type -DCONFIG_DIR= -DFACTORY_IMAGE=OFF
		make -j
		cd $board
		make -j
		;;
	*)
		echo "Unknown option"
		;;
esac

