#==================================================
# Most available data and information come in the
# form of unstructured text. You can analyze this
# text to gain insights into a phenomenon of
# interest 
#==================================================

#install.packages('tidytext')
#install.packages('SnowballC')
#install.packages('tm')

library(tidyverse)
library(tidytext)

#Stemming packages
library(SnowballC)
#library(hunspell)
#library(proustr)

library(tm)


#####################################################
#============Setup the Working Directory============#
# Set the working directory to the project folder by#
# running the appropriate code below.               #
#####################################################

wd = "C:\\Users\\bryan\\source\\repos\\msis5193-pds1-master\\text-mining\\data"

setwd(wd)


#################################################
#================Tutorial Data==================#
# Using airline data from Tiwtter               #
#################################################

temptable = paste(wd, "\\tweets.csv", sep = "")
tweets_data = read.csv(temptable, header = TRUE)

summary(tweets_data)


airline_tweets = select(tweets_data, text, airline_sentiment)

tidy_dataset = unnest_tokens(airline_tweets, word, text)

counts = count(tidy_dataset, word)

result1 = arrange(counts, desc(n))

#===============================
# Alternative using pipe symbol
airline_tweets = tweets_data %>% 
  select(text, airline_sentiment)

tidy_dataset = airline_tweets %>%
  unnest_tokens(word, text)

# Count the most popular words
tidy_dataset %>%
  count(word) %>%
  arrange(desc(n))


#=====================================
# Remove stop words from the data by
# using the dataset stop_words found
# in the tidytext package
#=====================================
data("stop_words")

tidy_dataset2 = anti_join(tidy_dataset, stop_words)

counts2 = count(tidy_dataset2, word)

arrange(counts2, desc(n))

# Alternative using pipe symbol
data("stop_words")

tidy_dataset2 = tidy_dataset %>%
  anti_join(stop_words)

tidy_dataset2 %>%
  count(word) %>%
  arrange(desc(n))

# An advantage of tidytext is that it removes punctuation automatically.

#==============================================
# Remove the numerical values from the column 
# word. tidytext automatically makes all 
# words lower case, no conversion necessary.
#==============================================
patterndigits = '\\b[0-9]+\\b'

# Use regex
tidy_dataset2$word = str_replace_all(tidy_dataset2$word, patterndigits, '')

counts3 = count(tidy_dataset2, word)

arrange(counts3, desc(n))

# Alternative
tidy_dataset2$word = tidy_dataset2$word %>%
  str_replace_all(patterndigits, '')

tidy_dataset2 %>%
  count(word) %>%
  arrange(desc(n))


#=======================================
# Replace all new lines, tabs, and
# blank spaces with a value of nothing
# and then filter out those values
#=======================================

tidy_dataset2$word = str_replace_all(tidy_dataset2$word, '[:space:]', '')

tidy_dataset3 = filter(tidy_dataset2,!(word == ''))

counts4 = count(tidy_dataset3, word)

arrange(counts4, desc(n))

# Alternative
tidy_dataset2$word = tidy_dataset2$word %>%
  str_replace_all('[:space:]', '')

tidy_dataset3 = tidy_dataset2 %>% 
  filter(!(word == ''))

tidy_dataset3 %>%
  count(word) %>%
  arrange(desc(n))


#==============================
# Plot the the words with a
# proportion greater than 0.5
#==============================
frequency = tidy_dataset3 %>%
  count(word) %>%
  arrange(desc(n)) %>%
  mutate(proportion = (n / sum(n)*100)) %>%
  filter(proportion >= 0.5)

library(scales)

ggplot(frequency, aes(x = proportion, y = word)) +
  geom_abline(color = "gray40", lty = 2) +
  geom_jitter(alpha = 0.1, size = 2.5, width = 0.3, height = 0.3) +
  geom_text(aes(label = word), check_overlap = TRUE, vjust = 1.5) +
  scale_color_gradient(limits = c(0, 0.001), low = "darkslategray4", high = "gray75") +
  theme(legend.position="none") +
  labs(y = 'Word', x = 'Proportion')


#=======================
# Remove airline names
#=======================
list_remove = c("southwestair","jetblue","united","virginamerica",
         "americanair","usairways","http","t.co")

tidy_dataset3 = filter(tidy_dataset3, !(word %in% list_remove))

# Alternative
tidy_dataset3 = tidy_dataset3 %>%
  filter(!(word %in% list_remove))


#=======================================
# Using the SnowballC package, run the
# function wordStem() on the data to
# apply stemming to the data
#=======================================
tidy_dataset4 = mutate_at(tidy_dataset3, "word", funs(wordStem((.), language="en")))

counts5 = count(tidy_dataset4, word)

arrange(counts5, desc(n))

# Alternative
tidy_dataset4 = tidy_dataset3 %>%
  mutate_at("word", funs(wordStem((.), language="en")))

tidy_dataset4 %>%
  count(word) %>%
  arrange(desc(n))
# Result: flight is now #1, not #2

frequency2 = tidy_dataset4 %>%
  count(word) %>%
  arrange(desc(n)) %>%
  mutate(proportion = (n / sum(n)*100)) %>%
  filter(proportion >= 0.5)

ggplot(frequency2, aes(x = proportion, y = word)) +
  geom_abline(color = "gray40", lty = 2) +
  geom_jitter(alpha = 0.1, size = 2.5, width = 0.3, height = 0.3) +
  geom_text(aes(label = word), check_overlap = TRUE, vjust = 1.5) +
  scale_color_gradient(limits = c(0, 0.001), low = "darkslategray4", high = "gray75") +
  theme(legend.position="none") +
  labs(y = 'Word', x = 'Proportion')

# Could group data by airlines and then compare the types
# and proportions of words; would be interesting to see
# which airlines has delays more often

#===================================
# Construct a document-term matrix
# for further analysis
#===================================
tidy_tdm = tidy_dataset4 %>%
  count(airline_sentiment, word) %>%
  cast_dtm(airline_sentiment, word, n)
