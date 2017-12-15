#!/bin/bash

cd $(dirname $0)
. ./aws_config.sh

id=$(cat ~/.local/etc/aws_id.txt)

aws ec2 stop-instances --instance-ids $id

pkill -f sslocal #stop sslocal if running

