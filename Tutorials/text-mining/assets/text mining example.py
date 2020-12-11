#############################################
#=============Read in Libraries=============#
# Read in the necessary libraries.          #
#############################################

import pandas as pd
import matplotlib.pyplot as plt
import os
import regex

import nltk
#nltk.download('stopwords')
from nltk import word_tokenize, sent_tokenize
from nltk.corpus import stopwords
from nltk.stem import LancasterStemmer, WordNetLemmatizer, PorterStemmer

os.chdir(r'C:\Users\bryan\source\repos\msis5193-pds1-master\text-mining\data')


#################################################
#================Tutorial Data==================#
# Using airline data from Tiwtter               #
#################################################

tweets_data = pd.read_csv('tweets.csv')
tweets_data.columns

tweets_data.rename(columns={'text': 'tweettext'}, inplace=True)

#==========================================
# Adjust the case of the text so that all
# values are lowercase
#==========================================
tweets_data['tweettext'] = tweets_data['tweettext'].apply(lambda x: " ".join(x.lower() for x in x.split()))

tweets_data['tweettext'][2]

#=========================================
# Remove the numerical values as well as
# punctuation from the text.
#=========================================
patterndigits = '\\b[0-9]+\\b'
tweets_data['tweettext'] = tweets_data['tweettext'].str.replace(patterndigits,'')

patternpunc = '[^\w\s]'
tweets_data['tweettext'] = tweets_data['tweettext'].str.replace(patternpunc,'')

tweets_data['tweettext'][2]
tweets_data['tweettext'][5]

#=====================================
# Remove stop words from the data by
# using the dataset stop_words found
# in the nltk library
#=====================================
stop = stopwords.words('english')

# Before removal of stopwords
tweets_data['tweettext'][2]
tweets_data['tweettext'][5]

tweets_data['tweettext'] = tweets_data['tweettext'].apply(lambda x: " ".join(x for x in x.split() if x not in stop))

# After removal of stopwords
tweets_data['tweettext'][2]
tweets_data['tweettext'][5]

#=========================================
# Remove the airline names from the data
#=========================================
airline_names = ['americanair','southwestair','jetblue','virginamerica','usairways','united']

tweets_data['tweettext'] = tweets_data['tweettext'].apply(lambda x: " ".join(x for x in x.split() if x not in airline_names))

tweets_data['tweettext'][2]
tweets_data['tweettext'][5]

#======================================
# Stem the data using PorterStemmer()
#======================================
porstem = PorterStemmer()

tweets_data['tweettext'] = tweets_data['tweettext'].apply(lambda x: " ".join([porstem.stem(word) for word in x.split()]))

tweets_data['tweettext'][2]
tweets_data['tweettext'][5]

#================================
# Create a document-term matrix
#================================
from sklearn.feature_extraction.text import CountVectorizer
vectorizer = CountVectorizer()

tokens_data = pd.DataFrame(vectorizer.fit_transform(tweets_data['tweettext']).toarray(), columns=vectorizer.get_feature_names())

tokens_data.columns

# display all column names
print(tokens_data.columns.tolist())

# How many tweets mention delay more than once?
delayproblems = tokens_data[(tokens_data.delay>1)]
delayproblems['delay']
