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
library(tidyr)
case_long<-
  pivot_longer(case,
             cols =c(-"Province/State",
                     -"Country/Region",
                     -"Lat",
                     -"Long"),
             names_to = "Date",
             values_to = "Count"
            )

table(mtcars$cyl,mtcars$am)
prop.table(table(mtcars$cyl,mtcars$am),
           margin = 2)



library(dplyr)
library(readr)
# load data
AllPreData<-read_csv("https://raw.githubusercontent.com/CGUIM-BigDataAnalysis/BigDataCGUIM/master/EMBA_BigData/AllPreData.csv")
filter_temp<-
  filter(AllPreData,
         單價元平方公尺>400000 & 
           主要用途=="住家用")
final<-
  select(filter_temp,
       鄉鎮市區,
       starts_with("土地"),
       starts_with("交易")) 

filter_temp$建物移轉總面積平方公尺
test<-
  summarise(filter_temp,
            nRec=n(),
            meanLand=mean(土地移轉總面積平方公尺),
            meanBuild=mean(建物移轉總面積平方公尺))
test$meanLand


unique(AllPreData$建物型態)


filter_temp1<-
  filter(AllPreData,
         建物型態=="住宅大樓(11層含以上有電梯)"&
         建物移轉總面積平方公尺>100) 
#依鄉鎮市區分組
group_temp<-group_by(filter_temp1,鄉鎮市區)
#計算交易的平均總價元，平均單價元平方公尺
sum_temp<-summarise(group_temp,
          meanPrice=mean(總價元),
          meanUPrice=mean(單價元平方公尺))
#依平均單價元平方公尺 由大到小排序
arrange(sum_temp,desc(meanUPrice))
