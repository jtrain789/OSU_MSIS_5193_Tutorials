# Sentiment Analysis
Many techniques exist under NLP to overcome the many challenges of understanding the meaning of text. One such technique is *sentiment analysis*, which is a process that utilizes computational linguistics to quantify subjective text-based data based on emotional (i.e. positive, negative, neutral) or other categories with valences (i.e. strong, weak, powerful, powerless). This provides a means to determine the attitude, opinion, or view people have toward a product, service, organization, brand, politician, and anything else that is written about. 

For example, the most basic valence used in sentiment analysis is negative-positive. Companies can monitor Tweets, posts on Istagram or Facebook, or messages on a help forum. Each block of text is labeled as positive or negative based on the terms contained in the text, the relation of those terms, and the overall valence. 

For example, say Company A wants to understand consumer's position on a new coffee flavor it just launched. First, Company A would collect the text and store it in a database. Second, a text mining program would assign a label of positive, neutral, or negative to each term for a given record in the database. Third, using the context of the term, the valence may be adjusted. Fourth, an overall score is assigned to each record. 

If a Tweet about the coffee contains 4 negative words and 7 positive words about the service Company A provides, then the overall attitude would be positive. Looking at all the text Company A obtains, an overall sentiment or attitude is given for their new coffee. What's more, if a small segment does not like the product, Company A can evaluate the text for why consumers may not like it, make adjustments, and offer up a new product for that segment.

The valence of positive-negative is not the only one available. Many other types exist, such as strong-weak, pleasure-pain, and active-passive. For sentiment analysis, these valences are stored in psycho-social dictionaries. A *psycho-social dictionary* contains words or terms and their associated attitudes. As an example, *deprive* is labeled as **negative** and **strong**. The word *destitute* is labeled as **negative** and **weak**. 

This website [wjh.harvard.edu](http://wjh.harvard.edu/~inquirer/homecat.htm) contains a lot of different psycho-social dictionaries. Examples of other types of attitudes include militaristic, political, distance/time, religious, legal. Take some time to peruse this page.

Most dictionaries use a binary score for each label. Either a word is positive or it is not. It is weak or it is not. While useful, this does not provide a rich or detailed analysis if you would like to use advanced statistical modeling. If you plan on using advanced methods, try to find a psycho-social dictionary that provides a continuous scale instead of binary scores. A continuous scale for positive would include something like the following:
* Strongly positive
* Moderately positive
* Neutral
* Not moderately positive
* Not strongly positive

# Tutorials for R and Python
Are you ready to learn more about sentiment analysis? These tutorials for R and Python will provide examples of how to perform sentiment analysis.
* [Sentiment Analysis in R](assets/tutorial%20sentiment%20analysis%20in%20r.md)
* [Sentiment Analysis in Python](assets/tutorial%20sentiment%20analysis%20in%20python.md)

The accompanying example script files are found here:
1. [Example R file](assets/sentiment%20analysis%20example.R)
2. [Example Python file](assets/sentiment%20analysis%20example.py)
