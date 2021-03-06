library(readr)
COVID19_case<-
  read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")
library(reshape2)
COVID19_case_long<- melt(COVID19_case,
     id.vars = c("Province/State",
                 "Country/Region",
                 "Lat","Long"))



library(ggplot2)


ggplot(iris, 
       aes(x = Sepal.Width, 
           y = Sepal.Length)) + 
  geom_point()+facet_grid(Species~.)


ggplot(iris, 
       aes(x = Sepal.Width, 
           y = Sepal.Length,
           color=Species)) + 
  geom_point()


iris
library(esquisse)
esquisser()


ggplot(iris,aes(x=Sepal.Length,
                y=Sepal.Width))+
  geom_point()+
  facet_grid(.~Species)

ggplot(iris,aes(x=Species,
                y=Sepal.Width))+
  geom_boxplot()+
  theme_classic()



library(ggmap)
register_google("AIzaSyAvNeyA_Uy8Z3JlzDnDuXQg7FhKFeVyNbY")
taoyuan<-
  get_googlemap(
    center = c(121.20,25.00),
    zoom = 11
    )

ggmap(taoyuan) + 
  geom_point(
    aes(x=121.389539,
        y=25.035225),
    color="red",size=10
    )


library(purrr)
library(tibble)
library(jsonlite)
Bike<-
  fromJSON("https://data.tycg.gov.tw/opendata/datalist/datasetMeta/download?id=5ca2bfc7-9ace-4719-88ae-4034b9a5a55c&rid=a1b4714b-3b75-4ff8-a8f2-cc377e4eaa0f")
Bike_df<-
  map_df(Bike$retVal,as_tibble)

# 文字轉數字 -> lat lng sbi
as.numeric(Bike_df$sbi)
class(Bike_df$sbi)
Bike_df$sbi<-as.numeric(Bike_df$sbi)
class(Bike_df$sbi)
Bike_df$lat<-as.numeric(Bike_df$lat)
Bike_df$lng<-as.numeric(Bike_df$lng)
# 載桃園地圖，ggmap()畫地圖
#library(ggmap)
#register_google("AIzaSyAvNeyA_Uy8Z3JlzDnDuXQg7FhKFeVyNbY")
taoyuan11<-
  get_googlemap(
    center = c(121.20,25.00),
    zoom = 11
  )
taoyuan12<-
  get_googlemap(
    center = c(121.20,25.00),
    zoom = 12
  )
taoyuan13<-
  get_googlemap(
    center = c(121.20,25.00),
    zoom = 13
  )
ggmap(taoyuan11)
ggmap(taoyuan12)
# 用geom_point(資料,aes(x,y,size))疊圖
ggmap(taoyuan11)+
  geom_point(data=Bike_df,
             aes(x=lng,y=lat,size=sbi))
ggmap(taoyuan13)+
  geom_point(data=Bike_df,
             aes(x=lng,y=lat,size=sbi))

ggmap(taoyuan13)+
  geom_point(data=Bike_df,
             aes(x=lng,y=lat,color=sbi),
             size=4)+
  scale_color_continuous(low="green",
                         high="red")

ggmap(taoyuan13)+
  geom_point(data=Bike_df,
             aes(x=lng,y=lat,
                 size=sbi,
                 color=sarea))

