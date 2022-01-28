library(tidyverse)
library(rvest)

ptturl_main<-"https://www.ptt.cc/"

#step 1 Load first page
ptt_html<-read_html(paste0(ptturl_main,"bbs/Tech_Job/index.html"))
#step 2 Get last page url node
lastpage_node<-html_nodes(ptt_html,".wide:nth-child(2)")
#step 3 Clean and get the url
lastpage_url<-html_attr(lastpage_node,"href")

lastpage_url_split<-
  strsplit(lastpage_url,"index|.html")
lastpage_index<-lastpage_url_split[[1]][2]
lastpage_index<-as.numeric(lastpage_index)

all_titles<-c()
all_urls<-c()
for(i in (lastpage_index-9):(lastpage_index+1)){
  page_html<-read_html(paste0(ptturl_main,"bbs/Tech_Job/index",i,".html"))
  titles <- page_html %>% html_nodes(".title a") %>% html_text()
  urls <- page_html %>% html_nodes(".title a") %>% html_attr("href")
  all_titles<-c(all_titles,titles)
  all_urls<-c(all_urls,urls)
}
all_contents<-c()
for(url in all_urls){
  final_url<-paste0(ptturl_main,url)
  page_html<-read_html(final_url)
  content <- page_html %>% html_nodes("#main-content") %>% html_text()
  content_split<-str_split(content,"發信站")
  all_contents<-c(all_contents,content_split[[1]])
}
all_contents