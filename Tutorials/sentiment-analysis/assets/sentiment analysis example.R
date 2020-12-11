#=============================================
# Run Tutorial 15 prior to running this code
#=============================================

#install.packages('wordcloud')
#install.packages('udpipe')
#install.packages('textdata') #to install nrc lexicon

library(wordcloud)
library(udpipe)
library(lattice)


#################################################
#==============Sentiment Analysis===============#
# Conduct various assessments to understand the #
# sentiment of tweets related to the airline    #
# industry                                      #
#################################################

#===============================================
# Visualization of sentiment for each airlines
#===============================================
ggplot(tweets_data, aes(x = airline_sentiment, fill = airline_sentiment)) +
  geom_bar() +
  facet_grid(. ~ airline) +
  theme(axis.text.x = element_text(angle=65, vjust=0.6),
       plot.margin = unit(c(3,0,3,0), "cm"))

#================================================
# The Most Frequent Words in Positive Sentiment
# Generate a wordcloud, then a bar chart
#================================================
positive = tidy_dataset4 %>% 
  filter(airline_sentiment == "positive")

head(positive)

wordcloud(positive[,2],
          max.words = 100,
          random.order=FALSE, 
          rot.per=0.30, 
          use.r.layout=FALSE, 
          colors=brewer.pal(2, "Blues"))

# Fewer "positive" terms with high frequency
counts5 = count(positive, word, sort = TRUE)
counts5 = rename(counts5, freq = n)
positive2 = top_n(counts5, 21)

positive2

# Alternative with piping
positive2 = positive %>%
  count(word, sort = TRUE) %>%
  rename(freq = n) %>%
  top_n(21)

positive2
# Note: the text ðÿ is an emoticon smiley in Twitter

colourCount = length(unique(positive2$word))

getPalette = colorRampPalette(brewer.pal(9, "Set1"))

positive2 %>%
  mutate(word = reorder(word, freq)) %>%
  ggplot(aes(x = word, y = freq)) +
  geom_col(fill = getPalette(colourCount)) +
  coord_flip()

#================================================
# The Most Frequent Words in Negative Sentiment
# Generate a wordcloud, then a bar chart
#================================================
negative = tidy_dataset4 %>% 
  filter(airline_sentiment == "negative") 

wordcloud(negative[,2],
          max.words = 100,
          random.order=FALSE, 
          rot.per=0.30, 
          use.r.layout=FALSE, 
          colors=brewer.pal(2, "Reds"))

# Fewer "negative" terms with high frequency
counts6 = count(negative, word, sort = TRUE)
counts6 = rename(counts6, freq = n)
negative2 = top_n(counts6, 21)

# Alternative with Piping
negative2 = negative %>%
  count(word, sort = TRUE) %>%
  rename(freq = n) %>%
  top_n(21)

colourCount = length(unique(negative2$word))

getPalette = colorRampPalette(brewer.pal(8, "Dark2"))

negative2 %>%
  mutate(word = reorder(word, freq)) %>%
  ggplot(aes(x = word, y = freq)) +
  geom_col(fill = getPalette(colourCount)) +
  coord_flip()


#===================================
# Preview the available sentiments
# in the NRC dictionary
#===================================
get_sentiments('bing') %>%
  distinct(sentiment)

get_sentiments('nrc') %>%
  distinct(sentiment)


#=================================================
# Sentiment Lexicon: Pull the sentiment from 
# the text using the Bing Liu and collaborators
# lexicon.
# 1) Retrieve words with sentiment scores
# 2) Generate count of positive & negative words
# 3) Spread out data to place positive and nega-
# tive sentiment in separate columns
# 4) Calculate the difference between the total
# positive words and total negative words
#=================================================
newjoin = inner_join(tidy_dataset4, get_sentiments('bing'))
counts7 = count(newjoin, sentiment)
spread1 = spread(counts7, sentiment, n, fill = 0)
(mutate(spread1, diffsent = positive - negative))

# Alternative
tidy_dataset4 %>%
  inner_join(get_sentiments('bing')) %>% 
  count(sentiment) %>% 
  spread(sentiment, n, fill = 0) %>% 
  mutate(diffsent = positive - negative)


#======================================
# Generate a joy/sadness lexicon
# and merge with the data.
# This assesses the overall sentiment
# for all our tweets, not individual
# tweets
#======================================
nrc_joysad = get_sentiments('nrc') %>%
  filter(sentiment == 'joy' | 
           sentiment == 'sadness')

nrow(nrc_joysad)

newjoin2 = inner_join(tidy_dataset4, nrc_joysad)
counts8 = count(newjoin2, word, sentiment)
spread2 = spread(counts8, sentiment, n, fill = 0)
content_data = mutate(spread2, contentment = joy - sadness, linenumber = row_number())
tweet_joysad = arrange(content_data, desc(contentment))

# Alternative
(tweet_joysad = tidy_dataset4 %>%
  inner_join(nrc_joysad) %>%
  count(word, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(contentment = joy - sadness, linenumber = row_number()) %>%
  arrange(desc(contentment)))

ggplot(tweet_joysad, aes(x=linenumber, y=contentment)) +
  coord_flip() +
  theme_light(base_size = 15) +
  labs(
    x='Index Value',
    y='Contentment'
  ) +
  theme(
    legend.position = 'none',
    panel.grid = element_blank(),
    axis.title = element_text(size = 10),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10)
  ) +
  geom_col()

# Adjustments to the figure to improve
# visualization
(tweet_joysad2 = tweet_joysad %>%
    slice(1:10,253:262))
  
ggplot(tweet_joysad2, aes(x=linenumber, y=contentment, fill=word)) +
  coord_flip() +
  theme_light(base_size = 15) +
  labs(
    x='Index Value',
    y='Contentment'
  ) +
  theme(
    legend.position = 'bottom',
    panel.grid = element_blank(),
    axis.title = element_text(size = 10),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10)
  ) +
  geom_col()


#================================
# Generate a trust/fear lexicon
# and merge with the data
#================================
nrc_trstfear = get_sentiments('nrc') %>%
  filter(sentiment == 'trust' |
           sentiment == 'fear')

nrow(nrc_trstfear)

(tweet_trstfear = tidy_dataset4 %>%
  inner_join(nrc_trstfear) %>%
  count(word, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(trustworthy = trust - fear, linenumber = row_number()) %>%
  arrange(desc(trustworthy)) %>%
  slice(1:10,348:357))

ggplot(tweet_trstfear, aes(x=linenumber, y=trustworthy, fill=word)) +
  coord_flip() +
  theme_light(base_size = 15) +
  labs(
    x='Index Value',
    y='Trustworthiness'
  ) +
  theme(
    legend.position = 'bottom',
    panel.grid = element_blank(),
    axis.title = element_text(size = 10),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10)
  ) +
  geom_col()

# Result: the term with the greatest occurrences is
# gate, which normally appears in a tweet when a
# customer complains about a transaction or a
# poor experience with customer service

airline_tweets %>%
  filter(str_detect(text, 'gate|Gate')) %>%
  select(text)

# Wordcloud contrasting both sides
library(reshape2)
tidy_dataset4 %>%
  inner_join(nrc_trstfear) %>%
  count(word, sentiment) %>%
  slice(1:40,318:357) %>%
  acast(word~sentiment, value.var='n',fill=0) %>%
  comparison.cloud(colors=c('gray30','gray70'))

#################################################
#============Part of Speech Tagging=============#
# Conduct various assessments to understand the #
# sentiment of tweets related to the airline    #
# industry                                      #
#################################################

# Download if necessary
#ud_model = udpipe_download_model(language = "english")

tidy_post1 = tidy_dataset4 %>% 
                select(word)

ud_model = udpipe_load_model(ud_model$file_model)

tagging_data = as.data.frame(udpipe_annotate(ud_model, x = tidy_post1$word))


#==================================
# Basic POST frequency statistics
#==================================
post_stats = txt_freq(tagging_data$upos)

post_stats$key = factor(post_stats$key, levels = rev(post_stats$key))

ggplot(post_stats, aes(x=key, y=as.factor(freq), fill=key)) +
  coord_flip() +
  theme_light(base_size = 15) +
  labs(
    x='Frequency',
    y='',
    title='UPOS (Universal Parts of Speech)'
  ) +
  theme(
    legend.position = 'none',
    panel.grid = element_blank(),
    axis.title = element_text(size = 10),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10),
    title = element_text(size = 13)
  ) +
  geom_col() +
  scale_fill_grey()


#======================
# Most Occuring NOUNS
#======================
noun_stats = subset(tagging_data, upos %in% c("NOUN"))

noun_stats2 = txt_freq(noun_stats$token)

noun_stats2$key = factor(noun_stats2$key, levels = rev(noun_stats2$key))

noun_stats2 %>%
  slice(1:20) %>%
  ggplot(aes(x=key, y=as.factor(freq), fill=freq)) +
  coord_flip() +
  theme_light(base_size = 15) +
  labs(
    x='Frequency',
    y='',
    title='Noun Occurrences'
  ) +
  theme(
    legend.position = 'none',
    panel.grid = element_blank(),
    axis.title = element_text(size = 10),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10),
    title = element_text(size = 13)
  ) +
  scale_fill_gradient(low="orange", high="orange3") +
  geom_col()

#===========================
# Most Occuring ADJECTIVES
#===========================
adjstats = subset(tagging_data, upos %in% c("ADJ"))

adjstats2 = txt_freq(adjstats$token)

adjstats2$key = factor(adjstats2$key, levels = rev(adjstats2$key))

adjstats2 %>%
  slice(1:20) %>%
  ggplot(aes(x=key, y=as.factor(freq), fill=freq)) +
  coord_flip() +
  theme_light(base_size = 15) +
  labs(
    x='Frequency',
    y='',
    title='Adjective Occurrences'
  ) +
  theme(
    legend.position = 'none',
    panel.grid = element_blank(),
    axis.title = element_text(size = 10),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10),
    title = element_text(size = 13)
  ) +
  scale_fill_gradient(low="chartreuse", high="chartreuse3") +
  geom_col()


#======================
# Most Occuring VERBS
#======================
verbstats = subset(tagging_data, upos %in% c("VERB"))

verbstats2 = txt_freq(verbstats$token)

verbstats2$key = factor(verbstats2$key, levels = rev(verbstats2$key))

verbstats2 %>%
  slice(1:20) %>%
  ggplot(aes(x=key, y=as.factor(freq), fill=freq)) +
  coord_flip() +
  theme_light(base_size = 15) +
  labs(
    x='Frequency',
    y='',
    title='Verb Occurrences'
  ) +
  theme(
    legend.position = 'none',
    panel.grid = element_blank(),
    axis.title = element_text(size = 10),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 10),
    title = element_text(size = 13)
  ) +
  scale_fill_gradient(low="tan", high="tan3") +
  geom_col()

#===============
# What about X?
#===============
xstats = subset(tagging_data, upos %in% c("X"))

xstats2 = txt_freq(xstats$token)

xstats2$key = factor(xstats2$key, levels = rev(xstats2$key))

xstats2$key

# Contains hashtags, abbreviations, and Twitter account usernames.