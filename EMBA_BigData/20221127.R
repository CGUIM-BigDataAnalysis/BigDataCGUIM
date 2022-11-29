# Basic 101---------------------
# install
install.packages("tidyverse")
# load
library(tidyverse)

# variable 
a<-1111111111
22222->b
c=999999

# variable name
TRUE
True

# Warning message
log(-1)
log(10)

# Error message
log()

# Help
?mean

# Data structure ---------------

a<-1:10
a<-c(1,2,3,4,5,6,7,8,9,10)
a<-seq(1,10,1)

b<-c(2,4,6,8,10,12,14,16,18,20)
b<-seq(2,20,2)
b<-a*2

a[4]
b[5:7]
b[c(5,6,7)]


factor(c("Doctor",
         "BS",
         "MS",
         "BS",
         "BS"),
       levels = c("BS",
                  "MS",
                  "Doctor"))

NoFactor<-data.frame(ID=1:5,
           Type=c("Doctor",
                  "BS",
                  "MS",
                  "BS",
                  "BS"))

WithFactor<-
  data.frame(ID=1:5,
             Type=factor(c("Doctor",
                           "BS",
                           "MS",
                           "BS",
                           "BS"),
                         levels = c("BS",
                                    "MS",
                                    "Doctor")))
# without factor
ggplot(NoFactor,aes(x=Type)) +
  geom_bar()

# with factor
ggplot(WithFactor,aes(x=Type)) +
  geom_bar()

# list
listSample<-list(Students=c("Tom","Kobe","Emma"),
                 Year=2017,
                 Score=c(60,50,80,40),
                 School="CGU")
# get the value
listSample$Score
listSample[[3]]
# get the list
listSample[3]

#


#install.packages("skimr")
library(skimr)
skim(iris) 

iris$Time<-1
str(iris)
skim(iris)

# Load data
library(readr)
f_lvr_land_a <- 
  read_csv("https://raw.githubusercontent.com/CGUIM-BigDataAnalysis/BigDataCGUIM/master/EMBA_BigData/f_lvr_land_a.csv")

#read_csv("filename")
View(f_lvr_land_a)
View(f_lvr_land_a[-1,])
housePrice<-
  f_lvr_land_a[-1,]




