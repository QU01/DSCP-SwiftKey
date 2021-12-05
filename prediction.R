library(shiny)
library(tm)
library(stringr)
library(markdown)
library(stylo)

qData <- readRDS(file="data/quadgram.rds")
tData <- readRDS(file="data/trigram.rds")
bData <- readRDS(file="data/bigram.rds")



dataCleaner <- function(text){
  
  cleanText <- tolower(text)
  cleanText <- removePunctuation(cleanText)
  cleanText <- removeNumbers(cleanText)
  cleanText <- str_replace_all(cleanText, "[^[:alnum:]]", " ")
  cleanText <- stripWhitespace(cleanText)
  
  return(cleanText)
}

inputCleaner <- function(text){
  
  textInput <- dataCleaner(text)
  textInput <- txt.to.words.ext(textInput, 
                                preserve.case = TRUE)
  
  return(textInput)
}

nextWordPrediction <- function(wordCount,textInput){
  
  if (wordCount>=4) {
    
    wordPrediction <- ""
    
    textInput <- tail(textInput, n=3)
    
    wordPrediction <- qData[qData$unigram==textInput[1] & 
                              qData$bigram==textInput[2] & 
                              qData$trigram==textInput[3],]
    
    wordPrediction <- wordPrediction[wordPrediction$freq == max(wordPrediction$freq),]$quadgram
    
    if (is.na(wordPrediction[1])){
      
      wordCount <- wordCount - 1
      
    }
    
  }
  
  
  
  if(wordCount == 3) {
  
    wordPrediction <- qData[qData$unigram==textInput[1] & 
                                           qData$bigram==textInput[2] & 
                                           qData$trigram==textInput[3],]
    
    wordPrediction <- wordPrediction[wordPrediction$freq == max(wordPrediction$freq),]$quadgram
    
    if (is.na(wordPrediction[1])){
      
      wordCount <- wordCount - 1
      
    }
  
  }
  
  if(wordCount == 2) {
    
    wordPrediction <- tData[tData$unigram==textInput[1] & 
                                           tData$bigram==textInput[2],]
    
    wordPrediction <- wordPrediction[wordPrediction$freq == max(wordPrediction$freq),]$trigram
    
    if (is.na(wordPrediction[1])){
      
      wordCount <- wordCount - 1
      
    }
  }
  
   if(wordCount == 1) {
    
    wordPrediction <- bData[bData$unigram==textInput[1],]
    
    wordPrediction <- wordPrediction[wordPrediction$freq == max(wordPrediction$freq),]$bigram
    

  }
  
  
  if (identical(wordPrediction, character(0))) {
    
    print("Sorry, there is any good prediction")
    
  } else {
    
    print(wordPrediction[1])
  }
}
