library(readr)
case<-
  read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")
death<-
  read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv")


library(dplyr)
case_death<-
  inner_join(case,death,
             by=c("Province/State",
                  "Country/Region",
                  "Lat",
                  "Long"))
