board=${1:? "usage: $0 board" }

cd ../bluenet/build

cd $board

make write_config

make reset

make setup
