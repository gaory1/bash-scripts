#!/bin/bash

# prevent multi instances of current script
exec 9>/var/run/lock/myscript.lck
flock -n 9 || exit 1

echo "running"
sleep 10

