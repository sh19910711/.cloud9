tmp:
	mkdir tmp

vpc: tmp
	aws cloudformation package \
		--template-file stacks/vpc.yml \
		--s3-bucket cloud9-tmp \
		--s3-prefix cloudformation/vpc \
		--output-template-file tmp/packaged-vpc.yml

	aws cloudformation deploy \
		--template-file tmp/packaged-vpc.yml \
		--stack-name cloud9-vpc \
		--capabilities CAPABILITY_IAM

cloud9: tmp
	aws cloudformation package \
		--template-file stacks/cloud9.yml \
		--s3-bucket cloud9-tmp \
		--s3-prefix cloudformation/cloud9 \
		--output-template-file tmp/packaged-cloud9.yml

	aws cloudformation deploy \
		--template-file tmp/packaged-cloud9.yml \
		--stack-name cloud9 \
		--capabilities CAPABILITY_IAM

.PHONY: functions
functions: tmp
	aws cloudformation package \
		--template-file stacks/functions.yml \
		--s3-bucket cloud9-tmp \
		--s3-prefix cloudformation/functions \
		--output-template-file tmp/packaged-functions.yml

	aws cloudformation deploy \
		--template-file tmp/packaged-functions.yml \
		--stack-name cloud9-functions \
		--capabilities CAPABILITY_IAM

gpu: tmp
	aws cloudformation package \
		--template-file stacks/gpu.yml \
		--s3-bucket cloud9-tmp \
		--s3-prefix cloudformation/gpu \
		--output-template-file tmp/packaged-gpu.yml

	aws cloudformation deploy \
		--template-file tmp/packaged-gpu.yml \
		--stack-name cloud9-gpu\
		--capabilities CAPABILITY_IAM

keypair: ~/.ssh/id_gateway

~/.ssh/id_gateway:
	sudo yum install -y jq
	aws ec2 create-key-pair --key-name gateway | jq -r '.KeyMaterial' > ~/.ssh/id_gateway
	chmod go-rwx ~/.ssh/id_gateway
