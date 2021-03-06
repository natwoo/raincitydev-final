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
                   c("6th Grade" = "6", 
                     "7th Grade" = "7", 
                     "8th Grade" = "8", 
                     "10th Grade" = "10")),
      
      br(),

      radioButtons("subject.check", "Test Subject:",
                    c("Reading" = "reading",
                      "Math" = "math",
                      "Writing" = "writing",
                      "Science" = "science")),

      br(),
      
      sliderInput("years.slider", "Years:",
                  min = 2010,
                  max = 2013,
                  value = 2013,
                  step = 1,
                  sep = "")
    ),
    
    # Main panel
    mainPanel(
      # Create tabs
      leafletOutput("map"),
      br(),
      tabsetPanel(type = "tabs",
               #   tabPanel("Map", leafletOutput("map")),
                  tabPanel("Revenue vs. Test Score", textOutput("text"), plotOutput("plot1"), textOutput("text1")),
                  tabPanel("Data Table", textOuput("data.table.summary"), dataTableOutput('table')),
                  tabPanel("Aggregated Test Data"),
                  tabPanel("About", textOutput('about'))
      )
    )
  )
)

shinyUI(ui)