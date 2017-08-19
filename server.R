library(shiny)
library(tm)
library(e1071)

load("predictor_b.RData")
load("predictor_n.RData")
load("predictor_t.RData")
load("unigram_levels_b.RData")
load("unigram_levels_n.RData")
load("unigram_levels_t.RData")

clean<-function(frase) {
  #frase<-removeWords(paraula, banned_words)
  frase2<-strsplit(frase, " ")[[1]]
  frase2<-as.character(tail(frase2,2))
  frase2<-paste(frase2, collapse=" ")
  frase2<-removeNumbers(frase2)
  frase2<-removePunctuation(frase2, preserve_intra_word_dashes = TRUE)
  frase2<-stripWhitespace(frase2)
  frase2<-tolower(frase2)
  return(frase2)
}

prediccio<-function(frase) {
  #frase<-removeWords(paraula, banned_words)
  frase2<-strsplit(frase, " ")[[1]]
  frase2<-as.character(tail(frase2,2))
  frase2<-paste(frase2, collapse=" ")
  frase2<-removeNumbers(frase2)
  frase2<-removePunctuation(frase2, preserve_intra_word_dashes = TRUE)
  frase2<-stripWhitespace(frase2)
  frase2<-tolower(frase2)
  split_par<-strsplit(frase2, split = " " )
  factor_par_b<-factor(unlist(split_par), levels = unigram_levels_b)
  df_par_b<-data.frame(X1 = factor_par_b[1], X2 = factor_par_b[2])
  factor_par_n<- factor(unlist(split_par), levels = unigram_levels_n)
  df_par_n<-data.frame(X1 = factor_par_n[1], X2 = factor_par_n[2])
  factor_par_t<-factor(unlist(split_par), levels = unigram_levels_t)
  df_par_t<-data.frame(X1 = factor_par_t[1], X2 = factor_par_t[2])
  result<-data.frame(predict(predictor_b, df_par_b), predict(predictor_n, df_par_n), predict(predictor_t, df_par_t))
  colnames(result)<-c("Blogs","News","Tweets")
  return(result)
}

shinyServer(
  function(input, output) {
    output$frase<-renderPrint({input$frase})
    output$frase2<-renderPrint({clean(input$frase)})
    output$result<-renderPrint({prediccio(input$frase)})
    
  } 
)
