
library(shiny)
library(tidyverse)

ui <- fluidPage(
  #input functions 
  sliderInput(inputId = "num", #ID name for this slider
              label = "Chose a Number", #name that will be shown on app
              value = 25, min = 0, max = 100), #25 is what it will start at when open
  textInput(inputId = "title", #Id for this input
            label = "Write a title", #name for this input box user sees
            value = "Histogram of Random Normal Values"), 
  
  #output functions
plotOutput("hist"), #create space for a plot called hist
verbatimTextOutput("stats") #creates space for stats
  )

server <- function(input, output){
  output$hist <- renderPlot({
    data <- reactive({       #make a function with you data so it calls the same dataset for ui and server.
      tibble(x = rnorm(input$num))
    })
    
    ggplot(data(), aes(x = x)) +
      geom_histogram()+
      labs(title = input$title)
  })
  
  output$stats <- renderPrint({
    summary(data()) #calculate summary stats vased on the numbers inputed
  })
}

shinyApp(ui = ui, server = server)