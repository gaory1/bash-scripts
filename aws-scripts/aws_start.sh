#!/bin/bash

cd $(dirname $0)
. ./aws_config.sh

tmp=/tmp/aws_status
id=$(cat ~/.local/etc/aws_id.txt)

aws ec2 start-instances --instance-ids $id

while sleep 1
do
	aws ec2 describe-instances --instance-ids $id >$tmp
	state=$(grep -A 3 -e '"State": {' $tmp | awk '/Name/{print $2}')
	echo $state
	if test "$state" == \"running\"
	then
		break
	fi
done

if test -x ~/.local/bin/sslocal #(re)start sslocal
then
	ip=$(sed -n '/PublicIp/s/^.*"\([0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\)".*$/\1/p' $tmp | head -n 1)
	~/.local/bin/sslocal $ip
fi

