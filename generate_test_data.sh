#!/bin/bash
for i in {1..8}
do
  docker exec -i mysql-debezium-project-mysql${i}-1 mysql -uuser${i} -ppass${i} db${i} << EOF
CREATE TABLE IF NOT EXISTS user_products (
    user_id VARCHAR(255),
    product_id VARCHAR(255),
    subscription_type VARCHAR(255),
    product_type VARCHAR(255),
    status VARCHAR(255),
    product_name VARCHAR(255),
    identifiers JSON,
    start_date DATETIME,
    sub_products JSON,
    descriptions JSON,
    end_date DATETIME,
    prices JSON,
    tags JSON,
    PRIMARY KEY (user_id, product_id)
);

INSERT INTO user_products (user_id, product_id, subscription_type, product_type, status, product_name, identifiers, start_date, descriptions, end_date, prices, tags)
VALUES (
    'user_${i}', 
    'prod_${i}', 
    'prepaid', 
    'mobile', 
    'active', 
    'Product_${i}', 
    JSON_ARRAY('333333', '444444'), 
    NOW(), 
    JSON_ARRAY(JSON_OBJECT('text', 'Description for Product_${i}', 'url', 'https://product${i}.com/', 'category', 'category${i}')), 
    NOW() + INTERVAL 1 YEAR, 
    JSON_ARRAY(
        JSON_OBJECT('description', 'Plan G', 'type', 'mensal', 'recurring_period', '30', 'amount', '79.99'), 
        JSON_OBJECT('description', 'Plan H', 'type', 'mensal', 'recurring_period', '30', 'amount', '89.99')
    ), 
    JSON_ARRAY('tag7', 'tag8')
);
EOF
  echo "Populated mysql${i} with test data"
done
