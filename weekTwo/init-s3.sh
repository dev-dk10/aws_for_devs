echo "Hello world" > index.html
aws s3api create-bucket --bucket dkushnirov-s3-week2 --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2
aws s3api put-public-access-block  --bucket dkushnirov-s3-week2 --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"
aws s3api put-bucket-versioning --bucket dkushnirov-s3-week2 --versioning-configuration Status=Enabled
aws s3 cp index.html s3://dkushnirov-s3-week2/
