- [Purpose](#sec-1)
- [CloudFormation operations](#sec-2)
  - [Create stack](#sec-2-1)
  - [Update stack](#sec-2-2)
  - [Describe stack events](#sec-2-3)
  - [Describe stack resources](#sec-2-4)
  - [Delete stack](#sec-2-5)
- [Create new access token](#sec-3)

# Purpose<a id="sec-1"></a>

This CloudFormation stack creates an IAM user with certain policies assigned to it.

The policies allow all subsequent operations that are needed, such as WAF creation, etc.

# CloudFormation operations<a id="sec-2"></a>

These operations shall be performed with high-level privileges.

## Create stack<a id="sec-2-1"></a>

```bash
aws cloudformation create-stack         \
    --stack-name ${STACK_NAME}          \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameters $(jsonnet params.jsonnet | jq -c) \
    --template-body file://user-cf.yaml
```

## Update stack<a id="sec-2-2"></a>

```bash
aws cloudformation update-stack                    \
    --stack-name ${STACK_NAME}                     \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameters $(jsonnet params.jsonnet | jq -c) \
    --template-body file://user-cf.yaml
```

## Describe stack events<a id="sec-2-3"></a>

```bash
aws cloudformation describe-stack-events \
    --stack-name ${STACK_NAME}
```

## Describe stack resources<a id="sec-2-4"></a>

```bash
aws cloudformation describe-stack-resources \
    --stack-name ${STACK_NAME}
```

## Delete stack<a id="sec-2-5"></a>

```bash
aws cloudformation delete-stack         \
    --stack-name ${STACK_NAME}
```

# Create new access token<a id="sec-3"></a>

After the IAM user is created, we need to create a token, which is used in the later steps.

```bash
USERNAME=$(aws cloudformation describe-stacks \
               --stack-name=${STACK_NAME} \
               --query "Stacks[0].Outputs[?OutputKey=='IamUserName'].OutputValue" \
               --output=text)
aws iam create-access-key \
    --user-name ${USERNAME} \
    --query 'AccessKey.{"AccessKeyId": AccessKeyId, "SecretAccessKey": SecretAccessKey}'
```
