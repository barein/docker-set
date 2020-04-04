USERID=$(shell id -u)
GROUPID=$(shell id -g)
USERNAME=$(shell whoami)

CONSOLE=php bin/console
EXECROOT=docker-compose exec php
EXEC=docker-compose exec -u $(USERID):$(GROUPID) php

.PHONY: start ## Launch containers creating current user in php container
start:
	USER_ID=$(USERID) GROUP_ID=$(GROUPID) DEVELOPER_NAME=$(USERNAME) docker-compose up -d

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
	$(EXEC) $(CONSOLE) cache:clear --no-warmup
	$(EXEC) $(CONSOLE) cache:warmup

.PHONY: cs-dump ## Dump php-cs-fixer errors
cs-dump:
	$(EXEC) vendor/bin/php-cs-fixer fix --dry-run -v

.PHONY: cs ## Fix php-cs-fixer errors
cs:
	$(EXEC) vendor/bin/php-cs-fixer fix -v

.PHONY: phpstan ## Run phpstan
phpstan:
	$(EXEC) vendor/bin/phpstan analyse src --level 7 -c phpstan.neon
