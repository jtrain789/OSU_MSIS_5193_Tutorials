#############################################
#=============Read in Libraries=============#
# Read in the necessary libraries.          #
#############################################

import pandas as pd
import numpy as np
import os
import requests
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import nltk
from nltk.stem import PorterStemmer
#nltk.download('punkt')
#nltk.download('averaged_perceptron_tagger')
#nltk.download('maxent_ne_chunker')
#nltk.download('words')

from nltk import word_tokenize, pos_tag, ne_chunk
from nltk.chunk import conlltags2tree, tree2conlltags


#####################################################
#============Setup the Working Directory============#
# Set the working directory to the project folder by#
# running the appropriate code below.               #
#####################################################

# home
os.chdir('C:\\Users\\bryan\\OneDrive - Oklahoma State University\\Teaching\\MSIS 5193 4623 - Programming Data 1\\Data')

# office
os.chdir('C:\\Users\\bryan\\OneDrive - Oklahoma A and M System\\Teaching\\MSIS 5193 4623 - Programming Data 1\\Data')


#################################################
#================Tutorial Data==================#
# Scrape data from webpage on Wikipedia         #
#################################################

#=================
# Simple example
#=================
sentence = "Andy and Bryan are living in Stillwater, Oklahoma working at Oklahoma State University."
 
print(ne_chunk(pos_tag(word_tokenize(sentence))))

#===============================
# Wikipedia page on Bill Gates
#===============================
wiki_url = "https://en.wikipedia.org/wiki/Bill_Gates"

driver = webdriver.Firefox(executable_path=r'C:\Users\bryan\Documents\Visual Studio 2019\geckodriver.exe')
driver.get(wiki_url)

para1 = driver.find_element_by_xpath('/html/body/div[3]/div[3]/div[4]/div/p[2]')
para2 = driver.find_element_by_xpath('/html/body/div[3]/div[3]/div[4]/div/p[3]')
para3 = driver.find_element_by_xpath('/html/body/div[3]/div[3]/div[4]/div/p[4]')
para4 = driver.find_element_by_xpath('/html/body/div[3]/div[3]/div[4]/div/p[5]')
para5 = driver.find_element_by_xpath('/html/body/div[3]/div[3]/div[4]/div/p[6]')

textbank = para1.text + para2.text + para3.text + para4.text + para5.text

driver.quit()

#======================
# Tokenize using POST
#======================
post1 = pos_tag(word_tokenize(textbank))
print(post1)

#===============================
# Use the Named Entity Chunker
#===============================
tree1 = ne_chunk(post1)
print(tree1)

entityp = []
entityo = []
entityg = []
entitydesc = []

for x in str(tree1).split('\n'):
    if 'PERSON' in x:
        entityp.append(x)
    elif 'ORGANIZATION' in x:
        entityo.append(x)
    elif 'GPE' in x or 'GSP' in x:
        entityg.append(x)
    elif '/NN' in x:
        entitydesc.append(x)

entityp
entityo
entityg
entitydesc

#================================
# Convert NE tree and add IOB
# tags; the output then becomes
# (word, tag, IOB-tag)
#================================
iob_tag = tree2conlltags(tree1)
print(iob_tag)


#################################################
#================Tutorial Data==================#
# Using airline data from Tiwtter               #
#################################################

#===============================================
# These steps come from the previous tutorials
#===============================================
tweets_data = pd.read_csv('tweets.csv')

tweets_data.rename(columns={'text': 'tweettext'}, inplace=True)

tweets_data['tweettext'] = tweets_data['tweettext'].apply(lambda x: " ".join(x.lower() for x in x.split()))

patterndigits = '\\b[0-9]+\\b'
tweets_data['tweettext'] = tweets_data['tweettext'].str.replace(patterndigits,'')

patternpunc = '[^\w\s]'
tweets_data['tweettext'] = tweets_data['tweettext'].str.replace(patternpunc,'')

porstem = PorterStemmer()

tweets_data['tweettext'] = tweets_data['tweettext'].apply(lambda x: " ".join([porstem.stem(word) for word in x.split()]))

#===========================================
# Tokenize using POST and use NER chunker;
# this could take a lot of processing, 
# depending on the length of the data
#===========================================
tweets_data['NN'] = ''
tweets_data['JJ'] = ''
tweets_data['VB'] = ''
tweets_data['GEO'] = ''

def tweet_ner(chunker):
    treestruct = ne_chunk(pos_tag(word_tokenize(chunker)))
    entitynn = []
    entityjj = []
    entityg_air = []
    entityvb = []
    for y in str(treestruct).split('\n'):
        if 'GPE' in y or 'GSP' in y:
            entityg_air.append(y)
        elif '/VB' in y:
            entityvb.append(y)
        elif '/NN' in y:
            entitynn.append(y)
        elif '/JJ' in y:
            entityjj.append(y)
    stringnn = ''.join(entitynn)
    stringjj = ''.join(entityjj)
    stringvb = ''.join(entityvb)
    stringg = ''.join(entityg_air)
    return stringnn, stringjj, stringvb, stringg

i = 0
for x in tweets_data['tweettext']:
    entitycontainer = tweet_ner(x)
    tweets_data.at[i,'NN'] = entitycontainer[0]
    tweets_data.at[i,'JJ'] = entitycontainer[1]
    tweets_data.at[i,'VB'] = entitycontainer[2]
    tweets_data.at[i,'GEO'] = entitycontainer[3]
    i += 1


tweets_data['NN'].unique().tolist()
tweets_data['JJ'].unique().tolist()
tweets_data['VB'].unique().tolist()
tweets_data['GEO'].unique().tolist()

# Result: entityg_air/GEO results in no values