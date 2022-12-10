library(rvest) ##載入
Repoterurl<-
  "https://www.twreporter.org/topics"
Repoterhtml<-read_html(Repoterurl)
news_title <- Repoterhtml %>% 
  html_nodes(".eIzpqT") %>% html_text()

title_nodes<-
  html_nodes(Repoterhtml,".iEVcId , .eIzpqT") 
news_title<-html_text(title_nodes)
news_title


## ptt
pttTJURL<-"https://www.ptt.cc/bbs/Tech_Job/index.html"
pttTJHtml<-read_html(pttTJURL)
titleNodes<-
  html_nodes(pttTJHtml,".title a")
titles<-html_text(titleNodes)
titles
titles[3]


## pipe ver
pttTJURL<-"https://www.ptt.cc/bbs/Tech_Job/index.html"
pttTJHtml<-read_html(pttTJURL)
pttTJHtml %>% 
  html_nodes(".title a") %>%
  html_text()


library(rtweet)
create_token(
  app = "teach0309",
  consumer_key = "Wbba6ysyPKGstGAqohmtyWZOE",
  consumer_secret = "GJweDzVvXGrbjz26bHTr3d6dFI7q9gFCH98f3Ct2yk3APPWigc",
  access_token = "216362944-AxxvSiPBR7nBScfBks7thajSovUwFG6v67aNR3WP",
  access_secret = "pF0OldOjiJxaBbPlQhx7V3VkA6MIgdzHHofar1DM0pX0G")
rt <- search_tweets(
  "#Taiwan", n = 100, 
  include_rts = FALSE
)
head(rt)

sf <- get_trends("USA")
head(sf)
sf <- get_trends("Japan")
head(sf)

## google sheet 4
library(googlesheets4)
# if you get the error 404
gs4_deauth()
read_sheet("https://docs.google.com/spreadsheets/d/13gnwAUXaxHATsZIGO3mPtdxLMxseE1oYNjgTV4tdFkk/edit#gid=0")

