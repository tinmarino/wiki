---
title: AWS CLI Cheat
description: Cheatsheet on AWS CLI
keywords: AWS, Bash
author: Tinmarino
---

# Configure and Help

```bash
# Config
aws configure list
aws configure --profile tin  # ciberlab

# By hand
vim ~/.aws/config
vim ~/.aws/credentials 

# Help 
aws ec2 list-commands 2>&1 | grep template
```

# Instances

```bash
# Instance
aws ec2 describe-instances

# Launch Templates
aws ec2 describe-launch-templates
aws ec2 get-launch-template-data --instance-id i-02b900a7a56e82050

# Launch cloud formation stack
aws cloudformation create-stack --stack-name stack-ctf-01 --template-body file://script/aws-cloudformation-template-ctf-instance.yaml --parameters ParameterKey=Name,ParameterValue=CTF01 --capabilities CAPABILITY_IAM
```

# Volume

```bash
# From: https://stackoverflow.com/a/28792330/2544873
sudo lsblk --output NAME,TYPE,SIZE,FSTYPE,MOUNTPOINT,UUID,LABEL
```


# Outputs

### Config

```bash
cat ~/.aws/config
[default]
region = us-east-1
output = json
[profile ciberlab]
region = us-east-1
output = json
[profile tin]
region = us-east-1
output = json

cat ~/.aws/credentials
[default]
aws_access_key_id = A.K.I.Axxxxxxxxxxxxxxxx
aws_secret_access_key = u3mFphUxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
[ciberlab]
aws_access_key_id = A.K.I.Axxxxxxxxxxxxxxxx
aws_secret_access_key = u3mFxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
[tin]
aws_access_key_id = A.K.I.Axxxxxxxxxxxxxxxx
aws_secret_access_key = 7PL1xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```


### Template

```bash
aws --profile cyberlab ec2 describe-launch-templates
{
    "LaunchTemplates": [
        {
            "LaunchTemplateId": "lt-07afd91ccaafc6d39",
            "LaunchTemplateName": "template-ctf-01",
            "CreateTime": "2025-05-09T18:15:07.000Z",
            "CreatedBy": "arn:aws:iam::879381251851:user/Dreamlabs",
            "DefaultVersionNumber": 1,
            "LatestVersionNumber": 1,
            "Operator": {
                "Managed": false
            }
        }
    ]
}
```

