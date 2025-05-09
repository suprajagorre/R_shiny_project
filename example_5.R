




library(shiny)
library(shinythemes)
library(ggplot2)

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
                             selectInput("x", "X", choices = NULL),
                             selectInput("y", "Y", choices = NULL),
                             selectInput("color", "color", choices = NULL),
                             actionButton("simulate", "plot",class = "btn-success")
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
  
  observeEvent(data(), {
    choices <- names(data())
    updateSelectInput(inputId = "x", choices = choices)
    updateSelectInput(inputId = "y", choices = choices)
    updateSelectInput(inputId = "color", choices = choices)
  })
  
  
  output$plot <- renderPlot({
    if(input$simulate>0){
      ggplot(data=data(), 
             aes(x=get(input$x), y=get(input$y), colour= get(input$color))) + 
        geom_point(alpha=0.1) +
        geom_smooth()
    }})
}
shinyApp(ui, server)