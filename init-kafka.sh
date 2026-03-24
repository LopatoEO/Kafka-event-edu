#!/bin/bash
set -ex   # -e: выход при ошибке, -x: показывать все команды

echo 'Kafka cluster setup start!'

# Ждём брокера с выводом сообщений
until kafka-topics.sh --bootstrap-server kafka-0:9092 --list 2>/dev/null; do
  echo "Waiting for Kafka broker..."
  sleep 2
done

echo "Kafka broker is ready. Creating topics..."

kafka-topics.sh --bootstrap-server kafka-0:9092 --create --topic events --partitions 3 --replication-factor 2 --if-not-exists
kafka-topics.sh --bootstrap-server kafka-0:9092 --create --topic dlq --partitions 3 --replication-factor 2 --if-not-exists

echo 'Kafka cluster setup complete!'