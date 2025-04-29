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
                             actionButton("simulate", "plot")
                           ),
                           mainPanel(
                             plotlyOutput("plot")
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
  

  output$plot <- renderPlotly({
    input$simulate
      plot_ly(data = data(), x = ~get(input$x), y = ~get(input$y), color = ~get(input$color), type = "scatter", mode = "markers")
    })
}
shinyApp(ui, server)