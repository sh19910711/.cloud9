import boto3

def lambda_handler(event, context):
    cluster = event['detail']['clusterArn']
    tasks = [t for t in event['detail']['containers']]
    task_arns = [t['taskArn'] for t in tasks]
    task_names = [t['name'] for t in tasks]

    ecs = boto3.client('ecs')
    task_ips = [t['value'] for t in ecs.describe_tasks(cluster=cluster, tasks=task_arns)['tasks'][0]['attachments'][0]['details'] if t['name'] == 'privateIPv4Address']

    for (name, ip) in zip(task_names, task_ips):
        route53 = boto3.client('route53')
        route53.change_resource_record_sets(
            HostedZoneId='ZYM05EIOL0MN6',
            ChangeBatch={
                'Changes': [
                    {
                        'Action': 'UPSERT',
                        'ResourceRecordSet': {
                            'Name': '{}.ecs.cloud9'.format(name),
                            'Type': 'A',
                            'Region': 'us-east-1',
                            'TTL': 300,
                            'ResourceRecords': [
                                {'Value': ip}
                            ]
                        }
                    }
                ]
            })

    return 'OK'
