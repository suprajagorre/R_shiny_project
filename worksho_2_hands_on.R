library(shiny)
library(formatters)
library(gt)
library(tidyverse)
library(rlistings)
library(shinythemes)
library(DT)

ui <- navbarPage(theme= shinytheme("united"),"MS123 Analysis",
                 tabPanel("Data",
                          mainPanel(
                            tabsetPanel(
                              tabPanel("Subjects data",
                                       mainPanel(
                                         dataTableOutput("sl")
                                       ))
                            )
                          )
                 ))


server <- function(input, output, session) {

  output$sl<- renderDT(ex_adsl, options = list(pageLength = 5))
  
}



shinyApp(ui, server)