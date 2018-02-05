#!/bin/bash

#Instalando y Configurando Maven 3.3.9
USUARIO=`whoami`
export USUARIO

. env_groups.sh

GRUPO=$GRUPO_MAVEN
export GRUPO
ID_GRUPO=$ID_GRUPO_MAVEN
export ID_GRUPO

MAVEN=apache-maven-3.3.9
export MAVEN

INSTALLER=apache-maven-3.3.9-bin.tar.gz
export INSTALLER

MAVEN_PARENT=/opt/$GRUPO
export MAVEN_PARENT
MAVEN_HOME=$MAVEN_PARENT/$MAVEN
export MAVEN_HOME
JAVA_HOME=/usr/lib/jvm/jdk1.8.0_91
export JAVA_HOME

PROFILE_USUARIO=/home/$USUARIO/.profile
export PROFILE_USUARIO

echo "Instalando y configurando Maven 3.3.9!"
echo "JAVA_HOME=${JAVA_HOME}"

GROUP_EXISTS=`grep -c "$GRUPO" /etc/group`

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

if [ ! -d "$MAVEN_PARENT" ]
then
    echo "Se creará el directorio \"MAVEN_PARENT\". Ruta: ${MAVEN_PARENT}"
    sudo mkdir $MAVEN_PARENT

    if [ "$?" -ne 0 ]; then
        echo "Error al crear el directorio \"MAVEN_PARENT\" [ruta = ${MAVEN_PARENT}]"
        exit -1
    fi

    sudo chown -R root:$GRUPO $MAVEN_PARENT
    if [ "$?" -ne 0 ]; then
        echo "Error al asignar el directorio ${MAVEN_PARENT} al grupo ${GRUPO}"
        exit -1
    fi

    sudo chmod -R 775 $MAVEN_PARENT
    if [ "$?" -ne 0 ]; then
        echo "Error al asignar permisos al directorio ${MAVEN_PARENT}"
        exit -1
    fi

else
    echo "El directorio \"MAVEN_PARENT\" ya existe. Ruta: ${MAVEN_PARENT}"
fi

sudo tar -xvf $GRUPO/$INSTALLER
sudo mv $MAVEN $MAVEN_PARENT/
sudo chown -R $USUARIO:$GRUPO $MAVEN_HOME

echo "MAVEN_HOME = ${MAVEN_HOME}"

ENV_MAVEN=.env_maven
export ENV_MAVEN

echo "MAVEN_HOME=${MAVEN_HOME}" >> /home/$USUARIO/$ENV_MAVEN
echo "export MAVEN_HOME" >> /home/$USUARIO/$ENV_MAVEN
echo "M2_HOME=${MAVEN_HOME}" >> /home/$USUARIO/$ENV_MAVEN
echo "export M2_HOME" >> /home/$USUARIO/$ENV_MAVEN
echo "PATH=\$PATH:\$MAVEN_HOME/bin" >> /home/$USUARIO/$ENV_MAVEN
echo "export PATH" >> /home/$USUARIO/$ENV_MAVEN

echo "" >> $PROFILE_USUARIO
echo ". \$HOME/${ENV_MAVEN}" >> $PROFILE_USUARIO

. ~/.profile

mvn -version

M2_DIRECTORY=/home/${USUARIO}/.m2

if [ ! -d "$M2_DIRECTORY" ]
then
    echo "Creando el directorio ${M2_DIRECTORY}"
    mkdir $M2_DIRECTORY
fi

cp $GRUPO/settings.xml $M2_DIRECTORY/

echo "Maven 3.3.9 se instaló con éxito!!!!"

