#!/bin/bash

# prevent multi instances of current script
exec {lock_fd}>/var/run/lock/myscript.lck
flock -n $lock_fd || exit 1

echo "running"
sleep 10

