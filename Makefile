.PHONY: start in_project install cache-clear

start:
	docker-compose up -d

in_project:
	docker-compose exec php bash

install:
	docker-compose exec php composer install

cache-clear:
	docker-compose exec php bin/console c:c