FROM ubuntu:16.04

LABEL "rating"="Five Stars" "class"="First Class" "maintainer"="Antonio Prado <antonio.prado@amk-technologies.com>"


RUN mkdir /repos
RUN chmod ugo+w /repos
ADD ./settings.xml /
COPY docker-entrypoint.sh /

RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list \
    && echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 \
    && apt-get -y update \
    && /bin/echo /usr/bin/debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
    && /bin/echo /usr/bin/debconf shared/accepted-oracle-license-v1-1 seen true  | /usr/bin/debconf-set-selections \
RUN apt-get update
RUN apt-get install -y git
RUN apt-cache search maven
RUN apt-get install -y maven
RUN apt-get install -y oracle-java8-installer oracle-java8-unlimited-jce-policy oracle-java8-set-default

RUN /docker-entrypoint.sh