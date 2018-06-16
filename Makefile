tmp:
	mkdir tmp

stack: tmp
	aws cloudformation package \
		--template-file cloud9.yml \
		--s3-bucket cloud9 \
		--s3-prefix cloudformation \
		--output-template-file tmp/packaged-cloud9.yml

	aws cloudformation deploy \
		--template-file tmp/packaged-cloud9.yml \
		--stack-name cloud9 \
		--capabilities CAPABILITY_IAM

clean:
	aws cloudformation delete-stack --stack-name cloud9
