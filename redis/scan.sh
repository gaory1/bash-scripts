#!/bin/bash

host=$1
port=$2
pattern=$3
interval=$4

if test -z "$port"; then
    echo "usage: $0 <host> <port> [pattern] [sleep]" >&2
    exit 1
fi

cursor=0
f=$(mktemp /tmp/redis_scan_XXXXXX)

while true
do
    redis-cli -h $host -p $port scan $cursor match "$pattern" count 100 > $f
    cursor=$(head -n 1 < $f)

    if test "$action" = ""; then
       tail -n +2 $f
    fi

    test "$cursor" = 0 && break

    test -n "$interval" && sleep "$interval"
done

/bin/rm -f $f

