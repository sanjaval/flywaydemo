#!/bin/bash

 set -e

 echo "Downloading and installing spawnctl..."
 curl -sL https://run.spawn.cc/install | sh > /dev/null 2>&1
 export PATH=$HOME/.spawnctl/bin:$PATH
 echo "spawnctl successfully installed"
 
 databaseName="postgres"
 pagilaHost="rgba562s.instances.spawn.cc"
 pagilaPort="30072"
 pagilaUser="spawn_admin_YOsj"
 pagilaPassword="Kjqfw6KNc4trOD5S"

 docker pull postgres:12-alpine > /dev/null 2>&1
 docker pull flyway/flyway

 echo
 echo "Starting migration of database with flyway"

 docker run --rm -v sanjaval/flywaydemo/sql:/flyway/sql -v sanjaval/flywaydemo:/flyway/conf flyway/flyway migrate -url="jdbc:postgresql://$pagilaHost:$pagilaPort/$databaseName" -user=$pagilaUser -password=$pagilaPassword

 echo "Successfully migrated 'Pagila' database"
 echo
