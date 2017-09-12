#!/bin/bash

echo -e "\n# Initilizing Postgres  Database #"

PostgresUser="postgres"

if [[ ! -z $POSTGRESDBADDR_PORT_5432_TCP_ADDR ]]; then
        PostgresHost=$POSTGRESDBADDR_PORT_5432_TCP_ADDR
fi

if [[ ! -z $POSTGRESDBADDR_PORT_5432_TCP_PORT ]]; then
        PostgresPort=$POSTGRESDBADDR_PORT_5432_TCP_PORT
fi

if [[ ! -z $POSTGRESDBADDR_ENV_POSTGRES_PASSWORD ]]; then
        PostgresPassword=$POSTGRESDBADDR_ENV_POSTGRES_PASSWORD
fi

if [[ -z $PostgresHost ]] || [[ -z $PostgresPassword ]] || [[ -z $PostgresPort ]]; then
        echo -e "\n!!! Error, Could not get DB info, quit !!!"
        exit 1
fi

# start postgres docker container
# sudo docker run --name postgres -e POSTGRES_PASSWORD=oracle -p 5432:5432 -d postgres:latest

echo -e '  -> Executing sql ...'
# execute the sql (https://www.postgresql.org/docs/8.3/static/libpq-pgpass.html)
PGPASSWORD=$PostgresPassword psql -h $PostgresHost -p $PostgresPort -U $PostgresUser -f /pipeline/source/lib/db/postgres.sql
#echo -e '  -> Done .'
