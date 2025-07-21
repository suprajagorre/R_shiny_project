library(shiny)
library(formatters)
library(DT)
library(shinythemes)

ui <- navbarPage(theme= shinytheme("united"), "MSx123",
                 tabPanel("Data",                           sidebarPanel(
                   selectInput("usubjid", "USUBJID", choices = NULL),
                   selectInput("arm", "ARM", choices = NULL),
                   selectInput("sex", "SEX", choices = NULL),
                   actionButton("simulate", "Submit",class = "btn-success")
                 ),
                          mainPanel(
                            tabsetPanel(
                              tabPanel("Subjects data",
                                       mainPanel(
                                         dataTableOutput("adsl")
                                       ))#,
                              # tabPanel("Adverse Events",
                              #          mainPanel(
                              #            dataTableOutput("ae")
                              #          ))
                            )
                          )
                 ))
  
server <- function(input, output, session) {
observeEvent(ex_adsl, {
  updateSelectInput(inputId = "usubjid", choices = ex_adsl$USUBJID)
  # updateSelectInput(inputId = "arm", choices = unique(ex_adsl$ARMCD))
  # updateSelectInput(inputId = "sex", choices = unique(ex_adsl$SEX))
})
  
output$adsl <- renderDT({
  if(input$simulate>0){
    adsl <- ex_adsl %>% filter("USUBJID"==input$usubjid)
    adsl
    }else{ex_adsl}})
}

shinyApp(ui, server)