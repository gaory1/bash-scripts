#!/bin/bash

prefix=http://127.0.0.1:11200
index=$1
type=$2

test -z "$type" && echo "usage: $0 <index> <type>" && exit 1

tmp=$(mktemp /tmp/es_clear_XXXXXX)

while true
do
	loop=false
	curl -d '{"fields":[]}' $prefix/$index/$type/_search?size=20 |
		jq . |
		sed -n 's/^.*"_id": "\([0-9]*\)",/\1/p' > $tmp
	test -s $tmp || break
	while read id
	do
		curl -XDELETE $prefix/$index/$type/$id
	done < $tmp
done

/bin/rm $tmp
