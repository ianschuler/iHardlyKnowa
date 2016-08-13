# export AWS_PROFILE=PROFILE_WITH_REGION_THAT_CAN_WRITE_ROLES_LAMBDAS_AND_CLOUDWATCH
# export AWS_ACCOUNT_ID=123456789012
# export LAMBDA_SCHEDULE_EXPRESSION="rate(1 day)"

zip deploy.zip config.py messages.py run.py

aws iam create-role \
	--role-name iHardlyKnowa-role \
	--assume-role-policy-document file://./iHardlyKnowa-role.json

sleep 2s

aws iam put-role-policy \
	--role-name iHardlyKnowa-role \
	--policy-name iHardlyKnowa-policy \
	--policy-document file://./iHardlyKnowa-policy.json

sleep 2s

aws lambda create-function \
	--function-name iHardlyKnowa-function \
	--runtime python2.7 \
	--role arn:aws:iam::${AWS_ACCOUNT_ID}:role/iHardlyKnowa-role \
	--handler run.main \
	--zip-file fileb://./deploy.zip

aws lambda add-permission \
	--function-name iHardlyKnowa-function \
	--statement-id iHardlyKnowa-sid \
	--action 'lambda:InvokeFunction' \
	--principal events.amazonaws.com \
	--source-arn "arn:aws:events:us-east-1:${AWS_ACCOUNT_ID}:rule/iHardlyKnowa-rule"

aws events put-rule \
	--name iHardlyKnowa-rule \
	--schedule-expression "${LAMBDA_SCHEDULE_EXPRESSION}"

aws events put-targets \
	--rule iHardlyKnowa-rule \
	--targets '{"Id" : "1", "Arn": "arn:aws:lambda:us-east-1:'${AWS_ACCOUNT_ID}':function:iHardlyKnowa-function"}'
