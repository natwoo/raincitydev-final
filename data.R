library(httr)
library(jsonlite)
library(xml2)
library(dplyr)

api.key <- "dphoh57xeswwu7mwmzscngxx"
base.uri <- "http://api.greatschools.org/"
school.search <- "search/schools"
school.search.query.params <- list(key = api.key, state = "WA", q = " ", levelCode = "high-schools", sort = "alpha", limit = 1500)
school.search.response <- GET(paste0(base.uri, school.search), query = school.search.query.params)
school.search.body <- content(school.search.response, "text")

school.search.data <- data.frame(fromJSON(school.search.body)) %>% 
  filter(schools.school.type == "public")

school.gsids <- school.search.data$schools.school.gsId

test.scores <- paste0("school/tests/WA/", school.gsids[1])
test.scores.query.params <- list(key = api.key)
test.scores.response <- GET(paste0(base.uri, test.scores), query = test.scores.query.params)
test.scores.body <- content(test.scores.response, "text")
test.scores.data <- read_xml(test.scores.body)

revenue.data <- read.csv("data/washington_school_district_level_revenue.csv", stringsAsFactors = FALSE)