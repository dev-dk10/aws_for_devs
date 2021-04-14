#!/bin/bash
aws s3api get-object --bucket dkushnirov-s3-week3 --key dynamodb-script.sh /home/ec2-user/dynamodb-script.sh
aws s3api get-object --bucket dkushnirov-s3-week3 --key rds-script.sql  /home/ec2-user/rds-script.sql
