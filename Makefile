USERID=$(shell id -u)
GROUPID=$(shell id -g)
USERNAME=$(shell whoami)

CONSOLE=php bin/console
EXECROOT=docker-compose exec -u 0:0 php
EXEC=docker-compose exec php

.PHONY: build ## buil containers creating current user in php container
build:
	USER_ID=$(USERID) GROUP_ID=$(GROUPID) USERNAME=$(USERNAME) docker-compose build

.PHONY: start
start:
	docker-compose up -d

.PHONY: stop
stop:
	docker-compose down

.PHONY: exec_root
exec_root:
	$(EXECROOT) bash

.PHONY: exec
exec:
	$(EXEC) bash

.PHONY: install
install:
	$(EXEC) composer install

.PHONY: cc ## clear Symfony cache and warm it up
cc:
	$(EXECROOT) rm -rf var/cache/*
	$(EXEC) $(CONSOLE) cache:clear

.PHONY: cs-dump ## Dump php-cs-fixer errors
cs-dump:
	$(EXEC) vendor/bin/php-cs-fixer fix --dry-run -v

.PHONY: cs ## Fix php-cs-fixer errors
cs:
	$(EXEC) vendor/bin/php-cs-fixer fix -v

.PHONY: phpstan ## Run phpstan
phpstan:
	$(EXEC) vendor/bin/phpstan analyse src --level 7 -c phpstan.neon

.PHONY: ci
ci: cs-dump phpstan