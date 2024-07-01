COMPOSE_FILE = docker-compose.yaml
DB_CONTAINER = postgres-db
APP_CONTAINER = main-app
ENV = --env-file .env
DC = docker compose
EXEC = docker exec -it
LOGS = docker logs
MANAGE_PY = python manage.py


######### Хранилище #########

.PHONY: postgres
postgres:
	${EXEC} ${DB_CONTAINER} psql
	
.PHONY: storages
storages:
	$(DC) $(ENV) up postgres -d 

.PHONY: storages-down
storages-down:
	$(DC) down

.PHONY: storages-down-volume
storages-down-volume:
	$(DC) down -v

.PHONY: storages-logs
storages-logs:
	$(LOGS) $(DB_CONTAINER) -f

.PHONY: storages-bash
storages-bash:
	${EXEC} ${DB_CONTAINER} bash

.PHONY: db-logs
db-logs:
	${DC} logs -f


######### Приложение #########

.PHONY: app
app:
	$(DC) $(ENV) up --build -d

.PHONY: app-down
app-down:
	$(DC) down

.PHONY: app-down-volume
app-down-volume:
	$(DC) down -v

.PHONY: app-bash
app-bash:
	${EXEC} ${APP_CONTAINER} sh

.PHONY: app-logs
app-logs:
	$(LOGS) $(APP_CONTAINER) -f


######### Дополнительные команды #########

.PHONY: migrations
migrations:
	${EXEC} ${APP_CONTAINER} ${MANAGE_PY} makemigrations

.PHONY: migrate
migrate:
	${EXEC} ${APP_CONTAINER} ${MANAGE_PY} migrate

.PHONY: superuser
superuser:
	${EXEC} ${APP_CONTAINER} ${MANAGE_PY} createsuperuser

.PHONY: collectstatic
collectstatic:
	${EXEC} ${APP_CONTAINER} ${MANAGE_PY} collectstatic