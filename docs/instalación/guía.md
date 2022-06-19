# Guía de instalación de los elementos necesarios para el despliegue del sistema
## Instalación de Logstash y Filebeat
1.	Primero, se importa la clave PGP de Elastic introduciendo en la consola el comando : 
    ```shell
    
    $ wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - 
    
    
      ```

    el cual debería devolver por consola como respuesta  OK. 

2.	Luego, se instala el paquete apt-transport-https a través del comando: 
     ```shell

    $ sudo apt-get install apt-transport-https
    
    
       ```

3.	Después, se añade el repositorio de Elastic a la lista de repositorios del sistema con el comando: 
     ```shell

    $ echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee –a /etc/apt/sources.list.d/elastic-7.x.list
    
    
       ```

4.	Tras esto último, se instala Logstash introduciendo el comando: 
     ```shell

    $ sudo apt-get install logstash
    
    
       ```

5.	Una vez instalado Logstash, se arranca el servicio: 
     ```shell

    $ sudo systemctl start logstash
    
    
       ```

    y se habilita a través de 
     ```shell

    $ sudo systemctl enable logstash
    
    
       ```

6.	Para comprobar el estado en el que se encuentra el servicio, se ejecuta el siguiente comando:
     ```shell

    $ sudo systemctl status logstash
    
    
       ```

    el cual debería devolver como respuesta active (running) si se han seguido todos los pasos descritos anteriormente.

7.	Por último, para la instalación de Logstash se deben instalar los plugins logstash-filter-prune y logstash-filter-uuid, lo cual se realiza a través de los siguientes comandos: 
     ```shell

    $ sudo bin/logstash-plugin install logstash-filter-prune

    $ sudo bin/logstash-plugin install logstash-filter-uuid
    
    
       ```

8.	Del mismo modo, para instalar Filebeat se ejecuta el comando: 
     ```shell

    $ sudo apt-get install filebeat
    
    
       ```

9.	Finalmente, una vez instalado Filebeat, se arranca y habilita el servicio utilizando para ello los comandos: 
     ```shell

    $ sudo systemctl start filebeat

    $ sudo systemctl enable filebeat
    
    
       ```
## Instalación de Suricata
1.	Primero, se ejecutan los siguientes comandos: 
     ```shell

    $ sudo apt-get install software-properties-common

    $ sudo add-apt-repository ppa:oisf/suricata-stable

    $ sudo apt-get update
    
    
       ```

    en donde el primer comando instala el paquete software-properties-common, el cual incorpora scripts que facilitan la instalación de PPAs (Personal Package  
    Archive), el segundo añade el repositorio PPA de Suricata y el tercero actualiza la lista de paquetes disponibles.

2.	Una vez se han ejecutado dichos comandos, se instala Suricata a través de: 
     ```shell

    $ sudo apt-get install suricata
    
    
       ```

    y se actualiza en caso de que sea necesario a través de 
     ```shell

    $ sudo apt-get update
    $ sudo apt-get upgrade suricata
    
    
       ```

3.	Finalmente, se actualizan las reglas proporcionadas por defecto por Suricata con el comando:
     ```shell

    $ sudo suricata-update
    
    
       ```
## Instalación de Snort
1.	En primer lugar, antes de comenzar con la instalación propia de Snort, se deben instalar un conjunto de librerías requeridas por dicho sensor, utilizando para ello el comando a continuación: 
     ```shell

    $ sudo apt install -y gcc libpcre3-dev zlib1g-dev libluajit-5.1-dev 
    libpcap-dev openssl libssl-dev libnghttp2-dev libdumbnet-dev 
	  bison flex libdnet autoconf libtool
	  
	  
       ```

2.	Tras haber ejecutado dicho comando se procede a iniciar la instalación de Snort, creando en primer lugar un directorio temporal en donde descargar los contenidos a través del comando: 
     ```shell

    $ mkdir ~/snort_src && cd ~/snort_src
    
    
       ```

3.	Tras la realización de esto último, se ejecuta el comando a continuación para descargar el paquete fuente DAQ (Data Acquisition Library) en su última versión disponible, el cual permite realizar llamadas abstractas a librerías pcap: 
     ```shell

    $ wget https://www.snort.org/downloads/snort/daq-2.0.7.tar.gz
    
    
       ```

4.	Una vez se ha completado la descarga anterior, se extrae el código fuente y se desplaza al nuevo directorio utilizando los comandos:
     ```shell
    $ tar -xvzf daq-2.0.7.tar.gz
    $ cd daq-2.0.7
    
    
       ```

5.	Antes de realizar la compilación de dicho programa, se debe reconfigurar DAQ al haberse instalado la última versión de este paquete. Para ello se utiliza el comando: 
     ```shell

    $ autoreconf -f -i
    
    
       ```

    el cual requiere tener instalado previamente los paquetes autoconf y libtool

6.	Tras haberse realizado el paso anterior, se lleva a cabo la compilación e instalación del programa usando para ello el comando: 
     ```shell

    $ ./configure && make && sudo make install 
    
    
       ```

7.	Una vez se ha instalado el paquete DAQ, se lleva a cabo la instalación de Snort. Para ello, primero hay que desplazarse al directorio creado al principio del proceso de instalación 
     ```shell

    $ cd ~/snort_src
    
    
       ```

    y una vez allí, se ejecuta el comando a continuación para instalarse el código fuente de Snort:
     ```shell

    $ wget https://www.snort.org/downloads/snort/snort-2.9.19.tar.gz
    
    
       ```

8.	Una vez se ha completado la descarga anterior, se extrae el código fuente y se desplaza al nuevo directorio utilizando los comandos: 
     ```shell

    $ tar -xvzf snort-2.9.19.tar.gz
    $ cd snort-2.9.19
    
    
       ```

9.	Finalmente se construye e instala el software a través del comando a continuación, en donde se ha habilitado sourcefire: 
     ```shell

    $ ./configure --enable-sourcefire && make && sudo make install
    
    
       ```
## Instalación de Dsiem
1.	En primer lugar, se debe instalar y posteriormente extraer la última versión binaria disponible del proyecto, utilizando para ello el comando

    ```shell
    
    export DSIEM_DIR=/var/dsiem && \
    mkdir -p $DSIEM_DIR && \
    wget https://github.com/defenxor/dsiem/releases/latest/download/dsiem-server_linux_amd64.zip -O /tmp/dsiem.zip && \
    unzip /tmp/dsiem.zip -d $DSIEM_DIR && rm -rf /tmp/dsiem.zip  && \
    cd $DSIEM_DIR
    
     ```

    en donde, tal como se puede observar, se ha instalado el software de Dsiem en el directorio creado /var/dsiem .

2.	Una vez se ha descargado el proyecto, se procede a crear un servicio asociado al mismo a través de los siguientes comandos:
 
    ```shell
    
    cat <<EOF > /etc/systemd/system/dsiem.service 
    [Unit]
    Description=Dsiem
    After=network.target

    [Service]
    Type=simple
    WorkingDirectory=/var/dsiem
    ExecStart=/var/dsiem/dsiem serve
    Restart=on-failure

    [Install]
    WantedBy=multi-user.target
    EOF
    systemctl daemon-reload && \
    systemctl enable dsiem.service && \
    systemctl start dsiem.service && \
    systemctl status dsiem.service)
    
    ```

    en donde se ha configurado el servicio para que lleve a cabo un arranque automático. 

3.	Finalmente, en el caso de que se quiera emplear el dashboard de Kibana proporcionado por el proyecto, se introduce el siguiente comando (cabe añadir que para llevar a cabo esta operación tanto Elasticsearch como Kibana deben estar ejecutándose) : 
       ```shell

    $ ./scripts/kbndashboard-import.sh ${your-kibana-IP-or-hostname} 
      ./deployments/kibana/dashboard-siem.json
      
       ```



