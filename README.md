# DOCKER CONTAINER WITH JAVA 8 AND MAVEN

## INDEX

* [`Dockerfile`](#docker-configuratio)




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