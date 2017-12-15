#!/bin/bash

. common.sh

vmid=$1
dest_host=$2

test -z "$dest_host" && echo "usage: $0 <vm uuid> <dest_host>" && exit

curl -v --data-binary "{\"os-migrateLive\": {\"host\": \"$dest_host\",\"block_migration\": true,\"disk_over_commit\": false}}" -H "X-Auth-Token: $token" -H "Content-Type: application/json" http://$controller:8774/v2/$tenant_id/servers/$vmid/action

