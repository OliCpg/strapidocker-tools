# strapidocker-tools
Tools to create / backup and restore a [strapi docker container](https://github.com/strapi/strapi-docker).

Usecase: local preparation of an API using [strapi](https://strapi.io/) in a docker environement where devs need to quickly test & iterate or just move copies of the project around.

## New project
Use the docker-compose.yml file to setup the needed containers. This version uses a mysql database but you can change this to any database system supported by strapi.

In the directory where you put the files, just lauch in the terminal:
```
docker-compose up -d
```

## Backuping
Backuping will produce a zip file named using the date and time of the local machine. ** Do not rename the files **

To backup the full strapi project's files and db datas, type:
```
./strapi-backup.sh
```

## Restoring
Restoring will delete current containers (*strapi* and *strapi_db*) if present, regenerate new containers and inject the files and db datas of the backup.

To restore a file, just type:
````./strapi-restore name-of-the-file.tar.gz```
