FROM nova/gluster-server:1.2.0

LABEL Description="Gluster image with Zulu8 JVM" Vendor="BBVA" Version="1.2.0"

MAINTAINER NOVA enoa.cib@bbva.com

# Host where the static files will be served from.
# NOTE: localhost and 127.0.0.1 won't work. Use the host real IP.
ARG CURL_HOST=192.168.0.50

# In order to run the build you need to create an HTTP server containing the tar rpm. See Instructions.txt
# This is done to avoid unnecesary docker image layers to create smaller images
# Change the curl call to point to your local HTTP server 

# Declare and install the packages required by the Zulu8 JVM
RUN mkdir -p /usr/lib/jvm \
    && cd /usr/lib/jvm \
    && curl http://${CURL_HOST}/gluster-server-java8_1.1.0/zulu8.20.0.5-jdk8.0.121-linux_x64.tar | tar -x \
    && mv zulu8.20.0.5-jdk8.0.121-linux_x64 zulu-8-amd64 \
    && cd zulu-8-amd64 \
    && rm -f ASSEMBLY_EXCEPTION \
    && rm -f DISCLAIMER \
    && rm -f LICENSE \
    && rm -f THIRD_PARTY_README \
    && rm -f Welcome.html \
    && rm -f readme.txt \
    && rm -f src.zip \
    && cd demo && rm -rf * && cd .. && rmdir demo \
    && cd man && rm -rf * && cd .. && rmdir man \
    && cd sample && rm -rf * && cd .. && rmdir sample

# Set the environment
ENV JAVA_HOME /usr/lib/jvm/zulu-8-amd64
ENV PATH ${PATH}:${JAVA_HOME}/bin
