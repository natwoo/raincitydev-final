library(shiny)
library(ggplot2)
library(dplyr)
library(tidyr)

revenue.data <- read.csv("data/washington_school_district_level_revenue.csv", stringsAsFactors = FALSE)
msp.hspe.data <- read.csv("data/2010_to_2013_MSP_HSPE_Scores_by_District.csv", stringsAsFactors = FALSE)

server <- function(input, output) {
  output$textTest <- renderText({
    input$school.district
  })

  output$plot2 <- renderPlot({
    validate(need(input$school.district, "Please select a school district to view."))
    district.test.data <- filter(msp.hspe.data, District == input$school.district) %>% 
      filter(GradeTested != 3 & GradeTested != 4 & GradeTested != 5) %>% 
      gather(key = subject, value = percentage.reached.standard, 
             ReadingPercentMetStandardExcludingNoScore, 
             MathPercentMetStandardExcludingNoScore, 
             WritingPercentMetStandardExcludingNoScore,
             SciencePercentMetStandardExcludingNoScore)
    
    plot <- ggplot(data = district.test.data) +
      geom_bar(mapping = aes(x = subject, y = percentage.reached.standard), stat = "identity") +
      facet_wrap(~GradeTested)
    plot
  })
}

shinyServer(server)
