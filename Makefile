STORAGES_FILE = docker_compose/storages.yaml
APP_FILE = docker_compose/app.yaml
DB_CONTAINER = postgres-db
APP_CONTAINER = main-app
ENV_FILE = --env-file .env
DC = docker compose
EXEC = docker exec -it
LOGS = docker logs
MANAGE_PY = python manage.py


.PHONY: postgres
postgres:
	${EXEC} ${DB_CONTAINER} psql
	
.PHONY: storages
storages:
	$(DC) -f $(STORAGES_FILE) $(ENV_FILE) up -d

.PHONY: storages-down
storages-down:
	$(DC) -f $(STORAGES_FILE) down

.PHONY: storages-logs
storages-logs:
	$(LOGS) $(DB_CONTAINER) -f

.PHONY: db-logs
db-logs:
	${DC} -f ${STORAGES_FILE} logs -f

.PHONY: app
app:
	$(DC) -f $(APP_FILE) -f $(STORAGES_FILE) $(ENV) up -d

.PHONY: app-down
app-down:
	$(DC) -f $(APP_FILE) -f $(STORAGES_FILE) down

.PHONY: app-logs
app-logs:
	$(LOGS) $(APP_CONTAINER) -f

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