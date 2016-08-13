import base64
import random
import urllib
import urllib2

from config import TWILIO_SID, TWILIO_TOKEN, PHONE_FROM, PHONE_TO
from messages import MESSAGES


def main(event, context):
    request = urllib2.Request('https://api.twilio.com/2010-04-01/Accounts/{}/Messages.json'.format(TWILIO_SID))
    base64string = base64.encodestring('{}:{}'.format(TWILIO_SID, TWILIO_TOKEN)).replace('\n', '')
    request.add_header("Authorization", "Basic {}".format(base64string))
    request.add_data(urllib.urlencode({
        'To': PHONE_TO,
        'From': PHONE_FROM,
        'Body': random.choice(MESSAGES)
    }))
    urllib2.urlopen(request)
