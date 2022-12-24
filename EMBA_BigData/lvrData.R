library(readr)
AllPreData<-NULL
for (county in letters){
  for(type in c("b")){ #"a",
    path<-paste0("~/Downloads/lvr_landcsv/",county,"_lvr_land_",type,".csv")
    if(file.exists(path)){
      tempData <- read_csv(path)
      tempData<-tempData[-1,]
      AllPreData<-rbind(AllPreData,tempData)
    }
  }
}

AllOldData<-NULL
for (county in letters){
  for(type in c("a")){ #"a",
    path<-paste0("~/Downloads/lvr_landcsv/",county,"_lvr_land_",type,".csv")
    if(file.exists(path)){
      tempData <- read_csv(path,
                           col_types = cols(
        .default = col_character(),
        電梯 = col_character(),
        主建物面積 = col_double(),
        附屬建物面積 = col_double(),
        陽台面積 = col_double()
      ))
      tempData<-tempData[-1,]
      AllOldData<-rbind(AllOldData,tempData)
    }
  }
}
AllPreData<-AllPreData %>% select(-編號)
AllOldData<-AllOldData %>% select(-編號)
write_csv(AllPreData,"AllPreData.csv")
write_csv(AllOldData,"AllOldData.csv")
