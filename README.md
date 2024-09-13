# Projeto MySQL Debezium com Docker e Kafka

Este repositório contém um projeto que demonstra a captura de dados em tempo real de múltiplas instâncias MySQL usando Debezium e Kafka, tudo orquestrado com Docker Compose. O objetivo é simular um ambiente empresarial simplificado com três instâncias de MySQL, cada uma contendo diferentes esquemas e tabelas, e capturar as mudanças em tempo real para processamento posterior.

## Sumário
- [Visão Geral](#visão-geral)
- [Arquitetura do Projeto](#arquitetura-do-projeto)
- [Pré-requisitos](#pré-requisitos)
- [Instalação e Configuração](#instalação-e-configuração)
  1. [Clonar o Repositório](#1-clonar-o-repositório)
  2. [Configurar Variáveis de Ambiente](#2-configurar-variáveis-de-ambiente)
  3. [Iniciar os Contêineres Docker](#3-iniciar-os-contêineres-docker)
  4. [Executar os Scripts SQL](#4-executar-os-scripts-sql)
  5. [Criar e Registrar os Conectores Debezium](#5-criar-e-registrar-os-conectores-debezium)
  6. [Testar a Captura de Dados](#6-testar-a-captura-de-dados)

## Visão Geral

Este projeto configura um ambiente de múltiplas instâncias MySQL, cada uma com seu próprio esquema, e usa o Debezium para capturar mudanças nos bancos de dados em tempo real. As mudanças são publicadas no Kafka, permitindo que outros sistemas consumam e processem os dados.

## Arquitetura do Projeto

- **MySQL Instances**: Três instâncias separadas de MySQL (mysql1, mysql2, mysql3), cada uma com seu próprio banco de dados e esquema.
- **Debezium Connector**: Captura as mudanças nas instâncias MySQL e as publica no Kafka.
- **Apache Kafka**: Sistema de mensageria para transmissão dos eventos capturados.
- **Zookeeper**: Serviço necessário para o funcionamento do Kafka.
- **Docker Compose**: Orquestração de todos os serviços acima.

## Pré-requisitos

- **Docker Desktop**: Certifique-se de que o Docker está instalado e em execução em sua máquina. [Instalar Docker Desktop](https://www.docker.com/products/docker-desktop)
- **Git**: Para clonar o repositório. [Instalar Git](https://git-scm.com/)
- **Git Bash (Windows)**: Recomendado para executar scripts bash no Windows.
- **Recursos de Sistema**: Recomenda-se alocar pelo menos 4 CPUs e 8GB de RAM para o Docker Desktop.

## Instalação e Configuração

### 1. Clonar o Repositório

Abra um terminal e clone o repositório:

```bash
git clone https://github.com/seu_usuario/seu_repositorio.git
```

Substitua `seu_usuario` e `seu_repositorio` pela URL correta do repositório.

### 2. Configurar Variáveis de Ambiente

No diretório raiz do projeto, crie um arquivo `.env` com as seguintes variáveis:

```env
MYSQL_ROOT_PASSWORD=SuaSenhaRootAqui
DEBEZIUM_VERSION=1.9
```

- `MYSQL_ROOT_PASSWORD`: Defina uma senha segura para o usuário root do MySQL.
- `DEBEZIUM_VERSION`: Versão do Debezium a ser utilizada.

### 3. Iniciar os Contêineres Docker

No terminal, navegue até o diretório do projeto e execute:

```bash
docker-compose up -d
```

Isso iniciará todos os serviços definidos no `docker-compose.yml` em segundo plano.

### 4. Executar os Scripts SQL

#### 4.1. Garantir Permissões de Execução

No Windows, recomenda-se o uso do Git Bash para executar scripts bash. Abra o Git Bash no diretório do projeto.

#### 4.2. Executar o Script de Configuração do Banco de Dados

Execute o script `run_sql_scripts.sh` para criar os bancos de dados, tabelas e inserir dados de teste:

```bash
./run_sql_scripts.sh
```

Este script executa os arquivos SQL em `sql_scripts/` para cada instância MySQL.

### 5. Criar e Registrar os Conectores Debezium

#### 5.1. Criar os Arquivos de Configuração dos Conectores

Execute o script `create_connectors.sh` para gerar os arquivos JSON de configuração:

```bash
./create_connectors.sh
```

#### 5.2. Registrar os Conectores no Debezium

Execute o script `register_connectors.sh` para registrar os conectores no Debezium:

```bash
./register_connectors.sh
```

### 6. Testar a Captura de Dados

#### 6.1. Inserir Dados em uma Instância MySQL

Conecte-se a uma das instâncias MySQL (por exemplo, `mysql1`):

```bash
docker exec -it mysql1 mysql -uuser1 -ppass1 db1
```

No prompt do MySQL, insira um novo registro:

```sql
INSERT INTO users (username, password_hash, email) 
VALUES ('novousuario', 'senha_hash', 'novousuario@example.com');
EXIT;
```

#### 6.2. Consumir Mensagens do Kafka

Conecte-se ao contêiner do Kafka:

```bash
docker exec -it kafka /bin/bash
```

Dentro do contêiner, consuma mensagens do tópico correspondente:

```bash
kafka-console-consumer --bootstrap-server kafka:9092 --topic mysql1.db1.users --from-beginning
```

Você deve ver as mensagens correspondentes às mudanças no banco de dados.
