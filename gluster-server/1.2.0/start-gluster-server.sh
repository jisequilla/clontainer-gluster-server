#!/bin/bash

#The internal scripts uses 2 environment variable LOG_LEVEL, PEER_PROBE

# LOG_LEVEL defines the gluster server log level
# PEER_PROBE if provided it will perform a gluster cluster join against the given host

#-----------------------------------------------------
#---------- Load ENV vars default values -------------
#-----------------------------------------------------

#Set gluster server LOG_LEVEL to info by default
if [ "" == "$LOG_LEVEL"  ]
then LOG_LEVEL=INFO
fi

echo "Gluster LOG_LEVEL settled to value $LOG_LEVEL"

# PEER_HOSTS must be a comma or space separated list of hosts.
echo "PEER_HOSTS settled to value $PEER_HOSTS"

#----------------------------------------------------------
#------------------ Launch the gluster server -------------
#----------------------------------------------------------

echo "Configuring gluster server"
/usr/sbin/gluster-setup.sh

echo "Starting gluster server and required services in background"

echo "Start ntpd"
/usr/sbin/ntpd
echo "Start rcpbind"
/usr/sbin/rpcbind -w
echo "Start cron"
/usr/sbin/crond start
echo "Start sshd"
/usr/sbin/sshd
echo "Start gssproxy"
/usr/sbin/gssproxy
echo "Start gluster server"
/usr/sbin/glusterd -p /var/run/glusterd.pid --log-level $LOG_LEVEL

# Init the peer probe to form the cluster against the other nodes.
if [ "" != "$PEER_HOSTS"  ]
then 
    echo "Running peer probe on hosts: $PEER_HOSTS"

    # Add all the peers from PEER_HOSTS.
    for peer in $(echo $PEER_HOSTS | tr ',' '\n')
    do
        # for each host:
        echo "Adding peer $peer"
        gluster peer probe $peer
    done

else
    echo "Env var PEER_HOSTS is not settled, peer probe won't be launched"
fi

#Check the status
echo "Checking gluster peers status"
gluster peer status
