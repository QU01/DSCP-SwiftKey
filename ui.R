library(shiny)
library(shinythemes)


# Define UI for application that draws a histogram
shinyUI( 
    
    fluidPage(
        h1("Swift Key"),
        sidebarLayout(
            sidebarPanel(
                textInput("textIn", h3("Insert Text", value = "Enter text: "))
            ),
            mainPanel(
                img(src = "https://play-lh.googleusercontent.com/-T9LWvUtdAT4faOMnIOy0oInlZNPYquWJLFE1P0kL_R-WQvCK3nIdkqtZMkiHdCk9seW", heigth = 200, width = 200),
                h3("The predicted word is:"),
                h1(textOutput("predicted"))
            )
        )
    )

)
