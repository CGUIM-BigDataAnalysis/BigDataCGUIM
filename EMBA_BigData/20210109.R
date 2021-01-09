library(readr)
polio<-
  read_csv("https://raw.githubusercontent.com/CGUIM-BigDataAnalysis/BigDataCGUIM/master/104/POLIO_Incidence.csv")

library(reshape2)
polio.m<-
  melt(polio,
       id.vars = c("YEAR","WEEK"))

polio.m$value<-
  as.numeric(polio.m$value)

library(dplyr)
polio.m.year<-polio.m %>% 
  group_by(YEAR,variable) %>%
  summarise(Inc=sum(value,na.rm = T))

library(ggplot2)
ggplot(polio.m.year,aes(YEAR,variable))+
  geom_tile(aes(fill=Inc),color="white")+
  scale_fill_gradient(low="white",
                      high="red")+
  theme_minimal()+
  geom_vline(xintercept = 1955,size=1)
