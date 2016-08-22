DB_USERNAME ?= upperio_tests
DB_PASSWORD ?= upperio_secret

default:
	vagrant up --provision

services: mysql postgresql mongo

mongo: mongo-3.0

mysql: mysql-5.7

postgresql: postgresql-9.4

postgresql-9.4:
	docker pull postgres:9.4

postgresql-9.0:
	docker pull postgres:9.0

mysql-5.5:
	docker pull mysql:5.5

mysql-5.7:
	docker pull mysql:5.7

mongo-2.2:
	docker pull mongo:3.2

mongo-3.0:
	docker pull mongo:3.0

run: services
	(docker rm postgresql || exit 0) && \
	(docker rm mysql || exit 0) && \
	(docker rm mongo || exit 0)
	docker run -e "POSTGRES_USER=$(DB_USERNAME)" -e "POSTGRES_PASSWORD=$(DB_PASSWORD)" -p 0.0.0.0:5432:5432 --name postgresql postgres:9.4 >> postgresql.log 2>&1 &
	docker run -e "MYSQL_USER=$(DB_USERNAME)" -e "MYSQL_PASSWORD=$(DB_PASSWORD)" -e "MYSQL_ALLOW_EMPTY_PASSWORD=1" -e "MYSQL_DATABASE=$(DB_USERNAME)" -p 0.0.0.0:3306:3306 --name mysql mysql:5.7 >> mysql.log 2>&1 &
	docker run -e "MONGO_USER=$(DB_USERNAME)" -e "MONGO_PASSWORD=$(DB_PASSWORD)" -e "MONGO_DATABASE=$(DB_USERNAME)" -p 0.0.0.0:27017:27017 --name mongo mongo:3.0 >> mongo.log 2>&1 &
