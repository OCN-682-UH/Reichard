#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(tidyverse)
library(plotly)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Car Data"),

    # Sidebar with a slider input for year 
    sidebarLayout(
        sidebarPanel(
            sliderInput("year",
                        "Year Manufactured:",
                        min = 1999,
                        max = 2008,
                        value = c(1999,2008),
                        sep = ""),
           #make a drop down to select the type of manufacturer
             selectInput("manufacturer",
                        "Select Manufacturer:",
                        choices = c("All", sort(unique(mpg$manufacturer))),
                        selected = "All"),
                        
            #make your own graph title
            textInput(inputId = "title",
                      label = "Write a Title",
                      value = "Graph Showing Car mpg for city and highway")
        ),

        
        # Show a plot of the generated distribution
        mainPanel(
           plotlyOutput("mpg_plot"),#creates space for a plot 
        br(),
        textOutput("data_summary") #tells you how much is currently plotted
           )
        
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  #create reactive data
   filtered_data <- reactive({
     data <- mpg
   
# filter by year
   data <- data %>% 
     filter(year >= input$year[1] & year <= input$year[2])
   
   #filter by manufacturer if not all
   if(input$manufacturer != "All") {
     data <- data %>% 
       filter(manufacturer == input$manufacturer)
   }
   data
   })
   
   #render a plot
   output$mpg_plot <- renderPlotly({
     plot_ly(filtered_data(),
             x = ~cty,
             y= ~hwy,
             type = "scatter",
             mode = "markers",
             marker = list(size = 10, color = "steelblue", opacity = 0.6),
             text = ~paste("Model:", model,
                          "<br>Manufacturer:", manufacturer,
                          "<br>Year:", year,
                          "<br>City MPG:", cty,
                          "<br>Highway MPG:", hwy),
             hoverinfo = 'text') %>% 
       layout(title = input$title,
              xaxis = list(title = "City MPG"),
              yaxis = list(title = "Highway MPG"))
   })
   
   #display summary of filtered data
   output$data_summary <- renderText({
     paste("Showing", nrow(filtered_data()), "vehicles")
   })
}

# Run the application 
shinyApp(ui = ui, server = server)
