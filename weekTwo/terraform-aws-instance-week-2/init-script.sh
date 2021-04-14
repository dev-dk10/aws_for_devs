#!/bin/bash

yum -y update
yum -y install httpd
aws s3api get-object --bucket dkushnirov-s3-week2 --key index.html /var/www/html/index.html
sudo service httpd start
chkonfig httpd on