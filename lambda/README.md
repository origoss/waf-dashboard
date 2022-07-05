- [Compiling and uploading zipped binary to S3](#sec-1)
- [Lambda](#sec-2)
  - [List](#sec-2-1)
  - [Logs](#sec-2-2)
    - [Describe log groups](#sec-2-2-1)
    - [Describe log streams](#sec-2-2-2)
    - [Describe log events](#sec-2-2-3)

# Compiling and uploading zipped binary to S3<a id="sec-1"></a>

```bash
BUCKET_NAME=$(jq -r '.S3BucketName' <../params.json)
echo "BUCKET_NAME=${BUCKET_NAME}"
nix-build &&
aws s3api put-object --bucket ${BUCKET_NAME} \
    --key lambda.zip \
    --body result/main.zip
```

# Lambda<a id="sec-2"></a>

## List<a id="sec-2-1"></a>

```bash
aws lambda list-functions
```

## Logs<a id="sec-2-2"></a>

### Describe log groups<a id="sec-2-2-1"></a>

```bash
aws logs describe-log-groups \
    --log-group-name-prefix /aws/lambda/lambda-experiment \
    --query 'logGroups[*].logGroupName'
```

### Describe log streams<a id="sec-2-2-2"></a>

```bash
LOG_GROUP_NAME=$(aws logs describe-log-groups \
                 --log-group-name-prefix /aws/lambda/lambda-experiment \
                 --output text \
                 --query 'logGroups[0].logGroupName')
echo "Log streams of ${LOG_GROUP_NAME}"
aws logs describe-log-streams \
    --log-group-name ${LOG_GROUP_NAME} \
    --query 'logStreams[*].logStreamName'
```

### Describe log events<a id="sec-2-2-3"></a>

```bash
LOG_GROUP_NAME=$(aws logs describe-log-groups \
                 --log-group-name-prefix /aws/lambda/lambda-experiment \
                 --output text \
                 --query 'logGroups[0].logGroupName')
LOG_STREAM_NAME=$(aws logs describe-log-streams \
                      --log-group-name ${LOG_GROUP_NAME} \
                      --output text \
                      --query 'logStreams[-1].logStreamName')
echo "Log events of ${LOG_GROUP_NAME}::${LOG_STREAM_NAME}"
aws logs get-log-events \
    --log-group-name ${LOG_GROUP_NAME} \
    --log-stream-name ${LOG_STREAM_NAME}
```
