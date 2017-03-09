library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(stringr)
#Reading in the two data
revenue.data <- read.csv("data/washington_school_district_level_revenue.csv", stringsAsFactors = FALSE)
msp.hspe.data <- read.csv("data/2010_to_2013_MSP_HSPE_Scores_by_District.csv", stringsAsFactors = FALSE)
#Merged the two data together using Districts
final.data <- left_join(revenue.data, msp.hspe.data, by= c("district" = "District"))
#Changing so we can have years 2010, 2011, instead of 2010-2011, 2011-2012
final.data <- mutate(final.data,  year = paste(substr(final.data$SchoolYear, 1,2), substr(final.data$SchoolYear, 6,7), sep = ""))

server <- function(input, output) {
  #Filtering data for the plot
  filtered <- reactive({
    data.final <- final.data %>%
      filter(year == input$years.slider) %>%
      filter(GradeTested == input$grades.button)
    return(data.final)
    
  })
  #Outputting the plot
  output$plot <- renderPlot({
    
    p <- ggplot(data = filtered(), mapping = aes(x=total.revenue.per.pupil, y=ReadingPercentMetStandardExcludingNoScore)) +
      
      geom_point(aes(alpha = "district")) +
      xlim(5000,40000) 
    
    return(p)
  })
}
?filter
shinyServer(server)