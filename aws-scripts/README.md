# aws-scripts
Manipulate an AWS EC2 instance easily.

There scripts run on Ubuntu. Assuming AWS CLI tools installed and configured.

*aws_create.sh - Creates a new instance, shows its public ip, and stores the instance-id into file ~/.local/etc/aws_id.txt
*aws_terminate.sh - Destroy previously created instance.
*aws_start.sh - Start the instance, 
*aws_status.sh - View the status and public ip of the instance.
*aws_stop.sh - Stop the instance.

Each script calls a 'proxy_env' file, which is used only to setup http proxy environment variables. It looks like:
	export no_proxy=localhost,127.0.0.0/8,::1
	export http_proxy=http://127.0.0.1:8080/
	export https_proxy=http://127.0.0.1:8080/
	export NO_PROXY=$no_proxy
	export HTTPS_PROXY=$http_proxy
	export HTTP_PROXY=$https_proxy

