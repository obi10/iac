#!/bin/bash
# Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

yum install httpd -y
apachectl start
systemctl enable httpd
apachectl configtest
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --reload
echo 'This is Oracle webserver Junior running on OCI Workshop' > /var/www/html/index.html