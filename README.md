# DOCKER CONTAINER WITH JAVA 8 AND MAVEN

## INDEX

* [`Dockerfile`](#docker-configuratio)




### Docker configuration
Java 8 and Maven

### Docker-compose
Basic configuration to start the container.

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