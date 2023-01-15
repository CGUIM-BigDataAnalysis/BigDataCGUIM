library(blastula)
library(glue)
library(kableExtra)
library(keyring)
library(tidyverse)
library(rvest)

## Do this once
# Store SMTP credentials in the system's key-value store with `provider = "gmail"`
#install.packages("keyring")
create_smtp_creds_file(
  file = "gmail_creds",
  user = "your_email@gmail.com", # put your email here
  provider = "gmail"
)

###### Excute the following codes every time you want to get data
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
all_push<-c()
all_date<-c()

for(i in (lastpage_index-9):(lastpage_index+1)){
  page_html<-
    read_html(paste0(ptturl_main,"index",i,".html"))
  titles <- 
    page_html %>% html_nodes(".title") %>% html_text()
  pushes <- 
    page_html %>% html_nodes(".nrec") %>% html_text()
  dates <- 
    page_html %>% html_nodes(".date") %>% html_text()
  all_titles<-c(all_titles,titles)
  all_push<-c(all_push,pushes)
  all_date<-c(all_date,dates)
}
pttData<-
  data.frame(Title=all_titles, Push=all_push, Date=all_date)
pttData$Title<-gsub("\n|\t","",pttData$Title)
gg_table<-pttData %>% filter(grepl("GG|TSMC|台積",Title))
gg_table$getDate<-Sys.Date()
write.table(gg_table,"gg.csv",sep = ",",append = TRUE, 
            col.names=!file.exists("gg.csv"),row.names = FALSE)

########################################################################
# How to send email in R
########################################################################

# Generate the body text
gg_result_tbl <- gg_table %>%
  kbl() %>%
  kable_styling()

body_text <-
  md(glue(
    "
Hello,

Here is the new article with GG:

{gg_result_tbl}

Cheers,

YJT
"
  ))

# Generate the footer text
sending_date<-Sys.Date()
footer_text <- glue("Sent on {sending_date}.")

# Compose the email message
final_email<-compose_email(body = body_text,
                          footer = footer_text)
final_email


# https://support.google.com/accounts/answer/6010255
# Sending email to a personal account using the credentials key
final_email %>%
  smtp_send(
    from = "cguim.emba@gmail.com", # use your gmail address here
    to = "yout_emal@gmail.com", # edit this line
    subject = "GG titles from ptt TechJob",
    credentials =  creds_file(file = "gmail_creds")
  )
########################################################################