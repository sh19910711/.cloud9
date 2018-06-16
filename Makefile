tmp:
	mkdir tmp

vpc: tmp
	aws cloudformation package \
		--template-file vpc.yml \
		--s3-bucket cloud9 \
		--s3-prefix cloudformation/vpc \
		--output-template-file tmp/packaged-vpc.yml

	aws cloudformation deploy \
		--template-file tmp/packaged-vpc.yml \
		--stack-name vpc \
		--capabilities CAPABILITY_IAM

cloud9: tmp
	aws cloudformation package \
		--template-file cloud9.yml \
		--s3-bucket cloud9 \
		--s3-prefix cloudformation/cloud9 \
		--output-template-file tmp/packaged-cloud9.yml

	aws cloudformation deploy \
		--template-file tmp/packaged-cloud9.yml \
		--stack-name cloud9 \
		--capabilities CAPABILITY_IAM

clean:
	aws cloudformation delete-stack --stack-name cloud9
	aws cloudformation delete-stack --stack-name vpc
