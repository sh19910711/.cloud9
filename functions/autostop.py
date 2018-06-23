import boto3
import re

def stop():
    cf = boto3.client('cloudformation')
    pat = re.compile('cloud9-fargate')
    for s in cf.describe_stacks()['Stacks']:
        if pat.search(s['StackId']):
            print(cf.delete_stack(StackName=s['StackName']))

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
        print('stop instance: {}'.format(i))
        i.stop()

def lambda_handler(event, context):
    stop()
    return 'OK'

if __name__ == "__main__":
    stop()
