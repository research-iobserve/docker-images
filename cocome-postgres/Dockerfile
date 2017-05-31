FROM postgres:9.5
MAINTAINER Reiner Jung <reiner.jung@email.uni-kiel.de>
COPY initialize-db.sql /docker-entrypoint-initdb.d

COPY monitoring-aware-entrypoint.sh /usr/local/bin/
RUN  chmod 555 /usr/local/bin/monitoring-aware-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/monitoring-aware-entrypoint.sh"]

EXPOSE 5432
CMD ["localhost"]


