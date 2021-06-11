#!/bin/sh

board=${1:? "usage: $0 board" }

cd ../bluenet/build
cd $board

echo "Run the following in three different shells"

echo "1. make uart_client"
echo "2. make debug_server"
echo "3. make debug_application"
echo "4. make reset (optionally)"
echo "5. make uart_binary_client (alternative for 1)"

echo -n  "Make your choice [1-5]: "

read cmd

case $cmd in
	1)
		make uart_client
		;;
	2)
		make debug_server
		;;
	3)
		make debug_application
		;;
	4)
		make reset
		;;
	5)
		make uart_binary_client
		;;
	*)
		echo "Unknown option"
		;;
esac

