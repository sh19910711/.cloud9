import boto3

def stop():
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
