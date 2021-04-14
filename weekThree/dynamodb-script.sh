#!/bin/bash

aws dynamodb list-tables --region us-west-2

echo "put (key -> '1' value -> 'Serg')"
aws dynamodb put-item --table-name "aws_project_users_table" --item '{ "LookupKey": {"N": "1"}, "Value": {"S": "Serg"} }' --region us-west-2

echo "put (key -> '2' value -> 'Ivan')"
aws dynamodb put-item --table-name "aws_project_users_table" --item '{ "LookupKey": {"N": "2"}, "Value": {"S": "Ivan"} }' --region us-west-2

echo "get value with key 1"
aws dynamodb get-item --table-name "aws_project_users_table" --key '{ "LookupKey": {"N": "1"} }' --region us-west-2

echo "get value with key 2"
aws dynamodb get-item --table-name "aws_project_users_table" --key '{ "LookupKey": {"N": "2"} }' --region us-west-2

echo "get unexisting value"
aws dynamodb get-item --table-name "aws_project_users_table" --key '{ "LookupKey": {"N": "3"} }' --region us-west-2