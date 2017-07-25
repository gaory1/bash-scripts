#!/bin/bash

prefix=http://127.0.0.1:11200
index=$1
type=$2

test -z "$type" && echo "usage: $0 <index> <type>" && exit 1

loop=true
while $loop
do
	loop=false
	curl -d '{"fields":[]}' $prefix/$index/$type/_search?size=20 |
		jq . |
		sed -n 's/^.*"_id": "\([0-9]*\)",/\1/p' |
		while read id
		do
			loop=true
			curl -XDELETE $prefix/$index/$type/$id
		done
done

