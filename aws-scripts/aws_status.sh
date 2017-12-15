#!/bin/bash

cd $(dirname $0)
. ./aws_config.sh

id=$(cat ~/.local/etc/aws_id.txt)

aws ec2 describe-instances --instance-ids $id >/tmp/aws_status

grep -A 3 -e '"State": {' -e '"PublicIp"' /tmp/aws_status
