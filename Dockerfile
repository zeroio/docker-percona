FROM ubuntu:14.04

ENV DB_USER=admin \
	DB_PASS=**Random** \
	CREATE_DB=**False** \
	REPLICATION_MASTER=**False** \
	REPLICATION_SLAVE=**False** \
	REPLICATION_USER=replica \
	REPLICATION_PASS=replica \
	REPLICATION_MASTER_NAME=DB \
	EXTRA_OPTS=

#Percona with tools
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 430BDF5C56E7C94E848EE60C1C4CBDCDCD2EFD2A && \
	echo "deb http://repo.percona.com/apt `lsb_release -cs` main" > /etc/apt/sources.list.d/percona.list && \
	apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -yq percona-server-server-5.7 percona-server-client-5.7 percona-toolkit percona-xtrabackup qpress pwgen && \
	rm -rf /var/lib/mysql/*

VOLUME ["/etc/mysql", "/var/lib/mysql", "/backups"]

COPY conf.d/* /etc/mysql/conf.d/
COPY bin/* /usr/bin/

RUN chmod +x /usr/bin/mysqld_init && \
	chmod +x /usr/bin/mysql_backup && \
	chmod 644 /etc/mysql/conf.d/* && \
	chmod 644 /etc/mysql/my.cnf

CMD ["mysqld_init"]

EXPOSE 3306
