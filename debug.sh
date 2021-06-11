board=${1:? "usage: $0 board" }

cd ../bluenet/build
cd $board

echo "Run the following in three different shells"

echo "make uart_client"
echo "make debug_server"
echo "make debug_application"

echo ""
echo "Eventually:"
echo "make reset"
