#!/bin/bash

HOSTNAME=$1

cat $GLASSFISH_HOME/glassfish/domains/cocome/config/temp.kieker.monitoring.properties | sed "s/%HOSTNAME%/$HOSTNAME/g" > $GLASSFISH_HOME/glassfish/domains/cocome/config/kieker.monitoring.properties

echo "Send monitoring data to $HOSTNAME"

asadmin start-domain --verbose cocome

# end
