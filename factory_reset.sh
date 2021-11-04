#!/bin/sh

board=${1:? "usage: $0 board" }

cd ../bluenet/build
cd $board

echo "Setup Crownstone"

echo "1. read out BLE address and write config file"
echo "2. factory reset"
echo "3. reset"

echo -n  "Make your choice [1-3]: "

read cmd

case $cmd in
	1)
		make write_config
		;;
	2)
		make factory_reset
		;;
	3)
		make reset
		;;
	*)
		echo "Unknown option"
		;;
esac
