FROM gluster-server-java8:1.2.0

LABEL Description="Image for Nova Java Services. Contains the scripts required to start the gluster server and the service" Vendor="BBVA" Version="1.3.0"

MAINTAINER NOVA enoa.cib@bbva.com 

# Usage: The entry point script expect as parameters the memory to use (in megabytes), mountpoints (if any) and the jar file to execute.
# Example: -mem 4096 -mount 'host:/path targetPath' application.jar 

# Copy the scripts
COPY mount_nova_fs.sh launch_java_service.sh launch_gluster_and_java_service.sh /usr/bin/

# Give permissions
RUN chmod a+x /usr/bin/mount_nova_fs.sh \
   && chmod a+x /usr/bin/launch_java_service.sh \
   && chmod a+x /usr/bin/launch_gluster_and_java_service.sh

ENTRYPOINT ["/usr/bin/launch_gluster_and_java_service.sh"]
