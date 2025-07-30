# Load necessary libraries for the Shiny app and data manipulation
library(shiny)
library(formatters)  # For formatting data
library(DT)          # For rendering DataTables
library(shinythemes) # For applying themes to the UI
library(dplyr)       # For data manipulation
library(plotly)      # For interactive plots

# Define the user interface (UI) of the Shiny app
ui <- navbarPage(theme = shinytheme("united"), "MSx123",
                 tabPanel("Data",                           # Create a tab for data
                          sidebarPanel(
                            selectInput("usubjid", "USUBJID", choices = NULL),  # Dropdown for USUBJID
                            # Uncomment the following lines to add more dropdowns for ARM and SEX
                            # selectInput("arm", "ARM", choices = NULL),
                            # selectInput("sex", "SEX", choices = NULL),
                            actionButton("simulate", "Submit", class = "btn-success")  # Submit button
                          ),
                          mainPanel(
                            tabsetPanel(  # Create a set of tabs in the main panel
                              tabPanel("Subjects data",
                                       mainPanel(
                                         dataTableOutput("adsl")  # Output table for subjects data
                                       )),
                              tabPanel("Adverse Events",
                                       mainPanel(
                                         dataTableOutput("adae")  # Output table for adverse events
                                       )),
                              tabPanel("Lab Plot",
                                       mainPanel(
                                         plotlyOutput("plot")  # Output for interactive lab plot
                                       ))
                            )
                          )
                 ))

# Define the server logic for the Shiny app
server <- function(input, output, session) {
  
  # Observe changes in ex_adsl and update the USUBJID dropdown choices
  observeEvent(ex_adsl, {
    updateSelectInput(inputId = "usubjid", choices = ex_adsl$USUBJID)  # Update choices for USUBJID
    # Uncomment the following lines to update choices for ARM and SEX
    # updateSelectInput(inputId = "arm", choices = unique(ex_adsl$ARMCD))
    # updateSelectInput(inputId = "sex", choices = unique(ex_adsl$SEX))
  })
  
  # Render the subjects data table based on selected USUBJID
  output$adsl <- renderDT({
    if (input$simulate > 0) {  # Check if the submit button has been pressed
      adsl <- ex_adsl %>% filter(USUBJID == input$usubjid)  # Filter data for selected USUBJID
      adsl  # Return the filtered data
    } else {
      ex_adsl  # Return the full dataset if not simulated
    }
  })
  
  # Render the adverse events data table based on selected USUBJID
  output$adae <- renderDT({
    if (input$simulate > 0) {  # Check if the submit button has been pressed
      adae <- ex_adae %>% filter(USUBJID == input$usubjid)  # Filter data for selected USUBJID
      adae  # Return the filtered data
    } else {
      ex_adae  # Return the full dataset if not simulated
    }
  })
  
  # Render the lab plot based on selected USUBJID
  output$plot <- renderPlotly({
    if (input$simulate > 0) {  # Check if the submit button has been pressed
      adlb <- ex_adlb %>% filter(USUBJID == input$usubjid & PARAMCD == "ALT")  # Filter for ALT parameter
      plot_ly(data = adlb, x = ~ADY, y = ~AVAL, color = ~USUBJID, type = "scatter", mode = "lines") %>%
        add_lines() %>%
        layout(
          title = "Lab Plot",  # Title of the plot
          xaxis = list(title = "Time since treatment"),  # X-axis label
          yaxis = list(title = "ALT"),  # Y-axis label
          height = 800, width = 1200  # Dimensions of the plot
        )
    } else {
      adlb <- ex_adlb %>% filter(PARAMCD == "ALT")  # Filter all data for ALT parameter
      plot_ly(data = adlb, x = ~ADY, y = ~AVAL, color = ~USUBJID, type = "scatter", mode = "lines") %>%
        add_lines() %>%
        layout(
          title = "Lab Plot",  # Title of the plot
          xaxis = list(title = "Time since treatment"),  # X-axis label
          yaxis = list(title = "ALT"),  # Y-axis label
          height = 800, width = 1200  # Dimensions of the plot
        )
    }
  })
}

# Run the Shiny app
shinyApp(ui, server)