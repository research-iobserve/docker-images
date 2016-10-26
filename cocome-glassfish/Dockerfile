FROM        java:8-jdk

ENV         JAVA_HOME         /usr/lib/jvm/java-8-openjdk-amd64
ENV         GLASSFISH_HOME    /usr/local/glassfish4
ENV         PATH              $PATH:$JAVA_HOME/bin:$GLASSFISH_HOME/bin

RUN         apt-get update && \
            apt-get install -y curl unzip zip inotify-tools && \
            rm -rf /var/lib/apt/lists/*

RUN         curl -L -o /tmp/glassfish-4.1.1.zip http://download.java.net/glassfish/4.1.1/release/glassfish-4.1.1.zip && \
            unzip /tmp/glassfish-4.1.1.zip -d /usr/local && \
            rm -f /tmp/glassfish-4.1.1.zip

RUN         echo "AS_ADMIN_PASSWORD=admin" > /tmp/pwfile && asadmin create-domain --user admin --passwordfile /tmp/pwfile cocome
RUN         asadmin start-domain cocome && \
            asadmin create-jvm-options --user admin --passwordfile /tmp/pwfile '-Dkieker.monitoring.configuration=${com.sun.aas.instanceRoot}/config/kieker.monitoring.properties' && \
            asadmin --host localhost --port 4848 --user admin --passwordfile /tmp/pwfile enable-secure-admin && \
            asadmin stop-domain cocome
COPY        kieker.monitoring.properties $GLASSFISH_HOME/glassfish/domains/cocome/config/
COPY        postgresql-9.4.1209.jar $GLASSFISH_HOME/glassfish/domains/cocome/lib/

RUN         echo "deb http://httpredir.debian.org/debian jessie contrib" >> /etc/apt/sources.list && \
            apt-get update && \
            apt-get install -y rpcbind nfs-common && \
            test -d /data || mkdir /data

EXPOSE      8080 4848 8181

WORKDIR     /usr/local/glassfish4

# verbose causes the process to remain in the foreground so that docker can track it
CMD asadmin start-domain --verbose cocome

