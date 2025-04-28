library(shiny)

#Sample data
#write.csv(mtcars, 'data.csv', row.names = FALSE)

ui <- fluidPage(
  fileInput('file', 'Upload csv file'),
  verbatimTextOutput("code"),
  uiOutput('axisx'),
  uiOutput('axisy')
)

server <- function(input, output) {
  data <- reactive({
    req(input$file)
    read.csv(input$file$datapath)
  })
  
  output$axisx <- renderUI({
    req(input$file)
    selectInput('x', 'X', names(data()))
  })
  output$axisy <- renderUI({
    req(input$file)
    selectInput('y', 'Y', names(data()))
  })
  output$plot <- reactive({
    req(input$file)
    req(input$axisx)
    req(input$axisy)
    output$code <- renderPrint({ 
         input$x
      })})
}



shinyApp(ui, server)