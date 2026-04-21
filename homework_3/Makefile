COMPOSE_FILE := docker-compose.yml
BACKEND_SERVICE := backend
DB_SERVICE := db
DUMP_FILE := mysql_dump.sql

.PHONY: up down backend-bash dump-db

up:
	docker compose -f $(COMPOSE_FILE) up --build -d

down:
	docker compose -f $(COMPOSE_FILE) down

backend-bash:
	docker compose -f $(COMPOSE_FILE) exec $(BACKEND_SERVICE) sh

dump-db:
	docker compose -f $(COMPOSE_FILE) exec -T $(DB_SERVICE) sh -c 'mysqldump -uroot -p"$$MYSQL_ROOT_PASSWORD" "$$MYSQL_DATABASE"' > $(DUMP_FILE)
