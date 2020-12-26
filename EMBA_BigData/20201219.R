library(readr)
AllPreData<-
  read_csv("https://raw.githubusercontent.com/CGUIM-BigDataAnalysis/BigDataCGUIM/master/EMBA_BigData/AllPreData.csv",
           col_types = cols(
             非都市土地使用分區= col_character(),
              非都市土地使用編定= col_character()
           )
  )

library(dplyr)
#單價元平方公尺超過100萬且主要用途為住家用
overprice<-filter(AllPreData,
                  單價元平方公尺>400000 &
                    主要用途=="住家用")
summarise(overprice,
          土地平均面積=
            mean(土地移轉總面積平方公尺),
          土地面積標準差=
            sd(土地移轉總面積平方公尺),
          建物平均面積=
            mean(建物移轉總面積平方公尺))



finalData<-AllPreData %>%
  filter(建物型態=="住宅大樓(11層含以上有電梯)" &
               建物移轉總面積平方公尺>100) %>%
  group_by(鄉鎮市區) %>%
  summarise(nHouse=n(),
            Price=mean(總價元),
            PriceU=mean(單價元平方公尺)) %>%
  arrange(desc(PriceU))

# normal

filterR<-filter(AllPreData,
       建物型態=="住宅大樓(11層含以上有電梯)" &
         建物移轉總面積平方公尺>100)

groupedData<-group_by(filterR,鄉鎮市區)

sumData<-summarise(groupedData,
          Price=mean(總價元),
          PriceU=mean(單價元平方公尺))

arrange(sumData,desc(PriceU))

AllPreData %>%
  filter(建物型態=="住宅大樓(11層含以上有電梯)" &
               建物移轉總面積平方公尺>100) %>%
  group_by(鄉鎮市區) %>%
  arrange(鄉鎮市區,desc(總價元)) %>%
  slice(1,n()) %>% View()

AllPreData %>%
  filter(建物型態=="住宅大樓(11層含以上有電梯)" &
               建物移轉總面積平方公尺>100) %>%
  group_by(鄉鎮市區) %>%
  arrange(鄉鎮市區,總價元) %>%
  slice(1) %>% View()
