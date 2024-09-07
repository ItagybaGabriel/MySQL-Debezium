# MySQL-Debezium Project

Este projeto configura um ambiente de replicação de dados em tempo real usando MySQL e Debezium, ideal para cenários de Change Data Capture (CDC) e streaming de dados.

## Visão Geral

O projeto consiste em:
- 8 instâncias MySQL
- Kafka e Zookeeper para mensageria
- Debezium para captura de mudanças em tempo real
- Scripts de configuração e gerenciamento

## Pré-requisitos

- Docker e Docker Compose (fiz o download do Docker Desktop em [https://www.docker.com/]
- Git Bash (para Windows) ou Terminal (para Linux/Mac)
- curl (para testes de API)

## Estrutura do Projeto

```
mysql-debezium-project/
│
├── mysql_conf/
│   └── my.cnf
├── .env
├── docker-compose.yml
├── generate_connectors.sh
├── register_connectors.sh
├── generate_test_data.sh
├── grant_permissions.sh
└── clear_data_mysql.sh
```

## Configuração e Execução

1. **Clonar o repositório:**
   ```bash
   git clone https://github.com/ItagybaGabriel/MySQL-Debezium.git
   cd mysql-debezium-project
   ```

2. **Iniciar os containers:**
   ```bash
   docker-compose up -d
   ```

3. **Conceder permissões necessárias:**
   ```bash
   ./grant_permissions.sh
   ```

4. **Gerar configurações dos conectores:**
   ```bash
   ./generate_connectors.sh
   ```

5. **Registrar os conectores:**
   ```bash
   ./register_connectors.sh
   ```

6. **Gerar dados de teste (opcional):**
   ```bash
   ./generate_test_data.sh
   ```

## Verificação do Setup

1. **Verificar status dos containers:**
   ```bash
   docker-compose ps
   ```

2. **Listar tópicos Kafka:**
   ```bash
   docker exec -it mysql-debezium-project-kafka-1 kafka-topics --list --bootstrap-server kafka:9092
   ```

3. **Verificar status dos conectores:**
   ```bash
   curl -s http://localhost:8083/connectors
   ```

4. **Consumir mensagens de um tópico:**
   ```bash
   docker exec -it mysql-debezium-project-kafka-1 kafka-console-consumer --topic mysql1.db1.user_products --from-beginning --bootstrap-server kafka:9092 --max-messages 1
   ```

## Inserção de Dados de Teste

Para inserir dados em uma instância MySQL específica:

```bash
docker exec -it mysql-debezium-project-mysql1-1 mysql -uuser1 -ppass1 db1 -e "INSERT INTO user_products (user_id, product_id) VALUES ('test_user', 'test_product');"
```
