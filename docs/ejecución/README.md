# Comandos para ejecutar Snort y Suricata en modo PCAP
El comando que emplear para ejecutar Suricata en modo offline pcap es el que se muestra a continuación
```shell
$ suricata -c /etc/suricata/suricata.yaml -r /ruta/al/fichero/pcap
```

Por otro lado, para ejecutar Snort en modo pcap, el comando a utilizar es el siguiente
```shell
$ sudo snort -c snort.conf -r /ruta/al/fichero/pcap
```
El formato de salida de las alertas de Snort es unified2 y este es transformado a formato JSON para realizar la correlación de eventos, a través del programa de Python u2json. Los comandos que hay que ejecutar para realizar dicha transformación son los siguientes
```shell
$ cd ~/py-idstools-master/bin
$ sudo python idstools-u2json -C /etc/snort/etc/classification.config -S /etc/snort/etc/sid-msg.map -G /etc/snort/gen-msg.map /var/log/snort/unified2.log.xxxx --output /ruta/al/fichero/snort/en/formato/json
```
en donde los valores de xxxx dependerán del nombre específico del fichero en formato unified2 que se tenga.
