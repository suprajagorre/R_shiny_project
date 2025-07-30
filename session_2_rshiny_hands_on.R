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
                                         )),
                                tabPanel("Adverse events",
                                         mainPanel(
                                           dataTableOutput("ae")
                                         )),
                                tabPanel("Con med",
                                         mainPanel(
                                           dataTableOutput("cm")
                                         )),
                                tabPanel("Vitals",
                                         mainPanel(
                                           dataTableOutput("vs")
                                         ))
                              )
                            )
                          ),
                 tabPanel("Tables",
                          mainPanel(
                            tabsetPanel(
                              tabPanel("lab table",
                                       mainPanel(
                                         verbatimTextOutput("code"),
                                         width = 12
                                       )),
                              tabPanel("Safety",
                                       mainPanel(
                                         textOutput("text")
                                       ))
                            )
                          )
                 ),
                 tabPanel("Listings",
                          mainPanel(
                            tabsetPanel(
                              tabPanel("lab listing",
                                       mainPanel(
                                         gt_output("code1")
                                       )),
                              tabPanel("AE listing",
                                       mainPanel(
                                         textOutput("text")
                                       ))
                            )
                          )
                 )
                 )

server <- function(input, output, session) {
  data <- reactive({
    ex_adlb %>%
      group_by(USUBJID,PARAMCD) %>%
      arrange(USUBJID,PARAMCD, AVAL)%>%
      mutate(
        #first.
        MIN = if_else(row_number(AVAL) == 1, "Y", ""),
        #last.
        MAX = if_else(row_number(AVAL) == n(), "Y", "")
      )%>% filter(SUBJID =="id-105")%>% select(USUBJID,PARAMCD,AVAL,AVISIT, MIN, MAX)
  })
  
  output$sl<- renderDT(ex_adsl, options = list(pageLength = 5))
  output$ae <- renderDT(ex_adae, options = list(pageLength = 5))
  output$cm <- renderDT(ex_adcm, options = list(pageLength = 5))
  output$vs <- renderDT(ex_advs, options = list(pageLength = 5))
  
  output$code <- renderPrint({
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
  
  output$code1 <- render_gt({
    
    x<-data() %>%
      gt() %>%
      cols_label(
        USUBJID = "Subject ID",
        AVISIT= "VISIT ID",
        PARAMCD= "Parameter",
        AVAL= "Analysis Value",
        MIN = "Minimum Value",
        MAX = "Maximum")|>
      tab_header(
        title = "Lab listing",
        subtitle ="Population- Full Analysis Set"
      ) |>
      tab_source_note("Source:ADLB, data:") |>
      sub_missing(missing_text = "")
    
    x
  })
  
}



shinyApp(ui, server)