library(rvest)

ptturl_main<-"https://www.ptt.cc/bbs/Tech_Job/"

#step 1 Load first page
ptt_html<-read_html(paste0(ptturl_main,"index.html"))
#step 2 Get last page url node
lastpage_node<-html_nodes(ptt_html,".wide:nth-child(2)")
#step 3 Clean and get the url
lastpage_url<-html_attr(lastpage_node,"href")

lastpage_url_split<-strsplit(lastpage_url,"index|.html")
lastpage_index<-lastpage_url_split[[1]][2]
lastpage_index<-as.numeric(lastpage_index)

all_titles<-c()
for(i in (lastpage_index-9):(lastpage_index+1)){
  page_html<-read_html(paste0(ptturl_main,"index",i,".html"))
  titles <- page_html %>% html_nodes(".title a") %>% html_text()
  all_titles<-c(all_titles,titles)
}
all_titles<-gsub("GG|gg|TSMC|tsmc","台積",all_titles)

gg_title<-all_titles[grepl("台積",all_titles)]
gg_result<-data.frame(title=gg_title,date=Sys.Date())

write.table(gg_result,"gg.csv",sep = ",",append = TRUE, 
            col.names=!file.exists("gg.csv"))

