import boto3

ec2 = boto3.client('ec2', region_name='us-east-1')
res = ec2.request_spot_instances(
        SpotPrice='0.08',
        InstanceCount=1,
        LaunchSpecification={
            'InstanceType': 'm4.xlarge',
            # 'ImageId': 'ami-cfe4b2b0', # Amazon Linux AMI 2018.03.0 (HVM), SSD Volume Type
            'ImageId': 'ami-0522012eae8cd4656',    
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
