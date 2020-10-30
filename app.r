# Define UI for dataset viewer app ----
library(shinyWidgets)
ui <- fluidPage(
  setBackgroundImage(
    
    src = "bg.jpg"
    
  ),
  
  # App title ----
  titlePanel("College predictor"),
  
  # Sidebar layout with a input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      tags$head(tags$style('body {color:black;}')),
     # uiOutput ("IMG"),
      img(src = "b.jpeg",height = 200, width = 300),
      #img(src = "A.png",height = 200, width = 200),
      # Input: Selector for choosing dataset ----
      selectInput(inputId = "dataset",
                  label = "Choose your board:",
                  choices = c("SSC", "ICSE", "CBSE","IB")),
      selectInput(inputId = "percentage",
                  label = "ENTER YOUR PERCENTAGE OF MARKS OBTAINED IN 12TH GRADE",
                  choices=c(">=90",">=80",">=70",">=60",">=50","<50")),
      numericInput(inputId = "cut",
                  label = "ENTER YOUR CUT OFF MARK",
                 value=200)),
   # Input: Numeric entry for number of obs to view ----
      numericInput(inputId = "obs",
                  label = "Number of college details:",
                    value = 200)
    ),
    
  

mainPanel(
  #Upload Inventory
  tabsetPanel(
    tabPanel("college list", 
             tableOutput("view")),
   
    id = "conditionedPanels"
  )
  
))

# Define server logic to summarize and view selected dataset ----
server <- function(input, output) {
  
  # Return the requested dataset ----
  datasetInput <- reactive({
    switch(input$percentage,
           ">=90"= X90_100,
           ">=80"= X80_90,
           ">=70"= X70_80,
           ">=60"= X60_70,
           ">=50"= X50_60,
           "<50"="better luck next time"
          
          
    )
    
  })
 # output$IMG = renderUI({
   # tags$img (src="A.png",height=200,width=200)})
  
  
  # Show the first "n" observations ----
  output$view <- renderTable({
    
    head(datasetInput(), n = input$obs)
    
  })
  
}

shinyApp(ui=ui, server=server)




