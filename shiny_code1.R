library(shiny)


# ui <- navbarPage(
#   "My App",
#   tabPanel("Tab 1",
#            # Content for Tab 1
#   ),
#   tabPanel("Tab 2",
#            # Content for Tab 2
#   )
# )

# ui <- fluidPage(
#   titlePanel("My Shiny App"),
#   sidebarLayout(
#     sidebarPanel(
#       # Sidebar content
#     ),
#     mainPanel(
#       # Main content
#     )
#   )
# )

ui <- fluidPage(
  titlePanel("Shiny Elements Example"),
  sidebarLayout(
    sidebarPanel(
      numericInput("numInput", "Enter a number:", value = 0),
      sliderInput("numSlider", "Select a value:", min = 0, max = 100, value = 50),
      actionButton("actionBtn", "Click Me"),
      checkboxInput("singleCheckbox", "Check me"),
      checkboxGroupInput("multiCheckbox", "Select options:", 
                         choices = c("Option 1", "Option 2", "Option 3")),
      radioButtons("radioBtn", "Choose one:", 
                   choices = c("Option A", "Option B", "Option C"), selected = NULL),
      selectInput("dropdownMenu", "Choose one:", 
                  choices = c("Option 1", "Option 2", "Option 3"), selected = NULL),
      textInput("txtInput", "Enter text:")
    ),
    mainPanel(
    )
  )
)

server <- function(input, output){
}

shinyApp(ui, server)