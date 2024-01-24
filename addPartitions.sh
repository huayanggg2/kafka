#!/bin/bash

zkServer=zk-client-clickhouse:2181/kafka
topicArr=`sh /opt/bitnami/kafka/bin/kafka-topics.sh  --zookeeper $zkServer --list|grep -v '__consumer_offsets'`
partitions=$1
for topic in ${topicArr[@]}
do
  sh /opt/bitnami/kafka/bin/kafka-topics.sh --zookeeper $zkServer --topic $topic --alter --partitions $partitions
  if [ $? -ne 0 ];then
    exit 1
  fi
done
