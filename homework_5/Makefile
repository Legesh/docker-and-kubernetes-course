COMPOSE_FILE := docker-compose.yml
SWARM_COMPOSE_FILE := docker-compose.swarm.yml
STACK_NAME := couple-games
BACKEND_SERVICE := backend
DB_SERVICE := db
DUMP_FILE := mysql_dump.sql

.PHONY: up down backend-bash dump-db build-images swarm-init stack-deploy stack-rm stack-services stack-ps stack-logs

up:
	docker compose -f $(COMPOSE_FILE) up --build -d

down:
	docker compose -f $(COMPOSE_FILE) down

backend-bash:
	docker compose -f $(COMPOSE_FILE) exec $(BACKEND_SERVICE) sh

dump-db:
	docker compose -f $(COMPOSE_FILE) exec -T $(DB_SERVICE) sh -c 'mysqldump -uroot -p"$$MYSQL_ROOT_PASSWORD" "$$MYSQL_DATABASE"' > $(DUMP_FILE)

build-images:
	docker build -f Dockerfile-backend -t couple-games-backend:local ..
	docker build -f Dockerfile-client -t couple-games-client:local ..

swarm-init:
	docker swarm init

stack-deploy: build-images
	docker stack deploy -c $(SWARM_COMPOSE_FILE) $(STACK_NAME)

stack-rm:
	docker stack rm $(STACK_NAME)

stack-services:
	docker stack services $(STACK_NAME)

stack-ps:
	docker stack ps $(STACK_NAME)

stack-logs:
	docker service logs -f $(STACK_NAME)_backend
