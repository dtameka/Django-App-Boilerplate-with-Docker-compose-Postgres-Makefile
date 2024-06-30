# Django Boilerplate with Docker Compose PostgreSQL, Makefile.

## Requirements

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [GNU Make](https://www.gnu.org/software/make/)

## Implemented Commands

### Make your application

* `make app` - up application and database
* `make app-logs` - follow the logs in app container
* `make app-down` - down application and all infrastructure

### Make for only storages

* `make storages` - up only storages. you should run your application locally for debugging/developing purposes
* `make storages-logs` - foolow the logs in storages containers
* `make storages-down` - down all storages

### Most Used Django Specific Commands

* `make migrations` - make migrations to models
* `make migrate` - apply all made migrations
* `make collectstatic` - collect static
* `make superuser` - create admin user
* `make db-logs` - follow the database logs in storage