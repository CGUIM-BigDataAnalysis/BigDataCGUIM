library(rvest)
indexUrl<-"https://www.ptt.cc/bbs/Tech_Job/index.html"
baseUrl <- "https://www.ptt.cc/bbs/Tech_Job/index"


############################################################
#方法一
############################################################
##將按鈕名稱與按鈕URL存進bt資料框
indexHtml<-read_html(indexUrl) 
bt <- data.frame(text = indexHtml%>% html_nodes(".wide")%>% html_text() ,
                url = indexHtml %>% html_nodes(".wide")%>% html_attr("href"),
                stringsAsFactors = F)

##根據網頁上排按鈕找出文字是"上頁"按紐的URL
beforeUrl<-bt[grepl("上頁",bt$text),"url"]
############################################################
#方法二
############################################################
##直接取
beforeUrl<-indexHtml %>% html_nodes(".wide:nth-child(2)") %>% 
    html_attr("href")


##過濾掉多餘的字元
pageNumber <- gsub("/bbs/Tech_Job/index|.html","",beforeUrl)
pageNumber <- as.numeric(pageNumber)

##迴圈抓Title
AllTitle <- NULL
for(n in 1:-9){
    pageUrl <- paste0(baseUrl,pageNumber+n,".html")
    tempTile <- read_html(pageUrl) %>% html_nodes(".title a") %>% html_text()
    AllTitle<-c(AllTitle,tempTile)
    print(paste("Page:", pageNumber+n))
}
AllTitle
