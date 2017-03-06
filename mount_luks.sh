#!/bin/bash

img=$1
mountpoint=$2

if test -z "$mountpoint"
then
	echo "usage: $0 <img> <mount point>"
	exit 1
fi

name=$(basename $img)
if ! loop=$(sudo losetup -f --show $img)
then
	exit 1
fi

if sudo cryptsetup open $loop $name
then
	sudo mount /dev/mapper/$name $mountpoint
else
	sudo losetup -d $loop
fi
