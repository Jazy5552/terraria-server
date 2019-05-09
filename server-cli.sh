#!/bin/sh

# This script is meant to facilitate sending individual
# commands to the server. You can view the commands by
#   docker logs CONTAINERID

# Alternatively (ex for creating a world for the first time),
# you can simply attach to the contianer's screen instance
# which is running the terraria server
#   docker exec CONTAINERID screen -r terraria

# USAGE ./server-cli.sh CONTAINERID INPUTTOSEND

container_id="$1"
shift
docker exec $container_id screen -S terraria -X stuff $@^M

