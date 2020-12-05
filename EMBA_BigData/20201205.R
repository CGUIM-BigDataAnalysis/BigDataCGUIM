# PTT
library(rvest)
ptt_html<-read_html("https://www.ptt.cc/bbs/Tech_Job/index.html")
title_nodes<-html_nodes(ptt_html,".title a")
titles1<-html_text(title_nodes)
titles1[3]

ptt_html<-read_html("https://www.ptt.cc/bbs/Tech_Job/index3891.html")
title_nodes<-html_nodes(ptt_html,".title a")
titles2<-html_text(title_nodes)
titles2[3]

ptt_html<-read_html("https://www.ptt.cc/bbs/Tech_Job/index3890.html")
title_nodes<-html_nodes(ptt_html,".title a")
titles3<-html_text(title_nodes)
titles3[3]


library(rtweet)
create_token(
  app = "teach0309",
  consumer_key = "Wbba6ysyPKGstGAqohmtyWZOE",
  consumer_secret = "GJweDzVvXGrbjz26bHTr3d6dFI7q9gFCH98f3Ct2yk3APPWigc",
  access_token = "216362944-AxxvSiPBR7nBScfBks7thajSovUwFG6v67aNR3WP",
  access_secret = "pF0OldOjiJxaBbPlQhx7V3VkA6MIgdzHHofar1DM0pX0G")


tmls <- get_timelines(c("iingwen"), n = 50)
View(tmls)
tmls$retweet_count[1]
tmls$favorite_count[2]

write.csv(iris,
          file="iris.csv",
          row.names = F)

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
             NanoStockPriceTable,
             stringsAsFactors = F)
NanoStockData
str(NanoStockData)

NanoStockData$X1<-
  gsub(",","",NanoStockData$X1)
NanoStockData$X1n<-
  as.numeric(NanoStockData$X1)

NanoStockData$X2<-
  gsub(",","",NanoStockData$X2)
NanoStockData$X2n<-
  as.numeric(NanoStockData$X2)






