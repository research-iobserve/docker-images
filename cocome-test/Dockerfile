FROM        reiner/glassfish

RUN         echo "192.168.48.244:/data/cocome/web	/data	nfs	 auto	0	0" >> /etc/fstab

EXPOSE      8080 4848 8181

WORKDIR     /usr/local/glassfish4

# verbose causes the process to remain in the foreground so that docker can track it
CMD asadmin start-domain --verbose cocome

