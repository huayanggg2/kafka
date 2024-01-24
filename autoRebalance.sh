#!/bin/bash

zkServer=$1
brokerIdList=$2
content=`sh /opt/bitnami/kafka/bin/kafka-reassign-partitions.sh --zookeeper $zkServer --topics-to-move-json-file /opt/bitnami/kafka/bin/topicMove.json --broker-list $brokerIdList --generate`
content=`echo $content | awk -F 'Proposed partition reassignment configuration' '{print $2}'`
echo $content > /opt/bitnami/kafka/bin/ressgintopic.json
sh /opt/bitnami/kafka/bin/kafka-reassign-partitions.sh --zookeeper $zkServer --reassignment-json-file /opt/bitnami/kafka/bin/ressgintopic.json --execute
echo "重新分配中。。。"
while true
do
    # 在这里编写你的代码
exec_num=`sh /opt/bitnami/kafka/bin/kafka-reassign-partitions.sh --zookeeper $zkServer --reassignment-json-file /opt/bitnami/kafka/bin/ressgintopic.json --verify|grep -v successfully|wc -l`
    # 使用条件判断来终止循环
    if [ $exec_num == 1 ]; then
        break
    fi
    # 可以使用sleep命令来控制循环的速度
    sleep 5
done
