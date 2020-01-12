# Docker-set

A personnal docker-compose environment for symfony 4 apps.
Provides an nginx http server and a mysql 8 database.

## Getting Started
Create a directory called apps/.
Create your symfony project in the apps/ directory.
Create the directory docker/mysql/data/
Create a .env file based on .env.dist and change the APP_NAME var with your new app name.

Run docker-compose up -d

Your app is available at localhost:80

## Built With

* [Docker and docker-compose](https://docs.docker.com/)

## Acknowledgments

* https://knplabs.com/fr/blog/how-to-dockerise-a-symfony-4-project
