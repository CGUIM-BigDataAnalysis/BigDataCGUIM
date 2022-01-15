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
           單價元平方公尺>400000&
             主要用途=="住家用")
summarise(f1,
          nTrans=n(),
          meanBuild=mean(建物移轉總面積平方公尺),
          meanLand=mean(土地移轉總面積平方公尺))

# method 2 -> pipe %>%
AllPreData %>% 
  filter(單價元平方公尺>400000&
                  主要用途=="住家用") %>% 
  summarise(nTrans=n(),
            meanBuild=mean(建物移轉總面積平方公尺),
            meanLand=mean(土地移轉總面積平方公尺))

## group_by demo
AllPreData %>% 
  group_by(鄉鎮市區,都市土地使用分區) %>%
  summarise(nTrans=n(),
            meanBuild=mean(建物移轉總面積平方公尺),
            meanLand=mean(土地移轉總面積平方公尺)) %>%
  View()

# group by all
table(AllPreData$建物型態)
AllPreData %>% 
  filter(建物型態=="住宅大樓(11層含以上有電梯)"&
               建物移轉總面積平方公尺>100) %>%
  group_by(鄉鎮市區) %>%
  summarise(nTrans=n(),
            menaPrice=mean(總價元),
            meanUPrice=mean(單價元平方公尺)) %>%
  arrange(desc(meanUPrice))

# group by all (grepl)
AllPreData %>% 
  filter(grepl("住宅大樓",建物型態)&
               建物移轉總面積平方公尺>100) %>%
  group_by(鄉鎮市區) %>%
  summarise(nTrans=n(),
            menaPrice=mean(總價元),
            meanUPrice=mean(單價元平方公尺)) %>%
  arrange(desc(meanUPrice))

# slice
AllPreData %>% 
  filter(grepl("住宅大樓",建物型態)&
           建物移轉總面積平方公尺>100) %>%
  group_by(鄉鎮市區) %>% 
  arrange(鄉鎮市區,總價元) %>%
  slice(c(1,n())) 
iris$Species
ggplot(iris, 
       aes(x = Sepal.Width, 
           y = Sepal.Length,
           color=Species)) + 
  geom_point()

ggplot(iris, 
       aes(x = Sepal.Length, 
           y = Sepal.Width)) + 
  geom_point()+
  facet_grid(.~Species)+
  theme_bw()

ggplot(iris, 
       aes(x = Species, 
           y = Sepal.Width)) + 
  geom_boxplot()+
  theme_bw()+
  labs(x="xxxxxxx",y="yyyyyy")



library(jsonlite)
WaterData<-fromJSON("http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=190796c8-7c56-42e0-8068-39242b8ec927")
WaterDataFrame<-WaterData$result$results
WaterDataFrame$longitude<-as.numeric(WaterDataFrame$longitude)
WaterDataFrame$latitude<-as.numeric(WaterDataFrame$latitude)
WaterDataFrame$qua_cntu<-as.numeric(WaterDataFrame$qua_cntu)
WaterDataClean<-WaterDataFrame[WaterDataFrame$qua_cntu>=0,]

#install.packages("ggmap") 
library(ggmap)
register_google(key = "AIzaSyAvNeyA_Uy8Z3JlzDnDuXQg7FhKFeVyNbY")

TaipeiMap <- get_googlemap(
  center  = c(lon=121.50,lat=25.06), 
  zoom = 11, maptype = 'roadmap')
TaipeiMapO <- ggmap(TaipeiMap)+ 
  geom_point(data=WaterDataClean, 
             aes(x=longitude, y=latitude,
                 color=qua_cntu,size=3.5))+ 
  scale_color_continuous(
    low = "yellow",high = "red")+ 
  guides(size="none")
TaipeiMapO

#利用get_googlemap() + ggmap()取得桃園地區的google 圖層
#center = c(lon=121.20,lat=25.00)
#zoom = 11
#language = “zh-TW”
#在長庚大學所在地 （座標121.389539,25.035225）加上一個紅色的點
#geom_point()
#x= 121.389539
#y= 25.035225
#color =“red”
