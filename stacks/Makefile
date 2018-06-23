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
		--stack-name cloud9-vpc

cloud9: tmp
	aws cloudformation package \
		--template-file cloud9.yml \
		--s3-bucket cloud9-tmp \
		--s3-prefix cloudformation/cloud9 \
		--output-template-file tmp/packaged-cloud9.yml

	aws cloudformation deploy \
		--template-file tmp/packaged-cloud9.yml \
		--stack-name cloud9

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

instance: tmp
	aws cloudformation package \
		--template-file instance.yml \
		--s3-bucket cloud9-tmp \
		--s3-prefix cloudformation/instance \
		--output-template-file tmp/packaged-instance.yml

	aws cloudformation deploy \
		--template-file tmp/packaged-instance.yml \
		--stack-name cloud9-instance \
		--capabilities CAPABILITY_IAM

fargate_nginx: tmp
	aws cloudformation package \
		--template-file fargate/nginx.yml \
		--s3-bucket cloud9-tmp \
		--s3-prefix cloudformation/fargate/nginx \
		--output-template-file tmp/packaged-template.yml

	aws cloudformation deploy \
		--template-file tmp/packaged-template.yml \
		--stack-name cloud9-fargate-nginx

zeppelin: tmp
	aws cloudformation package \
		--template-file fargate/zeppelin.yml \
		--s3-bucket cloud9-tmp \
		--s3-prefix cloudformation/fargate/zeppelin \
		--output-template-file tmp/packaged-template.yml

	aws cloudformation deploy \
		--template-file tmp/packaged-template.yml \
		--stack-name cloud9-ecs-zeppelin
