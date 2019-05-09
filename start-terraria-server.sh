#!/bin/sh
exit_proc() {
  echo "Attemping to exit gracefully..."
  screen -S terraria -X stuff exit^M
  trap - SIGTERM SIGINT # Dont trap consequent signals
  wait
}

echo "Setting trap"
trap exit_proc SIGTERM SIGINT

echo "Starting server in background..."
touch /terraria.log
screen -L -Logfile "/terraria.log" -dmS terraria mono /terraria/TerrariaServer.exe -worldpath /terraria/worlds

if [ $DEFAULT_WORLD != 0 ]
then
  {
    sleep 10; screen -S terraria -X stuff $DEFAULT_WORLD^M
    sleep 3; screen -S terraria -X stuff ^M
    sleep 3; screen -S terraria -X stuff ^M
    sleep 3; screen -S terraria -X stuff ^M
    sleep 3; screen -S terraria -X stuff ^M
  } &
fi

echo "Listening for output"
tail -f /terraria.log &
wait $!
#screen -r terraria

