USERID=$(shell id -u)
GROUPID=$(shell id -g)
USERNAME=$(shell whoami)

CONSOLE=php bin/console
EXECROOT=docker-compose exec -u 0:0 php
EXEC=docker-compose exec php


### DOCKER UTILITIES ####

## build containers creating current user in php container
build:
	USER_ID=$(USERID) GROUP_ID=$(GROUPID) USERNAME=$(USERNAME) docker-compose build

start:
	docker-compose up -d --remove-orphans
	$(EXECROOT) service supervisor start
	$(EXECROOT) ln -s /app/config/packages/dev/messenger_worker.conf /etc/supervisor/conf.d/
	$(EXECROOT) supervisorctl reread
	$(EXECROOT) supervisorctl update
	$(EXECROOT) supervisorctl start all

stop:
	docker-compose down

exec_root:
	$(EXECROOT) bash

exec:
	$(EXEC) bash


######## PROJECT UTILITIES ########

composer:
	$(EXEC) composer install --prefer-dist --no-progress --no-suggest --no-interaction --ignore-platform-reqs

## clear Symfony cache
cc:
	$(EXECROOT) rm -rf var/cache/*
	$(EXEC) $(CONSOLE) cache:clear


######## DATABASE ########

fixture:
	$(EXEC) $(CONSOLE) hautelook:fixture:load --no-interaction --purge-with-truncate --no-bundles

db-drop:
	$(EXEC) $(CONSOLE) doctrine:database:drop --force

db-create:
	$(EXEC) $(CONSOLE) doctrine:database:create

db-play-migrations:
	$(EXEC) $(CONSOLE) do:mi:mi -n

db-restore: db-drop db-create db-play-migrations fixture

######## CONTINUOUS INTEGRATION ########

## Dump php-cs-fixer errors
cs-dump:
	$(EXEC) vendor/bin/php-cs-fixer fix --dry-run -v

## Fix php-cs-fixer errors
cs:
	$(EXEC) vendor/bin/php-cs-fixer fix -v

## Run phpstan
stan:
	$(EXEC) vendor/bin/phpstan analyse src --level 7 -c phpstan.neon

unit-tests:
	$(EXEC) bin/phpunit --testsuite unit-tests

functional-tests:
	$(EXEC) bin/phpunit --testsuite functional-tests

tests: unit-tests functional-tests

ci: cs-dump stan tests