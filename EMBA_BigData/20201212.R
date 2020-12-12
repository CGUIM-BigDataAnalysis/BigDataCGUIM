#取出iris資料集"Species"欄位的前十列(Row)
iris[1:10,"Species"]
#取出iris資料集所有單數列(Row)
#method 1
a<-1:150
a<-1:nrow(iris)
a[c(T,F)]
#method 2
seq(1,150,2)
seq(1,nrow(iris),2)
iris[seq(1,nrow(iris),2),]
# 取出iris資料集最後兩個欄位的所有偶數列(Row)
ncol(iris)
iris[seq(2,nrow(iris),2), 
     c(4,5)]
iris[seq(2,nrow(iris),2), 
     c((ncol(iris)-1),ncol(iris))]

#取出mtcars中，cyl小於等於6的車種資料
mtcars[mtcars$cyl<=6, ]
#所有Toyota品牌的車種資料
rownames(mtcars)
grep("Toyota",rownames(mtcars))
# grep or grepl 
mtcars[c(20,21), ]
mtcars[grep("Toyota",rownames(mtcars)), ]
mtcars[grepl("Toyota",rownames(mtcars)), ]

# covid
library(readr)
Cases <- 
  read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")
Deaths <- 
  read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv")

library(dplyr)
covid<-inner_join(Cases,Deaths, 
           by = c("Province/State", 
                  "Country/Region", 
                  "Lat", "Long"))
nrow(covid)

covid_wrong<-inner_join(Cases,Deaths, 
                  by = "Country/Region")
nrow(covid_wrong)







## select US updated case and death number
Cases %>% 
  filter(`Country/Region`=="US") %>%
  select(`Country/Region`,`12/10/20`) %>%
  arrange(desc(`12/10/20`))
  
Deaths %>% 
  filter(`Country/Region`=="US") %>%
  select(`Country/Region`,`12/10/20`) %>%
  arrange(desc(`12/10/20`))


library(dplyr)
library(readr)
AllPreData<-
  read_csv("https://raw.githubusercontent.com/CGUIM-BigDataAnalysis/BigDataCGUIM/master/EMBA_BigData/AllPreData.csv",
           col_types = cols(
             非都市土地使用分區= col_character(),
              非都市土地使用編定= col_character()
              )
)
