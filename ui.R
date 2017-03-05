library(shiny)

ui <- fluidPage(
  #Title
  titlePanel("Title TBA"),
  
  br(),
  
  # A two panel layout with sidebar and main panel
  sidebarLayout(
    # Sidebar
    sidebarPanel(
      
    ),
    
    # Main panel
    mainPanel(
      # Create tabs
      tabsetPanel(type = "tabs",
                  tabPanel(),
                  tabPanel(),
                  tabPanel(),
                  tabPanel()
      )
    )
  )
)

shinyUI(ui)