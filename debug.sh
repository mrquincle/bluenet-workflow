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
echo "6. make uart_raw_binary_client (alternative for 1)"
echo "7. make debug_bootloader (alternative for 3)"
echo "8. make extract_logs (required for 5 and 6)"

echo -n  "Make your choice [1-6]: "

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
	6)
		make uart_raw_binary_client
		;;
	7)
		make debug_bootloader
		;;
	8)
		make extract_logs
		;;
	*)
		echo "Unknown option"
		;;
esac

