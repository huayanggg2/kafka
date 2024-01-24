#!/bin/bash

zkServer=$1
topicArr=`sh /opt/bitnami/kafka/bin/kafka-topics.sh  --zookeeper $zkServer --list`
topictext=''
symbol='"'
for topic in ${topicArr[@]}
do
  topictext=$topictext','{$symbol'topic'$symbol:$symbol$topic$symbol}
done
assigntext='{"topics":['${topictext:1}'],"version":1}'
echo $assigntext >/opt/bitnami/kafka/bin/topicMove.json
