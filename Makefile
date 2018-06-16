supervisor:
	sudo yum install -y supervisor
	sudo cp etc/supervisord.conf /etc/supervisord.conf
	sudo chkconfig supervisord on
	sudo service supervisord restart

gpu:
	python functions/launch_gpu_instance.py
