#!/bin/bash

. common.sh

if test -n "$1"; then
    nova list --all-t --host "$1"
else
    nova list --all-t
fi
