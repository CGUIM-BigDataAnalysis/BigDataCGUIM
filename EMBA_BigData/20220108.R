library(readr)
case<-
  read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")
death<-
  read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv")

library(dplyr)
all_covid<-inner_join(case,death,
                      by=c("Province/State",
                           "Country/Region",
                           "Lat","Long"))

all_covid$CFR22_1_7<-
  all_covid$`1/7/22.y`/all_covid$`1/7/22.x`

all_covid[,c("Country/Region","CFR22_1_7")] %>% 
  View()
