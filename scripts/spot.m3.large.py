import boto3

ec2 = boto3.client('ec2', region_name='us-east-1')
res = ec2.request_spot_instances(
        SpotPrice='0.0287',
        InstanceCount=1,
        LaunchSpecification={
            'InstanceType': 'm3.large',
            'ImageId': 'ami-afd15ed0', # Amazon Linux 2 LTS Candidate 2 AMI (HVM), SSD Volume Type
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
