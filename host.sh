#!/bin/sh

parallel_flag="-j"

board=host

echo "Run the following commands"

echo "1. cmake .. -DBOARD_TARGET=$board -DCOMPILE_FOR_HOST && make (configuring in build)"
echo "2. cd $board && make (compiling the target)"
echo "3. all of the above"

echo -n  "Make your choice [1-3]: "

read cmd

cd ../bluenet/build

case $cmd in
	1)
		cmake .. -DDOWNLOAD_JLINK=OFF -DDOWNLOAD_NRFUTIL=OFF -DCOMPILE_FOR_HOST=ON
		make $parallel_flag
		;;
	2)
		cd $board
		make $parallel_flag
		;;
	3)
		cmake .. -DDOWNLOAD_JLINK=OFF -DDOWNLOAD_NRFUTIL=OFF -DCOMPILE_FOR_HOST=ON
		make $parallel_flag
		cd $board
		make $parallel_flag
		;;
	*)
		echo "Unknown option"
		;;
esac

