#!/bin/bash

for i in {1..8}
do
  curl -X POST -H "Content-Type: application/json" --data @mysql${i}-connector.json http://localhost:8083/connectors
  echo "Registered connector for mysql${i}"
done