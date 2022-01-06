library(tidyverse)

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

########################################################################
# How to send email in R
########################################################################
library(blastula)
library(glue)
library(kableExtra)
# Generate the body text
gg_result_tbl <- gg_result %>%
  kbl() %>%
  kable_styling()

body_text <-
  md(glue(
    "
Hello,

Here is the new title with GG:

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

# Store SMTP credentials in the system's key-value store with `provider = "gmail"`
#install.packages("keyring")
create_smtp_creds_key(
  id = "my_gmail",
  user = "your.gmail@gmail.com", # use your gmail address here
  provider = "gmail",overwrite = TRUE
)
# https://support.google.com/accounts/answer/6010255
# Sending email to a personal account using the credentials key
final_email %>%
  smtp_send(
    from = "someones.gmail@gmail.com", # use your gmail address here
    to = "your.gmail@gmail.com", # edit this line
    subject = "GG titles from ptt TechJob",
    credentials = creds_key(id = "my_gmail")
  )
########################################################################