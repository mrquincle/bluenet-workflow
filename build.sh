#!/bin/sh

board=${1:? "usage: $0 board" }

# By default use 8 cores
export MAKEFLAGS='-j 8'

echo "Run the following commands"

echo "1. cmake .. -DBOARD_TARGET=$board -DCMAKE_BUILD_TYPE=Debug -DCONFIG_DIR= && make (configuring in build)"
echo "2. cd $board && make (compiling the target)"
echo "3. all of the above"

echo -n  "Make your choice [1-4]: "

read cmd

cd ../bluenet/build

case $cmd in
	1)
		cmake .. -DBOARD_TARGET=$board -DCMAKE_BUILD_TYPE=Debug -DCONFIG_DIR=
		make
		;;
	2)
		cd $board
		make
		;;
	3)
		cmake .. -DBOARD_TARGET=$board -DCMAKE_BUILD_TYPE=Debug -DCONFIG_DIR=
		make
		cd $board
		make
		;;
	*)
		echo "Unknown option"
		;;
esac

