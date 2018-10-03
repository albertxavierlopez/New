#-----------Twitter sentiment analysis-----------------------

# Analysis over a Twitter, downloading it's tweets and getting a sentiment analysis on them

#  Install Requried Packages
install.packages("SnowballC")
install.packages("tm")
install.packages("twitteR")
install.packages("syuzhet")

# Load Requried Packages
library("SnowballC")
library("tm")
library("twitteR")
library("syuzhet")

# Invoking Twitter API using the keys and tokens. 
consumer_key <- '####'
consumer_secret <- '####'
access_token <- '####'
access_secret <- '####'

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

# In this case, we use input from @realDonaldTrump twitter account.
tweets <- userTimeline("FinancialTimes", n=200)
n.tweet <- length(tweets)

# Cleaning data with fucntion twListToDF (twitteR) that converts lists to data.frames
tweets.df <- twListToDF(tweets) 
head(tweets.df)

# Cleaning hashtags and URLs from text using gsub function
tweets.df2 <- gsub("http.*","",tweets.df$text)
tweets.df2 <- gsub("https.*","",tweets.df2)
tweets.df2 <- gsub("#.*","",tweets.df2)
tweets.df2 <- gsub("@.*","",tweets.df2)

head(tweets.df2)

# Sentiment score for each tweet.We will first try to get the emotion score for each of the tweets.
#‘Syuzhet’ breaks the emotion into 10 different emotions – anger, anticipation, disgust, fear, joy, sadness,
#surprise, trust, negative and positive.

word.df <- as.vector(tweets.df2)
emotion.df <- get_nrc_sentiment(word.df)        #function from syuzhet that calculates the presence of eight differents emotions
emotion.df2 <- cbind(tweets.df2, emotion.df)    #function to combine R objects by rows or columns
head(emotion.df2)

# Using get_sentiment fucntion to extract sentiment scores
sent.value <- get_sentiment(word.df)            #function from syuzhet. Iterates over a vector of strings and returns sentiment values based on user supplied method. 

  #Getting the most positive sentiment
  most.positive <- word.df[sent.value == max(sent.value)]
  most.positive
  
  #Getting the most negative sentiment
  most.negative <- word.df[sent.value <= min(sent.value)] 
  most.negative 

# To visualize scores for each tweet
sent.value
  
# Segregating positive and negative tweets
  positive.tweets <- word.df[sent.value > 0]
  head(positive.tweets)
  
  negative.tweets <- word.df[sent.value < 0] 
  head(negative.tweets)
  
  neutral.tweets <- word.df[sent.value == 0]
  head(neutral.tweets)

#--Alternate way to classify as Positive, Negative or Neutral tweets
category_senti <- ifelse(sent.value < 0, "Negative", ifelse(sent.value > 0, "Positive", "Neutral"))
head(category_senti)

# Summary (last 5 tweets)
head(category_senti)

# Final summary
table(category_senti)




