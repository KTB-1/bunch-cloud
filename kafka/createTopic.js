const { Kafka } = require('kafkajs');

const kafka = new Kafka({
  clientId: 'my-admin',
  brokers: ['192.166.1.91:19092']
});

const admin = kafka.admin();

const createTopic = async () => {
  await admin.connect();
  await admin.createTopics({
    topics: [{
      topic: 'test-topic',
      numPartitions: 3, // docker-compose.yaml에서 설정한 KAFKA_NUM_PARTITIONS와 일치
      replicationFactor: 1 // docker-compose.yaml에서 설정한 KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR와 일치
    }]
  });
  await admin.disconnect();
};

createTopic().catch(console.error);
