# Docker-set

A personnal docker-compose environment for symfony 4 apps.
Provides an nginx http server and a mariadb 10.4.12

## Getting Started
Create your symfony project in the apps/ directory.
At the root directory of this docker-set project, create a .env file based on .env.dist and change the `APP_NAME` var with your new app name.
If you don't intend to use Makefile commands to build the containers change also `USER_ID`, `GROUP_ID` and `USERNAME` env vars with your local user info (see `id` command).

Set doctrine.dbal.server_version to '10.4.12', in doctrine.yaml.
Add `DATABASE_URL` env var to the Sf4 .env.local file with "mysql://dev:dev123@db:3306/main_db"". Same for any other required env var.

Run `make build` and then `make start`.

Your app is available at localhost:80

## Built With

* [Docker and docker-compose](https://docs.docker.com/)

## Acknowledgments

* https://knplabs.com/fr/blog/how-to-dockerise-a-symfony-4-project
* https://github.com/api-platform/api-platform/blob/master/docker-compose.yml
* https://hub.docker.com/_/postgres
* https://github.com/bitnami/bitnami-docker-php-fpm
* https://github.com/bitnami/bitnami-docker-php-fpm/issues/109
