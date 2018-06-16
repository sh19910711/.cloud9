sudo yum install -y jq
aws ec2 create-key-pair --key-name gateway | jq -r '.KeyMaterial' > ~/.ssh/id_gateway
chmod go-rwx ~/.ssh/id_gateway
