library(shiny)
shinyUI(fluidPage(
  pageWithSidebar(
    # Application title
    headerPanel("Coursera Data Science Specialization - SwiftKey Capstone"),
    
    
    sidebarPanel(
      h4("Next Word prediction (July-August 2017)"),
      textInput('frase', 'Enter your sentence and press enter or click the prediction button', "I want to") ,
      submitButton('Predict potential next words')
    ), 
    mainPanel(
      p('Three potential next words are presented, obtained from the three text sources (blogs, news and tweets)'),
      p('Your sentence:'), verbatimTextOutput("frase"),
      p('The cleansed part of the sentence used for the prediction:'), verbatimTextOutput("frase2"),
      p('The predicted next word is:'), strong(verbatimTextOutput("result"))
      ))))
