DB_USERNAME ?= upperio_tests
DB_PASSWORD ?= upperio_secret

default:
	vagrant up --provision

services: mysql postgresql mongo

mongo: mongo-3.0

mysql: mysql-5.7

postgresql: postgresql-9.4

postgresql-9.4:
	docker build -t upper/postgresql-9.4 postgresql/9.4

postgresql-9.0:
	docker build -t upper/postgresql-9.0 postgresql/9.0

mysql-5.5:
	docker build -t upper/mysql-5.5 mysql/5.5

mysql-5.7:
	docker build -t upper/mysql-5.7 mysql/5.7

mongo-2.2:
	docker build -t upper/mongo-2.2 mongo/2.2

mongo-3.0:
	docker build -t upper/mongo-3.0 mongo/3.0

run: services
	docker run -e "POSTGRES_USER=$(DB_USERNAME)" -e "POSTGRES_PASSWORD=$(DB_PASSWORD)" -p 5432:5432 upper/postgresql-9.4 >> postgresql.log 2>&1 &
	docker run -e "MYSQL_ROOT_PASSWORD=$(DB_PASSWORD)" -p 3306:3306 upper/mysql-5.7 >> mysql.log 2>&1 &
	docker run -p 27017:27017 upper/mongo-3.0 >> mongo.log 2>&1 &
