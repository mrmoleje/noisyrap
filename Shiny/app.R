install.packages("rsconnect")

library(shiny)
library(rsconnect)

ui <- fluidPage(sliderInput(inputId = "number",
                            label = "Choose number of complaints",
                            value =25, min =1, max=1600),
                plotOutput("graph"))

server <- function(input, output) {
  output$graph <- renderPlot({
    title <- "NYC Noise Complaints graph"
    plot(rnorm(input$number), main=title())
    })
}

shinyApp(ui = ui, server = server)

#Add the app to IO

rsconnect::deployApp('C:/Users/Sof/Documents/noisyrap/Shiny')


