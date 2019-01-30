FROM ubuntu:16.04

ENV JAVA_HOME /opt/java
ENV PATH /opt/flume/bin:/opt/java/bin:$PATH
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && apt-get install -q -y --no-install-recommends wget apt-utils cron

RUN mkdir /opt/java
RUN wget -q --no-check-certificate -c https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz
RUN tar zxf openjdk-11.0.1_linux-x64_bin.tar.gz --absolute-names -C /opt/java --strip 1 

RUN mkdir /opt/flume
RUN wget -q --no-check-certificate -c http://archive.apache.org/dist/flume/1.8.0/apache-flume-1.8.0-bin.tar.gz
RUN tar zxf apache-flume-1.8.0-bin.tar.gz -C /opt/flume --strip 1 

ADD ./scripts/start-flume.sh /opt/flume/bin/start-flume.sh
ADD ./log4j.properties /opt/flume/conf/log4j.properties
ADD ./scripts/conf/flume.conf /opt/flume/conf/

RUN mkdir /opt/flume/plugins.d
ENV FLUME_CLASSPATH=/opt/flume/plugins.d
# SI HACE FALTA INTERCEPTORES

ENV WORKING_DIR=/opt/flume/
WORKDIR ${WORKING_DIR}

ENTRYPOINT ["/opt/flume/bin/start-flume.sh"]