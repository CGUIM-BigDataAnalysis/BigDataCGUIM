library(tidyverse)
library(rvest)

ptturl_main<-
  "https://www.ptt.cc/bbs/Tech_Job/"

#step 1 Load first page
ptt_html<-
  read_html(paste0(ptturl_main,"index.html"))
#step 2 Get last page url node
lastpage_node<-
  html_nodes(ptt_html,".wide:nth-child(2)")
#step 3 Clean and get the url
lastpage_url<-
  html_attr(lastpage_node,"href")

lastpage_index<-
  gsub("/bbs/Tech_Job/index|.html",
     "",lastpage_url)
lastpage_index<-
  as.numeric(lastpage_index)

all_titles<-c()
all_push<-c()
all_date<-c()

for(i in (lastpage_index-9):(lastpage_index+1)){
  page_html<-
    read_html(paste0(ptturl_main,"index",i,".html"))
  titles <- 
    page_html %>% 
    html_nodes(".title") %>% 
    html_text()
  pushes <- 
    page_html %>% 
    html_nodes(".nrec") %>% 
    html_text()
  dates <- 
    page_html %>% 
    html_nodes(".date") %>% 
    html_text()
  all_titles<-c(all_titles,titles)
  all_push<-c(all_push,pushes)
  all_date<-c(all_date,dates)
}
pttData<-
  data.frame(Title=all_titles,
             Push=all_push,
             Date=all_date)





