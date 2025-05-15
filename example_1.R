library(shiny)
library(shinythemes)
library(DT)

ui <- fluidPage(theme= shinytheme("united"),
  navbarPage(
    "My Shiny App",
    tabPanel("tab 1",
      sidebarPanel(
        fileInput("upload", "Upload csv file", accept = ".csv")
        # numericInput("numInput", "Enter a number:", value = 0)
      ),
      mainPanel(
        tableOutput("head")
        # dataTableOutput("head")
      )
    )
))

server <- function(input, output, session) {
  data <- reactive({
    req(input$upload)
    read.csv(input$upload$datapath)
  })
  
  output$head <- renderTable({
    # if(input$numInput<5){validate("
    #   enter number more than 5"
    # )}
    # head(data(), input$numInput)
    head(data(), 10)
  })

  
  # output$head <- renderDT(data(), options = list(pageLength = 5))
  # output$head <- renderDT(data(), options = list(pageLength = 5))

}
shinyApp(ui, server)