#!/bin/bash

exec 1>>./mylog
exec 2>&1 

echo "normal output"
echo "error output" >&2

