proxy:
	docker build -t cloud9-proxy .
	docker kill proxy
	docker run -d --name proxy --rm -p $(C9_PORT):80 -ti cloud9-proxy
