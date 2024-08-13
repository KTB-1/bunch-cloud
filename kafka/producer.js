// producer.js

const { Kafka } = require('kafkajs');

const kafka = new Kafka({
  clientId: 'my-producer',
  brokers: ['192.166.1.91:19092'] // Kafka broker의 IP 주소와 포트
});

const producer = kafka.producer();

const run = async () => {
  await producer.connect();
  await producer.send({
    topic: 'test-topic',
    messages: [
      { value: 'Hello KafkaJS user!' },
    ],
  });

  await producer.disconnect();
};

run().catch(console.error);