#!/bin/bash

expr=$1
if test -z "$expr"; then
    echo "example: "
    echo "$0 '<0.8'"
    echo "$0 '>=1'"
    exit 1
fi

while sleep 3; do
   load=$(uptime | awk -F 'load average: ' '{print $2}' | awk -F ', ' '{print $1}')
   flag=$(python -c "print $load $expr")
   echo $load $flag
   if test "$flag" = True; then
       exit 0
   fi
done

