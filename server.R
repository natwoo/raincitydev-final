library(shiny)
library(ggplot2)
library(dplyr)
library(stringr)
revenue.data <- read.csv("data/washington_school_district_level_revenue.csv", stringsAsFactors = FALSE)
msp.hspe.data <- read.csv("data/2010_to_2013_MSP_HSPE_Scores_by_District.csv", stringsAsFactors = FALSE)
final.data <- left_join(revenue.data, msp.hspe.data, by = c("district" = "District"))
final.data <- mutate(final.data,  year = paste(substr(final.data$SchoolYear, 1,2), substr(final.data$SchoolYear, 6,7), sep = ""))

server <- function(input, output) {
  filtered <- reactive({
    data.msp <- final.data %>% 
      filter(GradeTested == input$grades.button) %>% filter(year == input$years.slider) %>% 
      select("District" = district, 
             "Grade" = GradeTested,
             "Year" = year, 
             "Total_revenue" = total.revenue, 
             "Percent_met_standard_in_reading" = ReadingPercentMetStandardExcludingNoScore, 
             "Percent_met_standard_in_math" = MathPercentMetStandardExcludingNoScore, 
             "Percent_met_standard_in_writing" = WritingPercentMetStandardExcludingNoScore, 
             "Percent_met_standard_in_science" = SciencePercentMetStandardExcludingNoScore)                                           
      
   return(data.msp)
  })
  output$table <- renderDataTable({
    return(filtered())
  })
  
  output$about <- renderText({
    paste("Our project investigates whether more funding can
    lead to higher scores in the following subjects: Reading, Math, Writing,
    and Science. We limited our data to the school districts of Washington. 
    . As you can see, we used two different data sets. One of them detials 
    the data for how well students did on their testing and the other on how
    much the school districts were funded. This topic is important because
    it will inform and educate policymakers which areas need more funding
   through the map we've made. Additional information such as plots, data
    tables, and aggregated plots can further help policymakers understand
    the data and make decisions on whether to fund certain districts more.
    for more information on how the scores are evaluated please refer to 
    the link:","[link](http://www.k12.wa.us/assessment/StateTesting/ScaleScores.aspx)")
   
  }) 
}

shinyServer(server)
