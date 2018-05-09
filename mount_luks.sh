#!/bin/bash

img=$1
mountpoint=$2
keyfile=$3

if test -z "$mountpoint"
then
	echo "usage: $0 <img> <mount point> [key file]"
	exit 1
fi

name=$(basename $img)
if ! loop=$(sudo losetup -f --show $img)
then
	exit 1
fi

if test -z "$keyfile"
then
	sudo cryptsetup open $loop $name
else
	sudo cryptsetup open --key-file $keyfile $loop $name
fi

if test $? != 0
then
	sudo losetup -d $loop
fi
