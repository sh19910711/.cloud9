tmp:
	mkdir tmp

vpc: tmp
	aws cloudformation package \
		--template-file vpc.yml \
		--s3-bucket cloud9-tmp \
		--s3-prefix cloudformation/vpc \
		--output-template-file tmp/packaged-vpc.yml

	aws cloudformation deploy \
		--template-file tmp/packaged-vpc.yml \
		--stack-name cloud9-vpc \
		--capabilities CAPABILITY_IAM

cloud9: tmp
	aws cloudformation package \
		--template-file cloud9.yml \
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
		--template-file functions.yml \
		--s3-bucket cloud9-tmp \
		--s3-prefix cloudformation/functions \
		--output-template-file tmp/packaged-functions.yml

	aws cloudformation deploy \
		--template-file tmp/packaged-functions.yml \
		--stack-name cloud9-functions \
		--capabilities CAPABILITY_IAM

gpu: tmp
	aws cloudformation package \
		--template-file gpu.yml \
		--s3-bucket cloud9-tmp \
		--s3-prefix cloudformation/gpu \
		--output-template-file tmp/packaged-gpu.yml

	aws cloudformation deploy \
		--template-file tmp/packaged-gpu.yml \
		--stack-name cloud9-gpu\
		--capabilities CAPABILITY_IAM

clean:
	aws cloudformation delete-stack --stack-name cloud9-gpu
