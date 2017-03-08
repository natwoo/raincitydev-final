library(shiny)
library(ggplot2)
library(dplyr)
library(rgdal)
library(maps)
library(plotly)

revenue.data <- read.csv("data/washington_school_district_level_revenue.csv", stringsAsFactors = FALSE)
MSP.HSPE.data <- read.csv("data/2013_MSP_HSPE_Scores_by_District.csv", stringsAsFactors = FALSE)
EOC.data <- read.csv("data/2013_EOC_Scores_by_District.csv", stringsAsFactors = FALSE)
WAAS.data <- read.csv("data/2013_WAAS_Scores_by_District.csv", stringsAsFactors = FALSE)

server <- function(input, output) {
  output$map <- renderPlot({
    school.district.shapefile <- readOGR("./data/shapefiles", "tl_2016_53_unsd")
    school.district.data <- fortify(school.district.shapefile)
    
    washington.state <- map_data("state", "washington")
    ggplot(data = washington.state) +
      geom_polygon(aes(x = long, y = lat, group = group), color = 'black', fill = '#fff7bc', data = school.district.data) +  # School District Boundaries
      geom_polygon(aes(x = long, y = lat, group = group), color = "black", fill = NA) +
      
      labs(x = "", y = "") +
      theme(axis.ticks.y = element_blank(),axis.text.y = element_blank(),
            axis.ticks.x = element_blank(),axis.text.x = element_blank()) +
      coord_fixed(1.3)
  })
  
  
}

shinyServer(server)