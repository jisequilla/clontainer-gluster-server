------------------- HOW TO BUILD -----------------------------------------

In order to reduce the number of docker layers we are using curl instead of copy to add files into docker.

You need an HTTP server with the files you want to copy using curl.

The curl IP cannot be localhost, use the real machine IP

There are many tutorials on how to create an HTTP server:

https://devops.profitbricks.com/tutorials/how-to-set-up-apache-web-server-on-centos-7/

--------------- CREATE HTTP SERVER --------------------------------------------

Instruction (centos and redhat):

# Install http server
sudo yum install httpd -y

# Remove SeLinux, edit config and set SELINUX=disabled
sudo nano /etc/selinux/config

# Set the firewall
sudo firewall-cmd --permanent --add-port=80/tcp
sudo firewall-cmd --permanent --add-port=443/tcp
sudo firewall-cmd --reload

# Start the service
sudo systemctl start httpd

# Copy the files you want to be accesible in /var/www/html

--------------- BUILDING WITH ARGUMENTS ---------------------------------------

This Dockerfile will accept the following arguments:

- CURL_HOST: The IP of the host where the HTTP server is running on.

Example:

    docker build --build-arg CURL_HOST=20.1.67.21 -t nova/gluster-server:1.1.0 .

