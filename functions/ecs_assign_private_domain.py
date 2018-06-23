import boto3
import re

def lambda_handler(event, context):
    cluster = event['detail']['clusterArn']
    tasks = [t for t in event['detail']['containers']]
    task_arns = [t['taskArn'] for t in tasks]
    task_names = [t['name'] for t in tasks]

    ecs = boto3.client('ecs')
    task_ips = [t['value'] for t in ecs.describe_tasks(cluster=cluster, tasks=task_arns)['tasks'][0]['attachments'][0]['details'] if t['name'] == 'privateIPv4Address']

    for (name, ip) in zip(task_names, task_ips):
        changes = []

        # delete record if exists
        route53 = boto3.client('route53')
        records = [r for r in route53.list_resource_record_sets(HostedZoneId='ZYM05EIOL0MN6')['ResourceRecordSets'] if r['Name'] == '{}.ecs.cloud9.'.format(name)]
        if len(records) > 0:
            changes.append({
                'Action': 'DELETE',
                'ResourceRecordSet': records[0]
            })

        changes.append({
            'Action': 'UPSERT',
            'ResourceRecordSet': {
                'Name': '{}.ecs.cloud9'.format(name),
                'Type': 'A',
                'SetIdentifier': 'cloud9',
                'Region': 'us-east-1',
                'TTL': 300,
                'ResourceRecords': [
                    {'Value': ip}
                ]
            }
        })

        route53.change_resource_record_sets(
            HostedZoneId='ZYM05EIOL0MN6',
            ChangeBatch={
                'Changes': changes
            })

    return 'OK'
