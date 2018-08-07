FROM gluster-server-java8-service:1.3.0

LABEL Description="Image for Nova Java Services. Contains the scripts required to start the gluster server and the service + localtime Madrid + security" Vendor="BBVA" Version="1.4.0"

MAINTAINER NOVA enoa.cib@bbva.com 

# Remove old file localtime and add the new one
RUN rm /etc/localtime
ADD /Madrid /etc/localtime

# Set the timezone file
ENV TZ=Europe/Madrid
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Add security   
ADD local_policy.jar /usr/lib/jvm/zulu-8-amd64/jre/lib/security/
ADD US_export_policy.jar /usr/lib/jvm/zulu-8-amd64/jre/lib/security/
