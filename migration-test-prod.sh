#!/bin/bash

set -e

docker pull postgres:12-alpine > /dev/null 2>&1
docker pull flyway/flyway > /dev/null 2>&1
 
echo
echo "Starting migration of database with flyway"

docker run --net=host --rm -v $PWD/sql:/flyway/sql flyway/flyway migrate -url="jdbc:postgresql://rgba562s.instances.spawn.cc:30072/postgres" -user=spawn_admin_YOsj -password=Kjqfw6KNc4trOD5S

echo "Successfully migrated database"
echo
