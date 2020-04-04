# Docker-set

A personnal docker-compose environment for symfony 4 apps.
Provides an nginx http server and a mysql 5.6 database.

## Getting Started
Create your symfony project in the apps/ directory.
At the root directory of this docker-set project, create a .env file based on .env.dist and change the APP_NAME var with your new app name.

Set doctrine.dbal.server_version to 'mariadb-10.4.12', in doctrine.yaml.
Add `DATABASE_URL=mysql://dev:dev123@db:3306/main_db` to the Sf4 .env file.

Run `make start`

Your app is available at localhost:80

## Built With

* [Docker and docker-compose](https://docs.docker.com/)

## Acknowledgments

* https://knplabs.com/fr/blog/how-to-dockerise-a-symfony-4-project
