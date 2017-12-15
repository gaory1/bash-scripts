#!/bin/bash

cd $(dirname $0)
. ./aws_config.sh

tmp=/tmp/aws_status.txt

aws ec2 run-instances --count 1 --key-name $aws_key_name --image-id $aws_image_id \
--security-group-ids $aws_security_group_ids --instance-type $aws_instance_type \
--block-device-mappings "DeviceName=/dev/sda1,Ebs={VolumeSize=8,DeleteOnTermination=true,VolumeType=standard}" > $tmp
if test $? != 0
then
	echo "Failed to run-instances"
	exit 1
fi

id=$(sed -n 's/^\s*"InstanceId": "\([^"]*\)".*$/\1/p' $tmp)
echo "Instance %id created."

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

ip=$(sed -n '/PublicIp/s/^.*"\([0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\)".*$/\1/p' $tmp | head -n 1)

echo $id > ~/.local/etc/aws_id.txt
echo ip: $ip

