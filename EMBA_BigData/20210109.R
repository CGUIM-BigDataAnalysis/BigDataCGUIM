library(readr)
polio<-
  read_csv("https://raw.githubusercontent.com/CGUIM-BigDataAnalysis/BigDataCGUIM/master/104/POLIO_Incidence.csv")

library(reshape2)
polio.m<-
  melt(polio,
       id.vars = c("YEAR","WEEK"))
