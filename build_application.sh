board=${1:? "usage: $0 board" }

cd ../bluenet/build

cd $board
make -j6

echo "Note that we did not run cmake again!"
