#!/bin/bash

mountpoint=$1
if test -z "$mountpoint"
then
	echo "usage: $0 <mount point>"
	exit 1
fi

mapped=$(df $mountpoint | tail -n 1 | awk '{print $1}')
name=$(basename $mapped)

loop=$(sudo cryptsetup status $name | awk '/device:/{print $2}')
sudo umount $mountpoint
sudo cryptsetup close $name
sudo losetup -d $loop

