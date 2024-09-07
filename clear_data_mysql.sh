for i in {1..8}; do
  docker exec -i mysql-debezium-project-mysql${i}-1 mysql -uuser${i} -ppass${i} -e "DROP DATABASE db${i}; CREATE DATABASE db${i};"
  echo "Cleared content for mysql${i}"
done
