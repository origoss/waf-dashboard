- [Managing S3 resources](#sec-1)
  - [Create Stack](#sec-1-1)
  - [Update Stack](#sec-1-2)
  - [Objects](#sec-1-3)
    - [List Versions](#sec-1-3-1)
    - [Remove](#sec-1-3-2)
  - [Delete Stack](#sec-1-4)
  - [Describe stack resources](#sec-1-5)
  - [Describe stack events](#sec-1-6)

# Managing S3 resources<a id="sec-1"></a>

## Create Stack<a id="sec-1-1"></a>

```bash
export STACK_NAME=$(jq -r '.S3CfStackName' <../params.json)
aws cloudformation create-stack         \
    --stack-name ${STACK_NAME}          \
    --parameters $(jsonnet params.jsonnet | jq -c)     \
    --template-body file://cf.yaml
```

## Update Stack<a id="sec-1-2"></a>

```bash
export STACK_NAME=$(jq -r '.S3CfStackName' <../params.json)
aws cloudformation update-stack                    \
    --stack-name ${STACK_NAME}                     \
    --parameters $(jsonnet params.jsonnet | jq -c) \
    --template-body file://cf.yaml
```

## Objects<a id="sec-1-3"></a>

### List Versions<a id="sec-1-3-1"></a>

```bash
export BUCKET_NAME=$(jq -r '.S3BucketName' <../params.json)
aws s3api list-object-versions --bucket ${BUCKET_NAME}
```

### Remove<a id="sec-1-3-2"></a>

```bash
export BUCKET_NAME=$(jq -r '.S3BucketName' <../params.json)
export VERSIONS=$(aws s3api list-object-versions --bucket ${BUCKET_NAME} \
                      --output text \
                      --query 'Versions[*].VersionId')
export MARKERS=$(aws s3api list-object-versions --bucket ${BUCKET_NAME} \
                      --output text \
                      --query 'DeleteMarkers[*].VersionId')
for VERSION_ID in ${VERSIONS}; do
    aws s3api delete-object --bucket ${BUCKET_NAME} \
        --key lambda.zip \
        --version-id=${VERSION_ID}
done
for MARKER_ID in ${MARKERS}; do
    aws s3api delete-object --bucket ${BUCKET_NAME} \
        --key lambda.zip \
        --version-id=${MARKER_ID}
done
```

## Delete Stack<a id="sec-1-4"></a>

```bash
export STACK_NAME=$(jq -r '.S3CfStackName' <../params.json)
aws cloudformation delete-stack         \
    --stack-name ${STACK_NAME}
```

## Describe stack resources<a id="sec-1-5"></a>

```bash
export STACK_NAME=$(jq -r '.S3CfStackName' <../params.json)
aws cloudformation describe-stack-resources \
    --stack-name ${STACK_NAME}
```

## Describe stack events<a id="sec-1-6"></a>

```bash
export STACK_NAME=$(jq -r '.S3CfStackName' <../params.json)
aws cloudformation describe-stack-events \
    --stack-name ${STACK_NAME}
```

    {
        "StackEvents": [
            {
                "StackId": "arn:aws:cloudformation:eu-central-1:640629842382:stack/raiffeisen-waf-dashboarding-s3/1f3113b0-f92c-11ec-902e-02bac4959566",
                "EventId": "22d626e0-f92c-11ec-b5c9-069b83a29228",
                "StackName": "raiffeisen-waf-dashboarding-s3",
                "LogicalResourceId": "raiffeisen-waf-dashboarding-s3",
                "PhysicalResourceId": "arn:aws:cloudformation:eu-central-1:640629842382:stack/raiffeisen-waf-dashboarding-s3/1f3113b0-f92c-11ec-902e-02bac4959566",
                "ResourceType": "AWS::CloudFormation::Stack",
                "Timestamp": "2022-07-01T10:54:09.992000+00:00",
                "ResourceStatus": "ROLLBACK_IN_PROGRESS",
                "ResourceStatusReason": "The following resource(s) failed to create: [Bucket]. Rollback requested by user."
            },
            {
                "StackId": "arn:aws:cloudformation:eu-central-1:640629842382:stack/raiffeisen-waf-dashboarding-s3/1f3113b0-f92c-11ec-902e-02bac4959566",
                "EventId": "Bucket-CREATE_FAILED-2022-07-01T10:54:08.905Z",
                "StackName": "raiffeisen-waf-dashboarding-s3",
                "LogicalResourceId": "Bucket",
                "PhysicalResourceId": "",
                "ResourceType": "AWS::S3::Bucket",
                "Timestamp": "2022-07-01T10:54:08.905000+00:00",
                "ResourceStatus": "CREATE_FAILED",
                "ResourceStatusReason": "API: s3:CreateBucket Access Denied",
                "ResourceProperties": "{\"BucketName\":\"origoss-raiffeisen-waf-dashboarding\",\"VersioningConfiguration\":{\"Status\":\"Enabled\"}}"
            },
            {
                "StackId": "arn:aws:cloudformation:eu-central-1:640629842382:stack/raiffeisen-waf-dashboarding-s3/1f3113b0-f92c-11ec-902e-02bac4959566",
                "EventId": "Bucket-CREATE_IN_PROGRESS-2022-07-01T10:54:08.079Z",
                "StackName": "raiffeisen-waf-dashboarding-s3",
                "LogicalResourceId": "Bucket",
                "PhysicalResourceId": "",
                "ResourceType": "AWS::S3::Bucket",
                "Timestamp": "2022-07-01T10:54:08.079000+00:00",
                "ResourceStatus": "CREATE_IN_PROGRESS",
                "ResourceProperties": "{\"BucketName\":\"origoss-raiffeisen-waf-dashboarding\",\"VersioningConfiguration\":{\"Status\":\"Enabled\"}}"
            },
            {
                "StackId": "arn:aws:cloudformation:eu-central-1:640629842382:stack/raiffeisen-waf-dashboarding-s3/1f3113b0-f92c-11ec-902e-02bac4959566",
                "EventId": "1f330f80-f92c-11ec-902e-02bac4959566",
                "StackName": "raiffeisen-waf-dashboarding-s3",
                "LogicalResourceId": "raiffeisen-waf-dashboarding-s3",
                "PhysicalResourceId": "arn:aws:cloudformation:eu-central-1:640629842382:stack/raiffeisen-waf-dashboarding-s3/1f3113b0-f92c-11ec-902e-02bac4959566",
                "ResourceType": "AWS::CloudFormation::Stack",
                "Timestamp": "2022-07-01T10:54:03.920000+00:00",
                "ResourceStatus": "CREATE_IN_PROGRESS",
                "ResourceStatusReason": "User Initiated"
            }
        ]
    }
