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



tbl<-table(mtcars$cyl,mtcars$am)
prop.table(tbl)
prop.table(tbl,margin = 1)
prop.table(tbl,margin = 2)


library(dplyr)
library(readr)
AllPreData<-
  read_csv("https://raw.githubusercontent.com/CGUIM-BigDataAnalysis/BigDataCGUIM/master/EMBA_BigData/AllPreData.csv",
           col_types = cols(
             非都市土地使用分區= col_character(),
              非都市土地使用編定= col_character()
              )
)
#method 1
f1<-filter(AllPreData,
       單價元平方公尺>400000&主要用途=="住家用")
select(f1,鄉鎮市區,starts_with("土地"),
       starts_with("交易"))
#method 2 (pipe)
AllPreData %>% 
  filter(單價元平方公尺>400000&主要用途=="住家用")%>%
  select(鄉鎮市區,starts_with("土地"),
             starts_with("交易")) 



