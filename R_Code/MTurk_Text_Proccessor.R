library(tidyverse)
library(tm) # Will use to create corpus and modify text therein.
library(SnowballC) # Will use for "stemming." 
library("wordcloud")
library("RColorBrewer")
setwd("/Users/fleminggoolsby/PycharmProjects/TechRoadmappingScraper/Results/")
MturkServices = read.csv("MturkServices.csv", stringsAsFactors = FALSE)

corpus = Corpus(VectorSource(MturkServices$Titles)) # An array of document
corpus

corpus[[1]]   # individual doc
strwrap(corpus[[1]])
strwrap(corpus[[3]])

corpus = tm_map(corpus, tolower)

corpus <- tm_map(corpus, removePunctuation)
strwrap(corpus[[1]])

corpus = tm_map(corpus, removeWords, stopwords("english"))
stopwords("english")[1:10]
("english")[1:10]
strwrap(corpus[[1]])
corpus = tm_map(corpus, stemDocument)
# We have: 
strwrap(corpus[[1]])
frequencies = DocumentTermMatrix(corpus)
sparse = removeSparseTerms(frequencies, 0.99)  

document_terms = as.data.frame(as.matrix(sparse))
str(document_terms)

freqencies_NUM = c()
words = colnames(document_terms)
for (col in 1:ncol(document_terms)) {
  freqencies_NUM = append(freqencies_NUM,sum(document_terms[col,]))
}

wordcloud(words = words, freq = freqencies_NUM, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

