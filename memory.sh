#!/bin/sh

board=${1:? "usage: $0 board term" }
term=${2:? "usage: $0 board term" }

echo "Run the following commands"

params="--print-size --size-sort --debug-syms --demangle --radix=d"

echo "1. arm-none-eabi-nm $params crownstone.elf | grep $term"
echo "2. get overall size"

echo -n  "Make your choice [n]: "

read cmd

cd ../bluenet/build

# If you don't have jq, use either:
#  | paste -s d+ | bc
#  |  awk '{s+=$1} END {printf "%i\n",s}'

case $cmd in
	1)
		cd $board
		echo "../../tools/gcc_arm_none_eabi/bin/arm-none-eabi-nm $params crownstone.elf | grep -w 'T' | grep $term"
		../../tools/gcc_arm_none_eabi/bin/arm-none-eabi-nm $params crownstone.elf | grep -w 'T' | grep "$term"
		;;
	2)
		cd $board
		../../tools/gcc_arm_none_eabi/bin/arm-none-eabi-nm $params crownstone.elf | grep "$term" | grep -w 'T' | cut -f2- -d' ' | uniq | cut -f1 -d' ' | jq -s 'add'
		;;
	3)
		cd $board
		../../tools/gcc_arm_none_eabi/bin/arm-none-eabi-nm $params --line-numbers crownstone.elf | grep "$term"
		;;
	*)
		echo "Unknown option"
		;;
esac


