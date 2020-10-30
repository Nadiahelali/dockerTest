#################
## Production ##
################
start:
	docker container start db api
build:
	./boot.sh
stop:
	docker container stop api db
destroy: stop
	docker network rm restless-api;
	docker container rm api db;
	docker image rm node-api;
