library(shiny)
library(formatters)
library(gt)
library(tidyverse)
library(rlistings)
library(DT)

ui <- fluidPage(theme= shinytheme("united"),
                navbarPage(
                  "My Shiny App",
                  tabPanel("Data",
                           mainPanel(
                              dataTableOutput("head")
                           )
                  ),
                  tabPanel("Listing",
                           mainPanel(
                             verbatimTextOutput("code"),
                             width = 12
                           )
                  ),
                  tabPanel("Listing2",
                           mainPanel(
                             gt_output("code1")
                           )
                  )
                ))

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
  
  output$head <- renderDT(data(), options = list(pageLength = 5))
  
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