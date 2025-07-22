library(shiny)
library(formatters)
library(DT)
library(shinythemes)
library(dplyr)
library(plotly)

ui <- navbarPage(theme= shinytheme("united"), "MSx123",
                 tabPanel("Data",                           sidebarPanel(
                   selectInput("usubjid", "USUBJID", choices = NULL),
                   # selectInput("arm", "ARM", choices = NULL),
                   # selectInput("sex", "SEX", choices = NULL),
                   actionButton("simulate", "Submit",class = "btn-success")
                 ),
                          mainPanel(
                            tabsetPanel(
                              tabPanel("Subjects data",
                                       mainPanel(
                                         dataTableOutput("adsl")
                                       )),
                              tabPanel("Adverse Events",
                                       mainPanel(
                                         dataTableOutput("adae")
                                       )),
                              tabPanel("Lab Plot",
                                       mainPanel(
                                         plotlyOutput("plot")
                                       ))
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
    adsl <- ex_adsl %>% filter(USUBJID==input$usubjid)
    adsl
    }else{ex_adsl}})

output$adae <- renderDT({
  if(input$simulate>0){
    adae <- ex_adae %>% filter(USUBJID==input$usubjid)
    adae
  }else{ex_adae}})

output$plot <- renderPlotly({
  if(input$simulate>0){
    adlb<- ex_adlb %>% filter(USUBJID==input$usubjid & PARAMCD=="ALT")
    plot_ly(data = adlb, x = ~ADY, y = ~AVAL, color = ~USUBJID, type = "scatter", mode = "lines")%>% add_lines() %>%
      layout(
        title = "Lab Plot",
        xaxis = list(title = "Time since treatment"),
        yaxis = list(title = " ALT "),
        height = 800, width = 1200
      )
  }else{    adlb<- ex_adlb %>% filter(PARAMCD=="ALT")
  plot_ly(data = adlb, x = ~ADY, y = ~AVAL, color = ~USUBJID, type = "scatter", mode = "lines")%>% add_lines() %>%
    layout(
      title = "Lab Plot",
      xaxis = list(title = "Time since treatment"),
      yaxis = list(title = " ALT "),
      height = 800, width = 1200
    )
}})

comment_data <- data.frame(
  name = ,
  comments = FALSE
)

sheet_append(SHEET_ID, comment_data, "demographics")
read_sheet(SHEET_ID, "demographics")
}

shinyApp(ui, server)