library(httr)
library(jsonlite)
library(dplyr)
l

api.key <- "dphoh57xeswwu7mwmzscngxx"
base.uri <- "http://api.greatschools.org/schools/WA/Seattle/public/high-schools/"
query.params <- list("key" = api.key)
response <- GET(base.uri, query = query.params)
body <- content(response, "text")

data <- fromJSON(body)
data <- data.frame(data)
data <- filter(data, schools.school.gradeRange == "9-12")