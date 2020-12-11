# This is a continuation of the previous tutorial.
# Run the code from the previous tutorial prior
# to running this tutorial

#############################################
#=============Read in Libraries=============#
# Read in the necessary libraries.          #
#############################################

import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

from sklearn.feature_extraction.text import CountVectorizer
from sklearn.decomposition import LatentDirichletAllocation
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.decomposition import NMF

from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report, confusion_matrix, accuracy_score, plot_confusion_matrix

#################################################
#==============Exploratory Analysis=============#
# Perform some exploratory analysis to better   #
# understand the sentiment within the data      #
#################################################
plot_size = plt.rcParams["figure.figsize"]
print(plot_size[0]) 
print(plot_size[1])

plot_size[0] = 8
plot_size[1] = 6
plt.rcParams["figure.figsize"] = plot_size 

# Tweets by airline
tweets_data.airline.value_counts().plot(kind='bar')

# Percentage of each sentiment type overall
tweets_data.airline_sentiment.value_counts().plot(kind='pie', autopct='%1.0f%%', colors=["red", "yellow", "green"])

# distribution of sentiment by airline
airline_sentiment = tweets_data.groupby(['airline', 'airline_sentiment']).airline_sentiment.count().unstack()

airline_sentiment.plot(kind='bar')

# view the average confidence level for the tweets belonging to three sentiment categories
sns.barplot(x='airline_sentiment', y='airline_sentiment_confidence' , data=tweets_data)


#################################################
#=================Topic Modeling================#
# Determine which tweets are grouped together   #
# based on content of tweets                    #
#################################################

# See https://stackabuse.com/python-for-nlp-topic-modeling/

#============================================
# Perform Latent Dirichlet Allocation (LDA)
#============================================
vectorizer = CountVectorizer(max_df=0.8, min_df=4, stop_words='english')

doc_term_matrix = vectorizer.fit_transform(tweets_data['tweettext'].values.astype('U'))

doc_term_matrix.shape
# Result: The DTM has 2,625 terms with 14,640 documents (i.e. tweets)

# Generate the LDA with 5 topics to divide
# the text into; set the seed to 35 so that
# we end up with the same result
LDA = LatentDirichletAllocation(n_components=5, random_state=35)
LDA.fit(doc_term_matrix)

# Retrieve words in the first topic
first_topic = LDA.components_[0]

# Sort the indexes according to probability 
# values using argsort()
top_topic_words = first_topic.argsort()[-10:]

# Output the words to the console screen
for i in top_topic_words:
    print(vectorizer.get_feature_names()[i])

# Print the 10 words with highest 
# probabilities for all five topics
for i,topic in enumerate(LDA.components_):
    print(f'Top 10 words for topic #{i}:')
    print([vectorizer.get_feature_names()[i] for i in topic.argsort()[-10:]])
    print('\n')

# Add a column in the dataset with the topic number
topic_values = LDA.transform(doc_term_matrix)
topic_values.shape
tweets_data['topic'] = topic_values.argmax(axis=1)

tweets_data.head()


#==================================================
# Perform Non-Negative Matrix Factorization (NMF)
#==================================================
tfidf_vect = TfidfVectorizer(max_df=0.8, min_df=5, stop_words='english')

doc_term_matrix2 = tfidf_vect.fit_transform(tweets_data['tweettext'].values.astype('U'))
# Results in 2,215 terms

nmf = NMF(n_components=5, random_state=42)

nmf.fit(doc_term_matrix2)

first_topic = nmf.components_[0]
top_topic_words = first_topic.argsort()[-10:]

for i in top_topic_words:
    print(tfidf_vect.get_feature_names()[i])

# Top 10 words for each topic
for i,topic in enumerate(nmf.components_):
    print(f'Top 10 words for topic #{i}:')
    print([tfidf_vect.get_feature_names()[i] for i in topic.argsort()[-10:]])
    print('\n')

# Add a column with the topic values. 
topic_values2 = nmf.transform(doc_term_matrix2)
tweets_data['topic2'] = topic_values2.argmax(axis=1)
tweets_data.head()


#################################################
#=======Sentiment Analysis Classification=======#
# Perform an analysis based on the sentiment    #
# contained within the airline dataset          #
#################################################

#============================================================================
# Create a term-frequency inverse-document-frequency (TF-IDF)
# matrix with sklearn:
# TF  = (Frequency of a word in the document)/(Total words in the document)
# IDF = Log((Total number of docs)/(Number of docs containing the word))
#============================================================================
features = tweets_data['tweettext']

# Use only the 2500 most frequently occurring terms
# Use only those terms that occur in a maximum of 80% of the documents
# but at least in 7 documents
vectorizer = TfidfVectorizer (max_features=2500, min_df=7, max_df=0.8, stop_words=stop)

processed_features = vectorizer.fit_transform(features).toarray()

#==========================================
# Generate a training and testing dataset
#==========================================
labels = tweets_data['airline_sentiment']

# Test dataset will be 20%
# Results in a training set of 80%
X_train, X_test, y_train, y_test = train_test_split(processed_features, labels, test_size=0.2, random_state=0)

# Train a machine learning model, randomforest, using
# the training dataset
text_classifier = RandomForestClassifier(n_estimators=200, random_state=0)
text_classifier.fit(X_train, y_train)

# Time to test the model using the predict() function
predictions = text_classifier.predict(X_test)


#===================================
# Evaluate the newly trained model
#===================================
cm = confusion_matrix(y_test,predictions)
print(cm)

plot_confusion_matrix(text_classifier, X_test, y_test)


print(classification_report(y_test,predictions))

print(accuracy_score(y_test, predictions))
# Result: Accuracy of 75.7%
