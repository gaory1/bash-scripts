#!/bin/bash

name=$1

id=$(su - idb -c "idbsql -Alt virtual_db -c \"select id from vminfo where vmname='$name'\"")
echo "id            $id"

backups=$(su - idb -c "idbsql -Alt virtual_db -c \"select imgurl from vmbackupinfo where id='$id'\"" | awk -F / '{print $NF}')
echo "backup images $backups"

hostname=$(nova show $id | awk '/OS-EXT-SRV-ATTR:host/{print $4}')
hostip=$(cat /etc/hosts | awk "\$2==\"$hostname\"{print \$1}")
echo "host          $hostip"

instance=$(nova show $id | awk '/OS-EXT-SRV-ATTR:instance_name/{print $4}')
echo "instance_name $instance"

spice_port=$(ssh $hostip "ps -ef | grep $instance | sed -n \"s/^.*-spice port=\([0-9]*\),.*$/\1/p\"")
echo "spice_port    $spice_port"

