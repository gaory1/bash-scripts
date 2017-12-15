#!/bin/bash

. common.sh

vmid=$1

curl -v -H "X-Auth-Token: $token" -H "Content-Type: application/json" http://127.0.0.1:8774/v2/$tenant_id/servers/$vmid

