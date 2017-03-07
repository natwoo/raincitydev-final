library(shiny)
library(ggplot2)
library(dplyr)

revenue.data <- read.csv("data/washington_school_district_level_revenue.csv", stringsAsFactors = FALSE)
MSP.HSPE.data <- read.csv("data/2013_MSP_HSPE_Scores_by_District.csv", stringsAsFactors = FALSE)
EOC.data <- read.csv("data/2013_EOC_Scores_by_District.csv", stringsAsFactors = FALSE)
WAAS.data <- read.csv("data/2013_WAAS_Scores_by_District.csv", stringsAsFactors = FALSE)

server <- function(input, output) {
  
}

shinyServer(server)