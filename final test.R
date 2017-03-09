library(dply)
library(tidyr)
library(ggplot2)

revenue.data <- read.csv("data/washington_school_district_level_revenue.csv", stringsAsFactors = FALSE)
msp.hspe.data <- read.csv("data/2010_to_2013_MSP_HSPE_Scores_by_District.csv", stringsAsFactors = FALSE)

district.test.data <- filter(msp.hspe.data, District == "Aberdeen School District") %>% 
  filter(GradeTested != 3 & GradeTested != 4 & GradeTested != 5) %>% 
  filter(SchoolYear == "2009-10") %>% 
  select(District, GradeTested, 
         ReadingPercentMetStandardExcludingNoScore, 
         MathPercentMetStandardExcludingNoScore,
         WritingPercentMetStandardExcludingNoScore,
         SciencePercentMetStandardExcludingNoScore
         ) %>% 
  mutate(Grade = paste0(GradeTested, "th Grade")) %>% 
  gather(key = subject, value = percentage.reached.standard,
         ReadingPercentMetStandardExcludingNoScore,
         MathPercentMetStandardExcludingNoScore,
         WritingPercentMetStandardExcludingNoScore,
         SciencePercentMetStandardExcludingNoScore)

district.test.data$Grade <- factor(district.test.data$Grade, levels = c("6th Grade", "7th Grade", "8th Grade", "10th Grade"))
district.test.data$subject <- factor(district.test.data$subject, levels = c("ReadingPercentMetStandardExcludingNoScore",
                                                                            "WritingPercentMetStandardExcludingNoScore",
                                                                            "MathPercentMetStandardExcludingNoScore",
                                                                            "SciencePercentMetStandardExcludingNoScore"))

plot <- ggplot(data = district.test.data) +
  geom_bar(mapping = aes(x = subject, y = percentage.reached.standard, fill = subject), stat = "identity") +
  facet_wrap(~Grade) +
  labs(title = "Distribution of Students Reaching Proficiency Standard on the MSP/HSPE", x = "Test Subject", y = "Percentage Met Standard") +
  scale_fill_discrete("Subject", labels = c("Reading", "Writing", "Math", "Science"))
plot