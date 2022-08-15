#!/bin/sh

board=${1:? "usage: $0 board" }

build_type=Debug

parallel_flag="-j"

shift

echo "Run the following commands"

echo "1. cmake .. -DBOARD_TARGET=$board -DCMAKE_BUILD_TYPE=$build_type -DCONFIG_DIR= -DFACTORY_IMAGE=OFF $@ && make (configuring in build)"
echo "2. cd $board && make (compiling the target)"
echo "3. all of the above"

echo -n  "Make your choice [1-3]: "

read cmd

cd ../bluenet/build

case $cmd in
	1)
		cmake .. -DBOARD_TARGET=$board -DCMAKE_BUILD_TYPE=$build_type -DCONFIG_DIR= -DFACTORY_IMAGE=OFF $@
		make $parallel_flag
		;;
	2)
		cd $board
		make $parallel_flag
		;;
	3)
		cmake .. -DBOARD_TARGET=$board -DCMAKE_BUILD_TYPE=$build_type -DCONFIG_DIR= -DFACTORY_IMAGE=OFF $@
		make $parallel_flag
		cd $board
		make $parallel_flag
		;;
	*)
		echo "Unknown option"
		;;
esac

