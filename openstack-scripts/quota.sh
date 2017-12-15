#!/bin/bash

. common.sh

echo Neutron
curl http://$controller:9696/v2.0/quotas/${tenant_id}.json -X GET -H "X-Auth-Token: $token" -H "Content-Type: application/json" -H "Accept: application/json" -H "User-Agent: python-neutronclient"

echo
