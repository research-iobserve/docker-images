#!/bin/bash

ASADMIN="$HOME/glassfish4/glassfish/bin/asadmin"

if [ "$1" == "start" ] ; then
	# run docker images
	echo "Starting container ..."

	POSTGRES_CID=`docker run -d -t reiner/postgres-cocome:v1`
	WEB_NODE_CID=`docker run -d -t reiner/cocome-web`
	STORE_NODE_CID=`docker run -d -t reiner/glassfish`
	ENT_NODE_CID=`docker run -d -t reiner/glassfish`
	ADAPTER_NODE_CID=`docker run -d -t reiner/glassfish`

	# get ips
	echo "Acquiring ip addresses ..."

	POSTGRES_IP=`docker inspect "$POSTGRES_CID" | grep IPAddress | tail -1 | awk '{ print $2}' | sed 's/^\"\(.*\)\",$/\1/g'`
	WEB_NODE_IP=`docker inspect "$WEB_NODE_CID" | grep IPAddress | tail -1 | awk '{ print $2}' | sed 's/^\"\(.*\)\",$/\1/g'`
	STORE_NODE_IP=`docker inspect "$STORE_NODE_CID" | grep IPAddress | tail -1 | awk '{ print $2}' | sed 's/^\"\(.*\)\",$/\1/g'`
	ENT_NODE_IP=`docker inspect "$ENT_NODE_CID" | grep IPAddress | tail -1 | awk '{ print $2}' | sed 's/^\"\(.*\)\",$/\1/g'`
	ADAPTER_NODE_IP=`docker inspect "$ADAPTER_NODE_CID" | grep IPAddress | tail -1 | awk '{ print $2}' | sed 's/^\"\(.*\)\",$/\1/g'`

	# setup build settings
	echo "Setup maven build (not really) ..."
	echo "adapter node    $ADAPTER_NODE_IP"
	echo "web node        $WEB_NODE_IP"
	echo "store node      $STORE_NODE_IP"
	echo "enterprise node $ENT_NODE_IP"

	# connect nodes
	echo "Configuring adapter node $ADAPTER_NODE_IP ..."

	echo "AS_ADMIN_PASSWORD=admin" > pwfile

	while ! $ASADMIN --user admin --passwordfile pwfile --host $ADAPTER_NODE_IP list-applications >& /dev/null ; do
		echo "Adapter not up and running. Waiting 5 seconds ..."
		sleep 5
	done

	$ASADMIN --user admin --passwordfile pwfile --host $ADAPTER_NODE_IP --interactive=false \
		create-jdbc-connection-pool \
		--datasourceclassname org.postgresql.ds.PGSimpleDataSource \
		--restype javax.sql.DataSource --property user=cocome:password=dbuser:servername=$POSTGRES_IP:databasename=cocomedb PostgresPool

	$ASADMIN --user admin --passwordfile pwfile --host $ADAPTER_NODE_IP --interactive=false \
		create-jdbc-resource --connectionpoolid PostgresPool jdbc/CoCoMEDB

	echo "Done."
elif [ "$1" == "stop" ] ; then
	echo "Stopping container ..."
	for I in `docker ps -q` ; do
		echo "Stopping $I"
		docker stop $I
	done

	echo "Done."
fi

# end
