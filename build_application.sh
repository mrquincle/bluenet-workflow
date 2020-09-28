board=${1:? "usage: $0 board" }

cd ../bluenet/build

cd $board
make -j4
