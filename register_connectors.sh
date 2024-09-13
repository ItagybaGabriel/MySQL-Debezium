#!/bin/bash
for i in {1..3}
do
  echo "Registrando conector para mysql${i}"
  curl -X POST -H "Content-Type: application/json" --data @mysql${i}-connector.json http://localhost:8083/connectors
  echo ""
done
