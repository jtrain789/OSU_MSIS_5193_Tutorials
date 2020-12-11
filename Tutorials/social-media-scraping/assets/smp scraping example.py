#################################################
#=================Twitter Data==================#
# Authenticate to Twitter using tokens and keys #
# and query data                                #
#################################################

import twitter

apikey = 'yourconsumersecret'
apisecretkey = 'yourconsumersecretkey'
accesstok = 'youraccesstoken'
accesstoksec = 'youraccesstokensecret'

twitconn = twitter.Api(consumer_key=apikey,
                       consumer_secret=apisecretkey,
                       access_token_key=accesstok,
                       access_token_secret=accesstoksec)

# Verify your credentials
twitconn.VerifyCredentials()

tweet1 = twitconn.GetSearch(raw_query='q=from%3ABYUfootball%20stadium')

tweet2 = twitconn.GetUserTimeline(screen_name='BYUfootball', count=30)

tweet2

for item in tweet2:
    print(item.text)


tweet3 = twitconn.GetSearch(raw_query='q=from%3ABYUfootball%20until%3A2019-09-27%20since%3A2019-09-01')

for item in tweet3:
    print(item.id, item.text)

tweet4 = twitconn.GetSearch(raw_query='q=from%3ABYUfootball', until='2019-09-27', since='2019-09-01')


twitteruser = 'BYUfootball'
tweet5 = twitconn.GetUserTimeline(screen_name=twitteruser,
                                  count=200,
                                  include_rts=False,
                                  exclude_replies=True)