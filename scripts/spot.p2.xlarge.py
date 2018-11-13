import boto3

ec2 = boto3.client('ec2', region_name='us-east-1')
res = ec2.request_spot_instances(
        SpotPrice='0.3',
        InstanceCount=1,
        LaunchSpecification={
            'InstanceType': 'p2.xlarge',
            'ImageId': 'ami-0d3348bce8bdde5a6',
            'KeyName': 'gateway',
            'SubnetId': 'subnet-54c51908',
            'SecurityGroupIds': [
                'sg-84508fcf'
            ],
            'IamInstanceProfile': {
                'Arn': 'arn:aws:iam::845933287843:instance-profile/cloud9-instance-InstanceProfile-9BNKU11CYROW'
            }
        }
    )

print(res)
