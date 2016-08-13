iHardlyKnowa!
---

Tool to regularly text someone a message using a Twilio SMS-enabled phone number and AWS Lambda, including full setup of the AWS permissions. I use it to send my roommate an "I hardly know'er!" joke once a day.

Usage:

First, create a `config.py` file, containing your Twilio information and desired phone numbers. Eg:

```python
TWILIO_SID = 'tH1sIS4f4k3s1d'
TWILIO_TOKEN = 'D0n7W0rrYth15i54ls0f4k3'
PHONE_FROM = '+12027421520'
PHONE_TO = '+12024561111'
```

Then, kick off the process!

```bash
export AWS_PROFILE=PROFILE_THAT_CAN_WRITE_ROLES_LAMBDAS_AND_CLOUDWATCH
export AWS_ACCOUNT_ID=123456789012
export LAMBDA_SCHEDULE_EXPRESSION="rate(1 day)"

bash deploy.sh
```

Want to update your list of messages?

```bash
export AWS_PROFILE=SAME_PROFILE_AS_BEFORE

bash update.sh
```
