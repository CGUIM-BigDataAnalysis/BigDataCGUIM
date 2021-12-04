library(tidyverse)

a<-c(1,2,3,4,5,6,7,8,9,10)
a<-1:10
b<-c(2,4,6,8,10,12,14,16,18,20)
b<-seq(2,20,2)
a[4]
b[c(5,6,7)]
b[5:7]

listSample<-
  list(Student=c("Tom","Kobe","Emma"),
     Year=2017,
     Score=c(50,60,80,90))

listSample
listSample$Score
listSample[[3]]
class(listSample[[3]])
listSample[["Score"]]
listSample[3]
class(listSample[3])
listSample$Gender<-c("M","F","M")
listSample

install.packages("skimr")
library(skimr)
skim(iris)

iris$Time<-1
skim(iris)

skimr::skim()




