library(ggplot2)
ggplot(iris, 
       aes(x = Sepal.Width, 
           y = Sepal.Length,
           color=Species)) + 
  geom_point()

library(ggplot2)

ggplot(iris,
       aes(x=Sepal.Length,
           y=Sepal.Width))+
  geom_point()+
  facet_grid(.~Species)

ggplot(iris,
       aes(x=Species,y=Sepal.Width))+
  geom_boxplot()+
  labs(x="example x",
       y="Sepal width, cm",
       title="main title")+
  theme_classic()
  
ggsave(filename = "Figure1.pdf",
       device = "pdf",
       height = 5, width = 5)


library(xml2)
WaterData<-read_xml("https://twd.water.gov.taipei/opendata/wqb/wqb.asmx/GetQualityData")
code_name<-WaterData %>% xml_find_all("//code_name")%>% 
  xml_text()
longitude<-WaterData %>% xml_find_all("//longitude")%>% 
  xml_text() %>% as.numeric()
latitude<-WaterData %>% xml_find_all("//latitude")%>% 
  xml_text()%>% as.numeric()
qua_cntu<-WaterData %>% xml_find_all("//qua_cntu") %>% 
  xml_text()%>% as.numeric()
WaterDataFrame<-data.frame(code_name,longitude,latitude,qua_cntu)
WaterDataClean<-WaterDataFrame[WaterDataFrame$qua_cntu>=0,]
head(WaterDataClean)


library(ggmap)
register_google(key = "AIzaSyAvNeyA_Uy8Z3JlzDnDuXQg7FhKFeVyNbY")
TaipeiMap <- 
  get_googlemap(
    center= c(lon=121.50,lat=25.06), 
    zoom = 11, maptype = 'roadmap')
ggmap(TaipeiMap)+ 
  geom_point(data=WaterDataClean, 
             aes(x=longitude, 
                 y=latitude,
                 color=qua_cntu))+
  scale_color_continuous(
    low = "yellow",high = "red")

TaipeiMapO <- ggmap(TaipeiMap)+ 
  geom_point(data=WaterDataClean, 
             aes(x=longitude, y=latitude,
                 color=qua_cntu,size=3.5))+ 
  scale_color_continuous(
    low = "yellow",high = "red")+ 
  guides(size="none")
TaipeiMapO


