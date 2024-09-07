for i in {1..8}
do
  cat << EOF > mysql${i}-connector.json
{
  "name": "mysql-connector-${i}",
  "config": {
    "connector.class": "io.debezium.connector.mysql.MySqlConnector",
    "database.hostname": "mysql${i}",
    "database.port": "3306",
    "database.user": "user${i}",
    "database.password": "pass${i}",
    "database.server.id": "${i}",
    "database.server.name": "mysql${i}",
    "database.include.list": "db${i}",
    "database.history.kafka.bootstrap.servers": "kafka:9092",
    "database.history.kafka.topic": "schema-changes.mysql${i}",
    "include.schema.changes": "true",
    "topic.prefix": "mysql${i}",
    "schema.history.internal": "io.debezium.storage.kafka.history.KafkaSchemaHistory",
    "schema.history.internal.kafka.bootstrap.servers": "kafka:9092",
    "schema.history.internal.kafka.topic": "schema-changes.mysql${i}"
  }
}
EOF
done
