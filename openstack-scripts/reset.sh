#!/bin/bash

. common.sh

if test -n "$1"; then
    vmid=$1
fi

nova reset-state --active $vmid
nova stop $vmid
nova start $vmid

