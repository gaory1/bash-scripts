#!/bin/bash

logfile=./mylog

log()
{
    echo "$(date '+%Y-%m-%d %H:%M:%S') $*" >>$logfile
}


log begin running
sleep 3
log end running

