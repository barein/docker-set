.PHONY: in_project install cache-clear

in_project:
	docker-compose exec php bash

install:
	docker-compose exec php composer install

cache-clear:
	docker-compose exec php bin/console c:c