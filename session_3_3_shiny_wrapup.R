library(shiny)
library(DT)


ui = fluidPage(
  fluidRow(
    column(2, selectInput('dataset','Select dataset', choices = c("ADSL","ADAE","ADLB"),
                          selected='',
                          multiple=TRUE)),
    column(4, textInput('comment',"Add comment",value = "", width = NULL,placeholder = "comment")),
    column(2, actionButton("button","Submit")),
    # Button
    column(7, downloadButton("downloadData", "Download"))
  ),
  fluidRow (
    column(12, dataTableOutput('data') ) 
  )           
)

server <- function(input, output, session) {
  
  df_comments <- reactiveVal({
    data.frame(
      dataset = character(0), 
      Comment = character(0)
    )
  })
  dat = readRDS("comments.RDS") 
  ## reactive object df
  df_current <- reactive({
    
    ## reactivity that df depends on
    ## currently df = dat does not change
    df <- dat
    
    ## merge with current comments
    if(nrow(df_comments()) > 0)
      df <- rbind(df, df_comments())
    
    return(df)
    
  })
  
  observeEvent(input$button, {
    
    req(input$dataset)
    
    ## update df_comments by adding comments
    df_comments_new <- rbind(df_comments(), 
                             data.frame(dataset = input$dataset, Comment = input$comment)
    )
    df_comments(df_comments_new)
    
  })
  
  output$data <- renderDataTable({
    if(input$button>0){
      saveRDS(df_current(),file="comments.RDS")
      df_current()
    }else{
      dat 
    }
  })
  
  # Downloadable csv of selected dataset ----
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("comments", ".csv", sep = "")
    },
    content = function(file) {
      write.csv(df_current(), file, row.names = FALSE)
    }
  )
}


shinyApp(ui, server)