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





