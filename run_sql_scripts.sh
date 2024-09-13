#!/bin/bash

# Carregar as variáveis de ambiente do arquivo .env
set -a
source .env
set +a

for i in {1..3}
do
  echo "Executando script SQL para mysql${i}"
  docker exec -i mysql${i} mysql -uroot -p${MYSQL_ROOT_PASSWORD} < ./sql_scripts/instance${i}_schema.sql
  echo "Criado esquema e populado mysql${i} com dados de teste"
done
