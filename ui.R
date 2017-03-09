library(shiny)
library(plotly)
library(leaflet)

ui <- fluidPage(
  #Title
  titlePanel("Title TBA"),

  br(),
  # A two panel layout with sidebar and main panel
  sidebarLayout(
    # Sidebar
    sidebarPanel(
      radioButtons("grades.button", "Grade of Interest:",
                   c("6th Grade" = "sixth", 
                     "7th Grade" = "seventh", 
                     "8th Grade" = "eighth", 
                     "10th Grade" = "tenth")),
      
      br(),
      # 
      # checkboxInput("subject.check", "Test Subject:",
      #               c("Reading" = "reading",
      #                 "Math" = "math",
      #                 "Writing" = "writing",
      #                 "Science" = "science")),
      # 
      br(),
      
      sliderInput("years.slider", "Years:",
                  min = 2010,
                  max = 2013,
                  value = 2013,
                  step = 1,
                  format="####")
    ),
    
    # Main panel
    mainPanel(
      # Create tabs
      leafletOutput("map"),
      br(),
      tabsetPanel(type = "tabs",
               #   tabPanel("Map", leafletOutput("map")),
                  tabPanel("Revenue vs. Test Score"),
                  tabPanel("Data Table"),
                  tabPanel("Aggregated Test Data")
      )
    )
  )
)

shinyUI(ui)