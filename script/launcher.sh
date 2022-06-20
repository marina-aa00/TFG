#!/bin/bash
# ./launcher.sh start  ./launcher.sh stop
source ./variables.txt

function checkerEs(){
status_code=""
while [ -z $status_code ]
do 
  status_code=$(curl -kv http://192.168.56.2:9200/ 2>&1 | grep -i 'HTTP/1.1 ' | awk '{print $3}'| sed -e 's/^[ \t]*//')
  sleep 1
done
}

function checkerKib(){
status_code=""
while [ -z $status_code ]
do 
  status_code=$(curl -kv http://192.168.56.2:5601/ 2>&1 | grep -i 'HTTP/1.1 ' | awk '{print $3}'| sed -e 's/^[ \t]*//')
  sleep 3
done
}

function starter(){
    sudo systemctl start logstash
    echo "1.El servicio de logstash se ha iniciado"
    sudo systemctl start filebeat
    echo "2.El servicio de filebeat se ha iniciado"
    bash $ES_ELASTIC_PATH/elasticsearch -d > /dev/null 2>&1
    echo "3.Elasticsearch se está arrancando, por favor espere"
    checkerEs
    echo "4.Elasticsearch se ha arrancado"
    nohup bash $ES_KIB_PATH/kibana > /dev/null 2>&1&
    echo "5.Kibana se está arrancando, por favor espere"
    checkerKib
    echo "6.Todos los servicios se han levantado correctamente"   
}

function stop(){
    sudo systemctl stop logstash
    echo "1.El servicio de Logstash se ha detenido"
    sudo systemctl stop filebeat
    echo "2.El servicio de Filebeat se ha detenido"
    pid_es=$(pgrep -f Elasticsearch)
    pid_kb=$(pgrep -f '.*node/bin/node.*src/cli')
    kill -9 $pid_es && kill -9 $pid_kb
    echo "3.Elasticsearch y Kibana se han detenido"
}

if [ $1 == "start" ]
then 
 starter
elif [ $1 == "stop" ]
then 
 stop
fi
