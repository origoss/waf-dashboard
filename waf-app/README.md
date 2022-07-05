- [Managing Custom resource with CloudFormation](#sec-1)
  - [Create Stack](#sec-1-1)
  - [Update Stack](#sec-1-2)
  - [Delete Stack](#sec-1-3)
  - [Describe stack resources](#sec-1-4)
  - [Describe stack events](#sec-1-5)

# Managing Custom resource with CloudFormation<a id="sec-1"></a>

## Create Stack<a id="sec-1-1"></a>

```bash
export STACK_NAME=$(jq -r '.WafCfStackName' <../params.json)
aws cloudformation create-stack         \
    --stack-name ${STACK_NAME}          \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameters $(jsonnet params.jsonnet | jq -c) \
    --template-body file://cf.yaml
```

## Update Stack<a id="sec-1-2"></a>

```bash
export STACK_NAME=$(jq -r '.WafCfStackName' <../params.json)
aws cloudformation update-stack                    \
    --stack-name ${STACK_NAME}                     \
    --capabilities CAPABILITY_NAMED_IAM            \
    --parameters $(jsonnet params.jsonnet | jq -c) \
    --template-body file://cf.yaml
```

## Delete Stack<a id="sec-1-3"></a>

```bash
export STACK_NAME=$(jq -r '.WafCfStackName' <../params.json)
aws cloudformation delete-stack         \
    --stack-name ${STACK_NAME}
```

## Describe stack resources<a id="sec-1-4"></a>

```bash
export STACK_NAME=$(jq -r '.WafCfStackName' <../params.json)
aws cloudformation describe-stack-resources \
    --stack-name ${STACK_NAME}
```

## Describe stack events<a id="sec-1-5"></a>

```bash
export STACK_NAME=$(jq -r '.WafCfStackName' <../params.json)
aws cloudformation describe-stack-events \
    --stack-name ${STACK_NAME}
```
