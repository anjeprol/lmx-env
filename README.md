# DOCKER CONTAINER WITH JAVA 8 AND MAVEN

## INDEX

* [`Dockerfile`](#docker-configuratio)




### Docker configuration
Java 8 and Maven

```yaml
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list \
    && echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 \
    && apt-get -y update \
    && /bin/echo /usr/bin/debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
    && /bin/echo /usr/bin/debconf shared/accepted-oracle-license-v1-1 seen true  | /usr/bin/debconf-set-selections \
    && apt-get update \
    && apt-get install -y git && nano \
    && apt-get install -y oracle-java8-installer oracle-java8-unlimited-jce-policy oracle-java8-set-default \
```

### Install maven sh 

```shell
if [ $GROUP_EXISTS -eq 0 ]
then
    echo "El grupo ${GRUPO} (ID: ${ID_GRUPO}) no existe y será creado."
    sudo groupadd --gid $ID_GRUPO $GRUPO

    if [ "$?" -ne 0 ]; then
        echo "Error al crear el grupo ${GRUPO} [ID=${ID_GRUPO}]"
        exit -1
    fi
else
    echo "El grupo ${GRUPO} (ID: ${ID_GRUPO}) ya existe en el sistema."
fi

BELONGS_TO_GROUP=`grep "$GRUPO" /etc/group | grep -c "$USUARIO"`

if [ $BELONGS_TO_GROUP -eq 0 ]
then
    echo "Se asignará el usuario ${USUARIO} al grupo ${GRUPO}"
    sudo usermod -a -G $GRUPO $USUARIO

    if [ "$?" -ne 0 ]; then
        echo "Error al asignar el usuario ${USUARIO} al grupo ${GRUPO}"
        exit -1
    fi
else
    echo "El usuario ${USUARIO} ya pertenece al grupo ${GRUPO}"
fi

```