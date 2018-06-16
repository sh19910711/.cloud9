import boto3

def start():
    ec2 = boto3.resource('ec2')
    instances = ec2.instances.filter(
        Filters=[{
            'Name': 'tag-key',
            'Values': ['aws:cloudformation:stack-name']
        }, {
            'Name': 'tag-value',
            'Values': ['cloud9-gpu']
        }])
    for i in instances:
        i.start()

start()
