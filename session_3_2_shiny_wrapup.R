# Load necessary libraries for the Shiny app and DataTable functionality
library(shiny)
library(DT)

# Define the user interface (UI) of the Shiny app
ui = fluidPage(
  fluidRow(
    # Column for selecting datasets
    column(2, selectInput('dataset', 'Select dataset', choices = c("ADSL", "ADAE", "ADLB"),
                          selected = '',  # Default selected value
                          multiple = TRUE)),  # Allow multiple selections
    # Column for adding comments
    column(4, textInput('comment', "Add comment", value = "", width = NULL, placeholder = "comment")),
    # Column for the submit button
    column(2, actionButton("button", "Submit")),  # Button to submit comments
    # Column for the download button
    column(7, downloadButton("downloadData", "Download"))  # Button to download data
  ),
  fluidRow(
    # Column for displaying the data table
    column(12, dataTableOutput('data'))  # Output area for the data table
  )           
)

# Define the server logic for the Shiny app
server <- function(input, output, session) {
  
  # Reactive value to store comments
  df_comments <- reactiveVal({
    data.frame(
      dataset = character(0),  # Placeholder for dataset names
      Comment = character(0)    # Placeholder for comments
    )
  })
  
  # Initial data frame with an example comment
  dat = data.frame(dataset = "ADSL", Comment = "example comment") 
  
  # Reactive object to manage the current data frame
  df_current <- reactive({
    # Start with the initial dataset
    df <- dat
    
    # If there are comments, merge them with the initial dataset
    if (nrow(df_comments()) > 0)
      df <- rbind(df, df_comments())  # Combine the data frames
    
    return(df)  # Return the updated data frame
  })
  
  # Observe the submit button click event
  observeEvent(input$button, {
    req(input$dataset)  # Ensure a dataset is selected
    
    # Update df_comments by adding the new comment
    df_comments_new <- rbind(df_comments(), 
                             data.frame(dataset = input$dataset, Comment = input$comment)
    )
    df_comments(df_comments_new)  # Update the reactive value with the new comments
  })
  
  # Render the data table output
  output$data <- renderDataTable({
    if (input$button > 0) {  # If the submit button has been pressed
      df_current()  # Return the updated data frame
    } else {
      # Return the initial dataset if no comments have been submitted
      data.frame(dataset = "ADSL", Comment = "example comment") 
    }
  })
  
  # Downloadable CSV of the current dataset
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("comments", ".csv", sep = "")  # Define the filename for the download
    },
    content = function(file) {
      write.csv(df_current(), file, row.names = FALSE)  # Write the current data frame to a CSV file
    }
  )
}

# Run the Shiny app
shinyApp(ui, server)