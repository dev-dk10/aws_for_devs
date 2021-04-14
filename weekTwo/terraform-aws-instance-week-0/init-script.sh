#!/bin/bash
yum -y update
yum -y install httpd
sudo service httpd start
chkonfig httpd on