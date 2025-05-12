---
title: AWS CLI Cheat
description: Cheatsheet on AWS CLI
keywords: AWS, Bash
author: Tinmarino
---

# Configure and Help

```bash
# Install
pip3 install awscli
cd /tmp && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip && sudo ./aws/install

# Config
aws configure list
aws configure --profile tin  # ciberlab

# By hand
vim ~/.aws/config
vim ~/.aws/credentials 

# Help 
aws ec2 describe-instances help
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

# Load Balancer
# -- Debug
aws elbv2 describe-load-balancers
# -- Create Load Balancer (LB)
aws elbv2 create-load-balancer --name lb-ciberlab-ctf --subnets subnet-02951a2916882e337 --type network
# -- Create Target Group (TG)
port=9090; vpc=vpc-09bc34ceee43a90cd  # Matrix
aws elbv2 create-target-group --name tg-ctf-port-"$port" --protocol TCP_UDP --port "$port" --vpc-id "$vpc"
# -- Register Targets (instances to target group)
aws elbv2 register-targets --target-group-arn "arn:aws:elasticloadbalancing:us-east-1:879381251851:targetgroup/tg-ctf-port-9090/e5106d42dc12768d" --targets Id=i-02b900a7a56e82050 Id=i-003d5973469c59d3f
# -- Create a Listener that redirects flux to the target group
aws elbv2 create-listener --load-balancer-arn "arn:aws:elasticloadbalancing:us-east-1:879381251851:loadbalancer/net/lb-ciberlab-ctf/9e6fc538d8f08cba" --protocol TCP_UDP --port "$port" --default-actions Type=forward,TargetGroupArn="arn:aws:elasticloadbalancing:us-east-1:879381251851:targetgroup/tg-ctf-port-9090/e5106d42dc12768d" 
```

# Volume

```bash
# From: https://stackoverflow.com/a/28792330/2544873
sudo lsblk --output NAME,TYPE,SIZE,FSTYPE,MOUNTPOINT,UUID,LABEL
```


# References

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


aws elbv2 create-load-balancer --name lb-ciberlab-ctf --subnets subnet-02951a2916882e337 --type network
{
    "LoadBalancers": [
        {
            "LoadBalancerArn": "arn:aws:elasticloadbalancing:us-east-1:879381251851:loadbalancer/net/lb-ciberlab-ctf/9e6fc538d8f08cba",
            "DNSName": "lb-ciberlab-ctf-9e6fc538d8f08cba.elb.us-east-1.amazonaws.com",
            "CanonicalHostedZoneId": "Z26RNL4JYFTOTI",
            "CreatedTime": "2025-05-11T16:37:52.067Z",
            "LoadBalancerName": "lb-ciberlab-ctf",
            "Scheme": "internet-facing",
            "VpcId": "vpc-09bc34ceee43a90cd",
            "State": {
                "Code": "provisioning"
            },
            "Type": "network",
            "AvailabilityZones": [
                {
                    "ZoneName": "us-east-1d",
                    "SubnetId": "subnet-02951a2916882e337",
                    "LoadBalancerAddresses": []
                }
            ],
            "IpAddressType": "ipv4",
            "EnablePrefixForIpv6SourceNat": "off"
        }
    ]
}

aws elbv2 create-target-group --name tg-ctf-port-"$port" --protocol TCP_UDP --port "$port" --vpc-id "$vpc"
{
    "TargetGroups": [
        {
            "TargetGroupArn": "arn:aws:elasticloadbalancing:us-east-1:879381251851:targetgroup/tg-ctf-port-9090/e5106d42dc12768d",
            "TargetGroupName": "tg-ctf-port-9090",
            "Protocol": "TCP_UDP",
            "Port": 9090,
            "VpcId": "vpc-09bc34ceee43a90cd",
            "HealthCheckProtocol": "TCP",
            "HealthCheckPort": "traffic-port",
            "HealthCheckEnabled": true,
            "HealthCheckIntervalSeconds": 30,
            "HealthCheckTimeoutSeconds": 10,
            "HealthyThresholdCount": 5,
            "UnhealthyThresholdCount": 2,
            "TargetType": "instance",
            "IpAddressType": "ipv4"
        }
    ]
}

aws elbv2 create-listener --load-balancer-arn "arn:aws:elasticloadbalancing:us-east-1:879381251851:loadbalancer/net/lb-ciberlab-ctf/9e6fc538d8f08cba" --protocol TCP_UDP --port "$port" --default-actions Type=forward,TargetGroupArn="arn:aws:elasticloadbalancing:us-east-1:879381251851:targetgroup/tg-ctf-port-9090/e5106d42dc12768d" {
    "Listeners": [
        {
            "ListenerArn": "arn:aws:elasticloadbalancing:us-east-1:879381251851:listener/net/lb-ciberlab-ctf/9e6fc538d8f08cba/7a7dc4329eea7f32",
            "LoadBalancerArn": "arn:aws:elasticloadbalancing:us-east-1:879381251851:loadbalancer/net/lb-ciberlab-ctf/9e6fc538d8f08cba",
            "Port": 9090,
            "Protocol": "TCP_UDP",
            "DefaultActions": [
                {
                    "Type": "forward",
                    "TargetGroupArn": "arn:aws:elasticloadbalancing:us-east-1:879381251851:targetgroup/tg-ctf-port-9090/e5106d42dc12768d",
                    "ForwardConfig": {
                        "TargetGroups": [
                            {
                                "TargetGroupArn": "arn:aws:elasticloadbalancing:us-east-1:879381251851:targetgroup/tg-ctf-port-9090/e5106d42dc12768d"
                            }
                        ]
                    }
                }
            ]
        }
    ]
}
```

### Link

* [Install](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
