#Docker Percona
Base Docker image to run Percona Server and backup with Xtrabackup.

User and password
-----------------
A new user `admin` with all privileges will be created at the first time the container run with a random password. To find out what is it, check the logs for the following line `Creating user [admin] with [gfEdkVrA1U1g] password`. `gfEdkVrA1U1g` is the password in this case.

`root` is also can be used with empty password but only within the container (using `docker exec -it <containerid> /bin/bash`).

Instead of using `admin` and random password, we can set `$DB_USER` and `$DB_PASS` environment variables to override

Database creation
-----------------
You also can create a database during first startup by specify `CREATE_DB` environment variable to the name of the database

Initial schema and data
-----------------
You also can run SQL files during first startup by specify `INIT_SQL` environment variable to the parent directory path of all the SQL script files

Start server with extra options
-------------------
To start the MySQL (Percona) daemon with extra options, set the `EXTRA_OPTS` environment variable to a non empty value

Replication support
-------------------
To start the server as master node, set the `REPLICATION_MASTER` environment variable to `True`. 
To start the server as a slave node, set the `REPLICATION_SLAVE` environment variable to `True` and you need to link the container to the master node so the initial script can extract the master host name and port. You also need to change `REPLICATION_MASTER_NAME` to the right name (alias) of the linked container.

Backup
-------------------
There is a script named `mysql_backup` that will run `innobackupex` to do full backup to `/backups` directory as compressed `yyyymmdd.tar.gz` files.
