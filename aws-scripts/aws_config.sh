#!/bin/bash

export aws_key_name=id_rsa
export aws_image_id=ami-be4a24d9
export aws_security_group_ids=sg-acb8b2c9
export aws_instance_type=t2.nano

#export no_proxy=localhost,127.0.0.0/8,::1
#export http_proxy=http://127.0.0.1:8080/
#export https_proxy=http://127.0.0.1:8080/
#export NO_PROXY=$no_proxy
#export HTTPS_PROXY=$http_proxy
#export HTTP_PROXY=$https_proxy
if ip -o a | awk '{print $4}' | grep -F 10.15. >/dev/null
then
	export NO_PROXY=localhost,127.0.0.0/8,::1
	export http_proxy=http://10.199.75.12:8080/
	export https_proxy=http://10.199.75.12:8080/
	export HTTPS_PROXY=http://10.199.75.12:8080/
	export no_proxy=localhost,127.0.0.0/8,::1
	export HTTP_PROXY=http://10.199.75.12:8080/
fi
