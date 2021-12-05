library(shiny)

# Define server logic required to draw a histogram
source("prediction.R")


shinyServer(function(input, output) {
    
    wordPrediction <- reactive({
        text <- input$textIn
        textInput <- inputCleaner(text)
        wordCount <- length(textInput)
        wordPrediction <- nextWordPrediction(wordCount,textInput)
        
        if (is.null(wordPrediction)) {
            
            wordPrediction <- "Please enter an input"
            
        }
    })
    
    
        
    
    
    output$predicted <- renderPrint(wordPrediction())
    #output$sentence <- renderText({input$textIn}, quoted = FALSE)
})
