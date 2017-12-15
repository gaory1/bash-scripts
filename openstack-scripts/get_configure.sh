#!/bin/bash

. common.sh

curl -v -H "X-Auth-Token: $token" -H "Content-Type: application/json" -d '{"/etc/nova/nova.conf":{"cpu_allocation_ratio":""}}' http://$controller:8774/v2/$tenant_id/misc/get_configure
