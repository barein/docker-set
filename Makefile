.PHONY: start stop in_project install cache-clear

start:
	docker-compose up -d

stop:
	docker-compose down

in_project:
	docker-compose exec php bash

install:
	docker-compose exec php composer install

cache-clear:
	docker-compose exec php bin/console c:c