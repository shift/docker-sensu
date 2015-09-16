all: build push

build:
	docker build -t ${DOCKER_USER}/sensu:latest .

push: build
	docker push ${DOCKER_USER}/sensu:latest

test: build
	docker run -i ${DOCKER_USER}/sensu:latest /bin/bash -l -c '/sensu/bin/sensu-server --version'
