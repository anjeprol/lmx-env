# DOCKER CONTAINER WITH JAVA 8 AND MAVEN

## INDEX

* [`Dockerfile`](#docker-configuration)
* [`docker-compose`](#docker-compose)
* [`Build the image`](#build-the-image)
* [`Command to start container`](#command-to-start-container)
* [`Once you are inside the container execute the next command line`](#once-you-are-inside-the-container-execute-the-next-command-line)
* [`Folder to pull the git projects`](#folder-to-pull-the-git-projects)
* [`Maven version`](#maven-version)
* [`Java Version`](#java-Version)

### Docker configuration
Java 8 and Maven

### Docker-compose
Basic configuration to start the container.

```yaml
version: '2'
services:
  mvncont:
    image: amk/maven
    container_name: repos-maven
    environment:
      - SITE_DIR_NAME=repos
    volumes:
      - ./reposdata:/repos
    ports:
      - 8000:8000
    tty: true
    networks:
      - reposnet
    mem_limit: 1024M

networks:
  reposnet:
    driver: bridge
```

### build the image
To build the image
```docker
docker build -t amk/maven .
```

### command to start container
To start the container
```docker
docker-compose up -d mvncont
```

### command to access the container
```yaml
docker exec -it repos-maven /bin/bash
```

### entry points
```shell 
#!/bin/bash

echo 'Running docker entry point'
echo 'Changing permissions to '$SITE_DIR_NAME
chmod ugo+w $SITE_DIR_NAME
mv ./settings.xml /etc/maven/
export MAVEN_OPTS='-XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee'
```

### Folder to pull the git projects
> `reposdata` Here is where you need to download your project to build with maven.

### Maven version
```shell
Apache Maven 3.3.9
Maven home: /usr/share/maven
Java version: 1.8.0_161, vendor: Oracle Corporation
Java home: /usr/lib/jvm/java-8-oracle/jre
Default locale: en_US, platform encoding: ANSI_X3.4-1968
OS name: "linux", version: "4.13.0-32-generic", arch: "amd64", family: "unix"
```

## Java Version
```shell
java version "1.8.0_161"
Java(TM) SE Runtime Environment (build 1.8.0_161-b12)
Java HotSpot(TM) 64-Bit Server VM (build 25.161-b12, mixed mode)
```
