library(shiny)
library(formatters)
library(gt)
library(tidyverse)
library(rlistings)
library(shinythemes)
library(DT)
library(plotly)

ui <- navbarPage(theme= shinytheme("united"),"MS123 Analysis",
                 tabPanel("Data",
                          mainPanel(
                            tabsetPanel(
                              tabPanel("Subjects data",
                                       mainPanel(
                                         dataTableOutput("sl")
                                       )),
                            tabPanel("Adverse Events",
                                     mainPanel(
                                       dataTableOutput("ae")
                                     ))
                          )
                          )
                 ),
                 tabPanel("Table",
                          mainPanel(
                            tabsetPanel(
                              tabPanel("Lab table",
                                       mainPanel(
                                         verbatimTextOutput("Table1"),
                                         width = 12
                                       )),
                              tabPanel("Plot",
                                       mainPanel(
                                         plotlyOutput("plot")
                                         # width = 12
                                       ))
                            )
                          )
                 ))


server <- function(input, output, session) {

   output$sl<- renderDT(ex_adsl, options = list(pageLength = 10))
   output$ae<- renderDT(ex_adae, options = list(pageLength = 10))
   
   data <- reactive({ex_adlb %>%
       group_by(USUBJID,PARAMCD) %>%
       arrange(USUBJID,PARAMCD, AVAL)%>%
       mutate(
         #first.
         MIN = if_else(row_number(AVAL) == 1, "Y", ""),
         #last.
         MAX = if_else(row_number(AVAL) == n(), "Y", "")
       )%>% filter(SUBJID =="id-105")%>% select(USUBJID,PARAMCD,AVAL,AVISIT, MIN, MAX)})
  output$Table1 <- renderPrint({
    lsting <- as_listing(
      df = data(),
      disp_cols = c( "PARAMCD","AVAL", "MIN", "MAX"),
      key_cols = c("USUBJID", "AVISIT"),
      main_title = "Lab listing",
      subtitles = c("Other sub titles1", "Other sub titles2"),
      main_footer = c("Footnote1", "Footnote2"),
      prov_footer = "Source:ADLB, data:"
    )
    lsting
  })
  output$plot <- renderPlotly({
    plot_ly(data = ex_adlb, x = "ADY", y = "AVAL", type = "scatter", mode = "lines")%>%
      layout(
        title = "Customized Scatter Plot",
        xaxis = list(title = ""),
        yaxis = list(title = "")
      )
  })
}



shinyApp(ui, server)