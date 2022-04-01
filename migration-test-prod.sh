#!/bin/bash

 set -e

 echo "Downloading and installing spawnctl..."
 curl -sL https://run.spawn.cc/install | sh > /dev/null 2>&1
 export PATH=$HOME/.spawnctl/bin:$PATH
 echo "spawnctl successfully installed"

 docker pull postgres:12-alpine > /dev/null 2>&1
 docker pull flyway/flyway > /dev/null 2>&1

 echo
 echo "Starting migration of database with flyway"

 docker run --net=host --rm -v $PWD/sql:/flyway/sql flyway/flyway migrate -url="jdbc:postgresql://$pagilaHost:$pagilaPort/$databaseName" -user=$pagilaUser -password=$pagilaPassword

 echo "Successfully migrated 'Pagila' database"
 echo

 spawnctl delete data-container $pagilaContainerName --accessToken $SPAWNCTL_ACCESS_TOKEN -q

 echo "Successfully cleaned up the Spawn data container '$pagilaContainerName'"
