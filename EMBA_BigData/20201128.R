listSample<-list(Students=c("Tom","Kobe","Emma"),
                 Year=2017,
                 Score=c(60,50,80,40),
                 School="CGU")
listSample

# get value - method 1
listSample$Score

# get value - method 2
listSample[[3]]

#get list
listSample[3]

iris$Time<-1
str(iris)



library(readr)
f_lvr_land_a <- 
  read_csv("~/Downloads/f_lvr_land_a.csv")
View(f_lvr_land_a)

#XML
library(xml2)
# step 1 Import XML
FarmPriceXML<-
  read_xml("https://data.coa.gov.tw/Service/OpenData/FromM/FarmTransData.aspx?FOTT=Xml")
# step 2-1 Filter 作物名稱
NameTag<-
  xml_find_all(FarmPriceXML,".//作物名稱")
# step 2-2 Filter 平均價
PriceTag<-
  xml_find_all(FarmPriceXML,".//平均價")
# step 3-1 Extract 作物名稱
Names<-xml_text(NameTag)
# step 3-2 Extract 平均價
Price<-xml_text(PriceTag)
# step 4 整理
FarmPrice<-data.frame(Names,Price)


#install.packages("RCurl")

# JSON
library(jsonlite)
AQI_API<-fromJSON("https://data.epa.gov.tw/api/v1/aqx_p_432?limit=1000&api_key=9be7b239-557b-4c10-9775-78cadfc555e9&format=json")
str(AQI_API)
AQI_API$records
str(AQI_API$records)
View(AQI_API$records)
head(AQI_API$records)
table(AQI_API$records$County)

## HTML
library(rvest) ##載入
Repoterurl<-"https://www.twreporter.org/topics"
Repoterhtml<-read_html(Repoterurl)
title_node<-html_nodes(Repoterhtml,".kmupWO")
html_text(title_node)

Repoterhtml %>% 
  html_nodes(".kmupWO") %>% html_text()

html_nodes(Repoterhtml,".kmupWO")
Repoterhtml %>% html_nodes(".kmupWO")


news_title <- Repoterhtml %>% 
  html_nodes(".kmupWO") %>% html_text()
news_title





library(rvest) 
NanoStockUrl<-"https://fubon-ebrokerdj.fbs.com.tw/z/ze/zeg/zega_EBTW50E_I.djhtm"
NanoStockContent<-read_html(NanoStockUrl)
NanoStockName<-
  NanoStockContent %>% html_nodes("#oAddCheckbox") %>% 
  html_text()
NanoStockPrice<-
  NanoStockContent %>% html_nodes(".t3n1")%>% 
  html_text()

head(NanoStockName)
head(NanoStockPrice)
NanoStockPriceTable<-
  matrix(NanoStockPrice,ncol=6, byrow=TRUE)

# PTT
library(rvest)
ptt_html<-read_html("https://www.ptt.cc/bbs/Tech_Job/index.html")
title_nodes<-html_nodes(ptt_html,".title a")
titles<-html_text(title_nodes)
titles[3]






