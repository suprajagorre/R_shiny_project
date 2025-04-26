library(shiny)
library(plotly)
library(DT)

#If you already have your future app.R open, type shinyapp then press Shift + Tab to insert the Shiny app snippet

##1
# library(shiny)
# ui <- fluidPage(
# )
# server <- function(input, output, session) {
# }
# shinyApp(ui, server)

##2
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

##3
# ui <- fluidPage(
#   textOutput("text"),
#   verbatimTextOutput("code"),# code king of output
#   tableOutput("static"),
#   dataTableOutput("dynamic"),
#   plotOutput("plot", width = "400px"),
#   plotlyOutput("plotly")
# )
# 
# 
# server <- function(input, output, session) {
#   output$text <- renderText({ 
#     "Hello friend!" 
#   })
#   output$code <- renderPrint({ 
#     summary(1:10) 
#   })
#   output$static <- renderTable(head(mtcars))
#   output$dynamic <- renderDT(mtcars, options = list(pageLength = 5))
#   output$plotly <- renderPlotly({
#     plot_ly(data = iris, x = ~Sepal.Length, y = ~Sepal.Width, color = ~Species, type = "scatter", mode = "markers")
#   })
#   output$plot <- renderPlot(plot(1:5), res = 96)
# }

# for timer to wait for execution: server timer <- reactiveTimer(500), in render function use timer()
# to execute only after click: ui:actionButton("simulate", "Simulate!"), server in render use input$simulate


# ui <- fluidPage(
#   titlePanel("My Shiny App"),
#   sidebarLayout(
#     sidebarPanel(
#       # Sidebar content
#     ),
#     mainPanel(
#             tabsetPanel(
#                 tabPanel("panel 1", "one")
# )
#     )
#   )
# )

#fixedPage() works like fluidPage() but has a fixed maximum width, which stops your apps from becoming
#unreasonably wide on bigger screens. fillPage() fills the full height of the browser

# ui <- fluidPage(
#   navlistPanel(
#     id = "tabset",
#     "Heading 1",
#     tabPanel("panel 1", "Panel one contents"),
#     "Heading 2",
#     tabPanel("panel 2", "Panel two contents"),
#     tabPanel("panel 3", "Panel three contents")
#   )
# )

#theme = bslib::bs_theme(bootswatch = "darkly")  add this code to 3rd code to demonstrate add in UI
# add this in server thematic::thematic_shiny()


# ui <- fluidPage(
#   htmlOutput("source")
#   # imageOutput("photo")
# )
# server <- function(input, output, session) {
#   # output$photo <- renderImage({
#   #   list(
#   #     src = file.path("cheatsheet.img"),
#   #     contentType = "image/jpeg",
#   #     width = 500,
#   #     height = 650
#   #   )
#   # }, deleteFile = FALSE)
#   
#   output$source <- renderUI({
#     HTML("https://www.bing.com/images/search?q=dog+image&id=EE0394FCAA590A90CD17B2422EB97F0B59A9F5F6&FORM=IACFIR")
#   })
# }

#req() in server to show the required entry fields
# ui <- fluidPage(
#   fileInput("upload", NULL, buttonLabel = "Upload...", multiple = TRUE),
#   tableOutput("files")
# )
# server <- function(input, output, session) {
#   output$files <- renderTable(input$upload)
# }

shinyApp(ui, server)