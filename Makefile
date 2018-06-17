supervisor:
	sudo yum install -y supervisor
	sudo cp etc/supervisord.conf /etc/supervisord.conf
	sudo chkconfig supervisord on
	sudo service supervisord restart

gpu:
	python functions/launch_gpu_instance.py

clean:
	python functions/autostop.py

keypair: ~/.ssh/id_gateway

~/.ssh/id_gateway:
	sudo yum install -y jq
	aws ec2 create-key-pair --key-name gateway | jq -r '.KeyMaterial' > ~/.ssh/id_gateway
	chmod go-rwx ~/.ssh/id_gateway
