#!/bin/bash

board=${1:? "usage: $0 board" }

cd ../bluenet/build
cd $board

echo "Setup Crownstone"

echo "1. read out BLE address and write config file"
echo "2. reset"
echo "3. setup Crownstone through cs-util"
echo "4. all of the above"

echo -n  "Make your choice [1-4]: "

read cmd

case $cmd in
	1)
		make write_config
		;;
	2)
		make reset
		;;
	3)
		make setup
		;;
	4)
		make write_config
		make reset
		make setup
		;;
	*)
		echo "Unknown option"
		;;
esac
