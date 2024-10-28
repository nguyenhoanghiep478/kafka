# Sử dụng image chính thức của Kafka từ Confluent
FROM confluentinc/cp-kafka:latest

# Thiết lập các biến môi trường cho Kafka KRaft mode
ENV KAFKA_PROCESS_ROLES=broker,controller
ENV KAFKA_NODE_ID=1
ENV KAFKA_CONTROLLER_QUORUM_VOTERS=1@localhost:9093
ENV KAFKA_LISTENERS=PLAINTEXT://0.0.0.0:9092,CONTROLLER://0.0.0.0:9093
ENV KAFKA_LISTENER_SECURITY_PROTOCOL_MAP=PLAINTEXT:PLAINTEXT,CONTROLLER:PLAINTEXT
ENV KAFKA_LOG_DIRS=/var/lib/kafka/data
ENV KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1
ENV KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR=1
ENV KAFKA_TRANSACTION_STATE_LOG_MIN_ISR=1

# Tạo thư mục cho Kafka logs
RUN mkdir -p /var/lib/kafka/data

# Mở cổng cho Kafka broker và controller
EXPOSE 9092 9093

# Khởi chạy Kafka với cấu hình KRaft mode
CMD ["kafka-server-start.sh", "/etc/kafka/server.properties"]
