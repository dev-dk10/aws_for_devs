#!/bin/bash

BUCKET_NAME=dkushnirov-s3-week3

{
  aws s3api create-bucket --bucket $BUCKET_NAME --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2
  aws s3api put-public-access-block  --bucket $BUCKET_NAME --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"
  aws s3api put-bucket-versioning --bucket $BUCKET_NAME --versioning-configuration Status=Enabled
  aws s3 cp dynamodb-script.sh s3://$BUCKET_NAME/
  aws s3 cp rds-script.sql s3://$BUCKET_NAME/
}
