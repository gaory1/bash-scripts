#!/bin/bash

if test $(whoami) != root
then
	exec sudo $0 $@
fi

echo 'xxx'
