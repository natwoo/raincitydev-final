library(shiny)
library(ggplot2)
library(dplyr)

revenue.data <- read.csv("data/washington_school_district_level_revenue.csv", stringsAsFactors = FALSE)
msp.hspe.data <- read.csv("data/2010_to_2013_MSP_HSPE_Scores_by_District.csv", stringsAsFactors = FALSE)

server <- function(input, output) {

}

shinyServer(server)
