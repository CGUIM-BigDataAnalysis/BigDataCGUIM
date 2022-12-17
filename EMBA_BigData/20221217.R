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
NanoStockNameClean<-
  gsub('\\r|<|!|\\n|\\t|GenLink2stk|;|/|-|>',
       '',NanoStockName)
NanoStockData <- 
  data.frame(name = NanoStockNameClean,
             NanoStockPriceTable)
knitr::kable(NanoStockData)

class(NanoStockData$X1)
is.numeric(NanoStockData$X1)
NanoStockData$X1<-
  gsub(",","",NanoStockData$X1)
as.numeric(NanoStockData$X1)
NanoStockData$Price<-
  as.numeric(NanoStockData$X1)
NanoStockData$X1<-
  as.numeric(NanoStockData$X1)

as.numeric(gsub(",","",NanoStockData$X2))
NanoStockData$X2<-
  gsub(",","",NanoStockData$X2) %>%
  as.numeric()

grep("A|a",
     c("Alex","Tom","Amy","Joy","Emma"))
