library(googlesheets4)
read_sheet("https://docs.google.com/spreadsheets/d/13gnwAUXaxHATsZIGO3mPtdxLMxseE1oYNjgTV4tdFkk/edit#gid=0")

library(rvest) 
NanoStockUrl<-"https://fubon-ebrokerdj.fbs.com.tw/z/ze/zeg/zega_EBTW50E_I.djhtm"
NanoStockContent<-read_html(NanoStockUrl)
NanoStockName<-
  NanoStockContent %>% html_nodes("#oAddCheckbox") %>% 
  html_text()
NanoStockPrice<-
  NanoStockContent %>% html_nodes(".t3n1")%>% 
  html_text()
NanoStockPriceTable<-
  matrix(NanoStockPrice,ncol=6, byrow=TRUE)
NanoStockNameClean<-gsub('\\r|<|!|\\n|\\t|GenLink2stk|;|/|-|>',
                         '',
                         NanoStockName)
NanoStockData <- 
  data.frame(name = NanoStockNameClean,
             NanoStockPriceTable)
knitr::kable(NanoStockData) 

NanoStockData$X5<-gsub(",","",NanoStockData$X5)
NanoStockData$X5_new<-
  as.numeric(NanoStockData$X5)

NanoStockData$X5new<-
  as.numeric(gsub(",","",NanoStockData$X5))
NanoStockData$X4_new<-
  as.numeric(gsub(",","",NanoStockData$X4))


str(NanoStockData)
