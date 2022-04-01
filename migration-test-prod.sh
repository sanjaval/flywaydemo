#!/bin/bash

 set -e

 echo
 echo "Starting migration of database with flyway"

 docker run --net=host --rm -v $PWD/sql:/flyway/sql flyway/flyway migrate -url="jdbc:postgresql://rgba562s.instances.spawn.cc:30006/postgres" -user=spawn_admin_YOsj -password=m9lwOA7VeNLA0Qao

 echo "Successfully migrated database"
 echo
