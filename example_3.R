library(shiny)
library(shinythemes)
library(plotly)

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
                             actionButton("simulate", "plot",class = "btn-success"),
                             actionButton("summary", "Click me for summary",class = "btn-success")
                           ),
                           mainPanel(
                             plotlyOutput("plot"),
                             textOutput("text"),
                             verbatimTextOutput("code")
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
    if(input$simulate>0){
      plot_ly(data = data(), x = ~get(input$x), y = ~get(input$y), color = ~get(input$color), type = "scatter", mode = "markers")
    }})
  
    output$text <- renderText({
      if(input$summary>0){
      "Here is the summary"
    }})
    output$code <- renderPrint({
      if(input$summary>0){
      summary(data())
    }})
}
shinyApp(ui, server)