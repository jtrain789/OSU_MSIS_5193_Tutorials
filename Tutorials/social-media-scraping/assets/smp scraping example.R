#####################################################
#===============Connect to Twitter==================#
# Connect to Twitter API using your authentication  #
# credentials obtained from Twitter dev             #
#####################################################

library(twitteR)

consumer_key = "yourconsumerkey"
consumer_secret = "yourconsumersecretkey"
access_token = "youraccesstoken"
access_secret = "youraccesssecret"

setup_twitter_oauth(consumer_key, 
                    consumer_secret, 
                    access_token, 
                    access_secret)

tweet1 = searchTwitter(searchString = 'from:BYUfootball+stadium')

tweet1

tweet2 = searchTwitter(searchString = 'byu+football+jersey+until:2019-09-20+since:2019-09-01', n=20)

tweet2

tweet3 = searchTwitter(searchString = 'BYU+football', resultType = 'popular')

tweet3