library(shiny)
library(plotly)
library(DT)

# library(shiny)
ui <- fluidPage(
  navlistPanel(
    id = "tabset",
    "Heading 1",
    tabPanel("panel 1", "Panel one contents"),
    "Heading 2",
    tabPanel("panel 2", "Panel two contents"),
    tabPanel("panel 3", "Panel three contents")
  )
)
server <- function(input, output, session) {
}


shinyApp(ui, server)
