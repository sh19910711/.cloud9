import boto3

ec2 = boto3.client('ec2', region_name='us-east-1')
res = ec2.request_spot_instances(
        SpotPrice='5.000',
        InstanceCount=1,
        LaunchSpecification={
            'InstanceType': 'p3.8xlarge',
            'ImageId': 'ami-019d763d02ed9041e',
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
