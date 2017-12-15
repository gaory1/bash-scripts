#!/bin/bash

f=./.token

if test ! -e $f; then
    keystone token-get > $f
fi

expire=$(awk '/expires/{print $4}' .token)
expire=$(date -d "$expire" +%s)

if test $(date +%s) -ge $expire; then
    keystone token-get > $f
fi

token=$(awk '/ id /{print $4}' $f)
tenant_id=$(awk '/tenant_id/{print $4}' $f)

