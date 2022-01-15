library(tidyr)
library(readr)

case<-
  read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")

View(case)

case_long<-
  pivot_longer(case,
             cols = c(-"Country/Region",
                      -"Province/State",
                      -"Lat",
                      -"Long"),
             names_to = "Date")

View(case_long)

case_long$Date<-
  lubridate::mdy(case_long$Date)

case_long %>% 
  filter(`Country/Region`=="Taiwan*") %>%
  ggplot(aes(x=Date,y=value))+
  geom_line()+
  theme_bw()


