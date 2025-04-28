library(shiny)
library(shinythemes)
library(DT)

ui <- fluidPage(theme= shinytheme("united"),
  navbarPage(
    "My Shiny App",
    tabPanel("tab 1",
      sidebarPanel(
        fileInput("upload", "Upload csv file", accept = ".csv")
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
    head(data(), 10)
  })
  
  # output$head <- renderDT(data(), options = list(pageLength = 5))

}
shinyApp(ui, server)