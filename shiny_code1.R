library(shiny)
library(plotly)

# ui <- fluidPage(navbarPage(
#   "My App",
#   tabPanel("Tab 1",
#            # Content for Tab 1
#   ),
#   tabPanel("Tab 2",
#            # Content for Tab 2
#   )
# )
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

# ui <- fluidPage(
#   titlePanel("Shiny Elements Example"),
#   sidebarLayout(
#     sidebarPanel(
#       numericInput("numInput", "Enter a number:", value = 0),
#       sliderInput("numSlider", "Select a value:", min = 0, max = 100, value = 50),
#       sliderInput("numSlider", "Select a value:", min = 0, max = 100, value = c(50,60)),
#       actionButton("actionBtn", "Click Me"),
#       checkboxInput("singleCheckbox", "Check me"),
#       checkboxGroupInput("multiCheckbox", "Select options:",
#                          choices = c("Option 1", "Option 2", "Option 3")),
#       radioButtons("rb", "Choose one:",
#                    choiceNames = list(
#                      icon("angry"),
#                      icon("smile"),
#                      icon("sad-tear")
#                    ),
#                    choiceValues = list("angry", "happy", "sad")
#       ),
#       radioButtons("radioBtn", "Choose one:",
#                    choices = c("Option A", "Option B", "Option C"), selected = NULL),
#       selectInput("dropdownMenu", "Choose one:",
#                   choices = c("Option 1", "Option 2", "Option 3"), selected = NULL),
#       selectInput("dropdownMenu", "Choose one:",
#                   choices = c("Option 1", "Option 2", "Option 3"), selected = NULL,multiple = TRUE),
#       textInput("txtInput", "Enter text:"),
#       textAreaInput("story", "Tell me about yourself", rows = 3),
#       dateInput("dob", "When were you born?"),
#       dateRangeInput("holiday", "When do you want to go on vacation next?")
#     ),
#     mainPanel(
#     )
#   )
# )
# 
# server <- function(input, output){
# }

# 
# ui <-     fluidPage(
#   sliderInput("val","select line value",
#               0.1,5,value=1),
#   plotlyOutput("plotly"),
# )
# 
# # Server
# server <- function(input, output) {
#   output$plotly <- renderPlotly({
#     plot_ly(data = iris, x = ~Sepal.Length, y = ~Sepal.Width, color = ~Species, type = "scatter", mode = "markers") %>%
#     add_lines(y = ~input$val)
#   })
# }

# ui <- fluidPage(
#   sliderInput("obs", "Number of observations", 0, 1000, 500),
#   actionButton("goButton", "Go!", class = "btn-success"),
#   plotOutput("distPlot")
# )
# server <- function(input, output) {
#   output$distPlot <- renderPlot({
#     # Take a dependency on input$goButton. This will run once initially,
#     # because the value changes from NULL to 0.
#     input$goButton
#     # Use isolate() to avoid dependency on input$obs
#     dist <- isolate(rnorm(input$obs))
#     hist(dist)
#   })
# }


shinyApp(ui, server)