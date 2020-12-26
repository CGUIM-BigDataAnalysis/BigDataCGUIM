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





