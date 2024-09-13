#!/bin/bash

for i in {1..3}
do
  docker exec -i mysql-debezium-project-mysql${i}-1 mysql -uroot -p${MYSQL_ROOT_PASSWORD} << EOF
GRANT RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'user${i}'@'%';
FLUSH PRIVILEGES;
EOF
  echo "Granted permissions for mysql${i}"
done