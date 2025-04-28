library(shiny)
library(shinythemes)

ui <- fluidPage(theme= shinytheme("united"),
                navbarPage(
                  "My Shiny App",
                  tabPanel("tab 1",
                           sidebarPanel(
                             fileInput("upload", "Upload csv file", accept = ".csv")
                           ),
                           mainPanel(
                             tableOutput("head")
                           )
                  ),
                  tabPanel("tab 2",
                           sidebarPanel(
                             sliderInput("numSlider", "Select a value:", min = 0, max = 6, value = 1.5)
                           ),
                           mainPanel(
                             plotOutput("plot")
                           )
                  )
                ))

server <- function(input, output, session) {
  data <- reactive({
    req(input$upload)
    read.csv(input$upload$datapath)
  })
  
  output$head <- renderTable({
    head(data(), 10)
  })
  
  output$axisx <- renderUI({
    req(input$upload)
    selectInput('x', 'X', names(data()))
  })
  output$axisy <- renderUI({
    req(input$upload)
    selectInput('y', 'Y', names(data()))
  })

  output$plot <- reactive({
    req(input$upload)
    renderPlot({ggplot2::ggplot(data=data[data$carat<input$numSlider,], 
                                   aes(x=carat, y=price, colour= clarity))})})
}
shinyApp(ui, server)