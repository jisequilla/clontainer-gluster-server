FROM centos:7

LABEL Description="Gluster 3.12 server" Vendor="BBVA" Version="1.2.0"

# Install the gluster packages from rpm to make sure the version is the same and the required dependencies
RUN yum --setopt=tsflags=nodocs -y update; yum install -y centos-release-gluster312; yum clean all; \
yum --setopt=tsflags=nodocs -y install nfs-utils attr iputils iproute openssh-server openssh-clients ntp rsync tar cronie sudo xfsprogs glusterfs glusterfs-server glusterfs-rdma glusterfs-geo-replication;yum clean all;
  
#Disable require tty for sudo
RUN sed -i '/Defaults    requiretty/c\#Defaults    requiretty' /etc/sudoers

#Backing up gluster config as it overlaps when bind mounting.
RUN mkdir -p /etc/glusterfs_bkp /var/lib/glusterd_bkp /var/log/glusterfs_bkp

RUN cp -r /etc/glusterfs/* /etc/glusterfs_bkp;\
cp -r /var/lib/glusterd/* /var/lib/glusterd_bkp;\
cp -r /var/log/glusterfs/* /var/log/glusterfs_bkp;

#Configure LVM to create LVs and snapshots
RUN sed -i -e "s#udev_sync = 1#udev_sync = 0#" -e "s#udev_rules = 1#udev_rules = 0#" -e "s#use_lvmetad = 1#use_lvmetad = 0#" /etc/lvm/lvm.conf

#Adding script to move the glusterfs config file to location from the backups
ADD gluster-setup.sh /usr/sbin/gluster-setup.sh
RUN chmod 500 /usr/sbin/gluster-setup.sh

#Adding script to launch glusterfs
ADD start-gluster-server.sh /usr/sbin/start-gluster-server.sh
RUN chmod 500 /usr/sbin/start-gluster-server.sh

#Create the filesystem cgroups volume
VOLUME ["/sys/fs/cgroup"]

#Set entry point
CMD ["/usr/sbin/start-gluster-server.sh"]



