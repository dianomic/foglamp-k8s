#!/bin/sh
set -e

HOST=$POSTGRES_HOST
USERNAME=$POSTGRES_USER
PASSWORD=$POSTGRES_PASSWORD

NEXT_WAIT_TIME=0
MAX_TRIES=10
until [ $NEXT_WAIT_TIME -eq $MAX_TRIES ] || PGPASSWORD=$PASSWORD psql -h "$HOST" -U "$USERNAME" -c '\q'; do
    echo "Connecting Postgres: $HOST:5432..."
    NEXT_WAIT_TIME=$(expr $NEXT_WAIT_TIME + 1)
    sleep $NEXT_WAIT_TIME
done
if [ $NEXT_WAIT_TIME -lt $MAX_TRIES ]; then echo "Postgres is up with host $HOST:5432"; else echo "!!! ERROR: Postgres connection failed !!!"; fi

# DEBUG-statements:
# PGPASSWORD=fogman psql -U fogman -d fogman_users_db -h db -c "SELECT * FROM fogman_users.user;
# result=$(PGPASSWORD=$PASSWORD psql -U $USERNAME -d fogman_users_db -h db -c "SELECT * FROM fogman_users.user;")
# echo $result
exit 0

