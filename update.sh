# export AWS_PROFILE=SAME_PROFILE_AS_BEFORE

zip deploy.zip config.py messages.py run.py

aws lambda update-function-code \
	--function-name iHardlyKnowa-function \
	--zip-file fileb://./deploy.zip
