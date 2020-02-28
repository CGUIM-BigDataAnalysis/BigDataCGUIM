瀑布式網頁爬蟲方法
================
曾意儒 Yi-Ju Tseng 2017/03/17

不捲網頁，只爬看到的那一頁
--------------------------

一般靜態網頁爬蟲方法，以DCard為例

``` r
library(rvest)
library(stringr)
DCardCGU<-"https://www.dcard.tw/f/cgu?latest=true"
DCardContent<-read_html(DCardCGU, encoding = "UTF-8")
post_title <- DCardContent %>% html_nodes(".PostEntry_titleUnread_ycJL0") %>% html_text()
post_contentShort<- DCardContent %>% html_nodes(".PostEntry_excerpt_A0Bmh") %>% html_text()
post_author<- DCardContent %>% html_nodes(".PostAuthor_root_3vAJf") %>% html_text()
post_comment<- DCardContent %>% html_nodes(".PostEntry_commentUnread_1cVyd") %>% html_text()
post_like<- DCardContent %>% html_nodes(".PostLikeCount_likeCount_2uhBH") %>% html_text()
post_url <- DCardContent %>% html_nodes(".PostEntry_entry_2rsgm") %>% html_attr("href")
post_title<-gsub("[^[:alnum:]///' ]", "", post_title)
DCardCGU_posts <- data.frame(title = post_title, author=post_author, 
                            commentN=post_comment, likeN=post_like)
knitr::kable(DCardCGU_posts)
```

| title                                        | author                | commentN | likeN |
|:---------------------------------------------|:----------------------|:---------|:------|
| 明德樓唱歌的                                 | 長庚大學              | 37       | 25    |
| 校慶                                         | 長庚大學              | 20       | 5     |
| 明德熱水也太不穩了吧                         | 長庚大學              | 9        | 2     |
| 關於研究所推甄與考試                         | 長庚大學              | 9        | 1     |
| 暑期志工/實習招募囉                          | 長庚大學              | 0        | 8     |
| 問 資訊管理                                  | 長庚大學              | 4        | 1     |
| 資訊安全概論                                 | 長庚大學              | 6        | 2     |
| 夜店調查                                     | 長庚大學              | 49       | 12    |
| 皮夾遺失                                     | 長庚大學              | 4        | 6     |
| 據德寧靜不寧靜                               | 長庚大學              | 5        | 9     |
| iPhone 保護貼                                | iamwhoami             | 17       | 2     |
| 學餐                                         | 長庚大學              | 6        | 17    |
| 期中營招募凹嗚                               | 長庚大學              | 9        | 23    |
| 你一定要來一件的好漢帽踢                     | 長庚大學              | 11       | 80    |
| 長庚屠宰場                                   | 長庚大學              | 14       | 13    |
| 學餐天花板掉落                               | 長庚大學 資訊工程學系 | 4        | 32    |
| 車牌                                         | 長庚大學              | 6        | 9     |
| 明德地下室停車場好臭                         | 長庚大學              | 0        | 2     |
| 吵什麼                                       | 長庚大學              | 23       | 19    |
| 比賽賺錢囉                                   | 長庚大學              | 0        | 1     |
| 關於路燈                                     | 長庚大學              | 3        | 3     |
| 請問如果是已經繳費的商品寄到學校的話去哪裡拿 | 長庚大學              | 3        | 1     |
| 志清湖外汽車格如果收費好嗎                   | 長庚大學              | 21       | 2     |
| 漲漲漲                                       | 長庚大學              | 3        | 6     |
| 架中柱很難                                   | 長庚大學              | 6        | 3     |
| 誠徵對正念減壓課程有興趣的人                 | 長庚大學 職能治療學系 | 10       | 10    |
| 遺失眼鏡                                     | 長庚大學              | 4        | 3     |
| 問宿舍上下舖                                 | 長庚大學              | 16       | 1     |
| 正在吃晶讚自助餐的慎入                       | 長庚大學              | 15       | 30    |
| 問設導                                       | 長庚大學              | 1        | 1     |

使用Selenium模擬網頁瀏覽動作
----------------------------

在R中，如要與[Selenium](http://www.seleniumhq.org/)程式搭配，可以使用`RSelenium` package，在開始爬蟲前，請先安裝: 

- Java JVM (若已安裝可以不裝) 
- [Selenium Standalone Server](http://www.seleniumhq.org/download/) 
- [geckodriver](https://github.com/mozilla/geckodriver/releases) 
- [Firefox](https://www.mozilla.org/zh-TW/firefox/new/) 
- RSelenium package

首先打開RStudio，新增一個R Project（名稱隨意），安裝`RSelenium` package

``` r
install.packages("RSelenium")
```

2017/03/20能下載的Selenium Standalone Server最新版本為3.3.1，以下都以3.3.1版本為例，若安裝版本不同，請依版本修改指令(取代3.3.1)。

selenium-server-standalone-3.3.1.jar和geckodriver.exe放在同一個R projrct的資料夾內，打開cmd，進入R projrct的資料夾，執行

``` java
java -jar selenium-server-standalone-3.3.1.jar
```

執行後，保持cmd視窗開啟，回到RStudio，輸入以下程式碼

``` r
library(RSelenium)
library(rvest)
library(RCurl)
remDr <- remoteDriver(remoteServerAddr = "localhost", port = 4444L)
remDr$open()
```

如果看到下列文字表示RSelenium執行成功


    ## [1] "Connecting to remote server"
    ## $`moz:profile`
    ## [1] "C:\\Users\\yjtseng\\AppData\\Local\\Temp\\rust_mozprofile.E65vZOhEE8lB"
    ## 
    ## $rotatable
    ## [1] FALSE
    ## 
    ## $timeouts
    ## $timeouts$implicit
    ## [1] 0
    ## 
    ## $timeouts$`page load`
    ## [1] 3e+05
    ## 
    ## $timeouts$script
    ## [1] 30000
    ## 
    ## 
    ## $pageLoadStrategy
    ## [1] "normal"
    ## 
    ## $platform
    ## [1] "ANY"
    ## 
    ## $specificationLevel
    ## [1] 0
    ## 
    ## $`moz:accessibilityChecks`
    ## [1] FALSE
    ## 
    ## $webdriver.remote.sessionid
    ## [1] "48382f88-ff81-4f87-98ed-5fc796a556ca"
    ## 
    ## $acceptInsecureCerts
    ## [1] FALSE
    ## 
    ## $browserVersion
    ## [1] "52.0.1"
    ## 
    ## $platformVersion
    ## [1] "10.0"
    ## 
    ## $`moz:processID`
    ## [1] 13708
    ## 
    ## $browserName
    ## [1] "firefox"
    ## 
    ## $takesScreenshot
    ## [1] TRUE
    ## 
    ## $javascriptEnabled
    ## [1] TRUE
    ## 
    ## $platformName
    ## [1] "windows_nt"
    ## 
    ## $cssSelectorsEnabled
    ## [1] TRUE
    ## 
    ## $id
    ## [1] "48382f88-ff81-4f87-98ed-5fc796a556ca"


``` r
#navigate to your page
remDr$navigate("https://www.dcard.tw/f/cgu?latest=true")

#滾滑鼠滾到底五次
for(i in 1:5){      
    remDr$executeScript(paste("scroll(0,",i*10000,");"))
    Sys.sleep(5)    
}

#get the page html
page_source<-remDr$getPageSource()

DCardContent<-read_html(page_source[[1]],encoding = "UTF-8") 

##以下部分與上述靜態網頁爬取相同
post_title <- DCardContent %>% html_nodes(".PostEntry_titleUnread_ycJL0") %>% html_text()
post_contentShort<- DCardContent %>% html_nodes(".PostEntry_excerpt_A0Bmh") %>% html_text()
post_author<- DCardContent %>% html_nodes(".PostAuthor_root_3vAJf") %>% html_text()
post_comment<- DCardContent %>% html_nodes(".PostEntry_commentUnread_1cVyd") %>% html_text()
post_like<- DCardContent %>% html_nodes(".PostLikeCount_likeCount_2uhBH") %>% html_text()
post_url <- DCardContent %>% html_nodes(".PostEntry_entry_2rsgm") %>% html_attr("href")
post_title<-gsub("[^[:alnum:]///' ]", " ", post_title)
DCardCGU_posts <- data.frame(title = post_title, author=post_author,commentN=post_comment, likeN=post_like)
knitr::kable(DCardCGU_posts)
```

| title                                               | author                        | commentN | likeN |
|:----------------------------------------------------|:------------------------------|:---------|:------|
| 明德樓唱歌的                                        | 長庚大學                      | 37       | 25    |
| 校慶                                                | 長庚大學                      | 20       | 5     |
| 明德熱水也太不穩了吧                                | 長庚大學                      | 9        | 2     |
| 關於研究所推甄與考試                                | 長庚大學                      | 9        | 1     |
| 暑期志工/實習招募囉                                 | 長庚大學                      | 0        | 8     |
| 問 資訊管理                                         | 長庚大學                      | 4        | 1     |
| 資訊安全概論                                        | 長庚大學                      | 6        | 2     |
| 夜店調查                                            | 長庚大學                      | 49       | 12    |
| 皮夾遺失                                            | 長庚大學                      | 4        | 6     |
| 據德寧靜不寧靜                                      | 長庚大學                      | 5        | 9     |
| iPhone 保護貼                                       | iamwhoami                     | 17       | 2     |
| 學餐                                                | 長庚大學                      | 6        | 17    |
| 期中營招募凹嗚                                      | 長庚大學                      | 9        | 23    |
| 你一定要來一件的 好漢帽踢                           | 長庚大學                      | 11       | 80    |
| 長庚屠宰場                                          | 長庚大學                      | 14       | 13    |
| 學餐天花板掉落                                      | 長庚大學 資訊工程學系         | 4        | 32    |
| 車牌                                                | 長庚大學                      | 6        | 9     |
| 明德地下室停車場好臭                                | 長庚大學                      | 0        | 2     |
| 吵什麼                                              | 長庚大學                      | 23       | 19    |
| 比賽賺錢囉                                          | 長庚大學                      | 0        | 1     |
| 關於路燈                                            | 長庚大學                      | 3        | 3     |
| 請問如果是已經繳費的商品寄到學校的話去哪裡拿        | 長庚大學                      | 3        | 1     |
| 志清湖外汽車格如果收費好嗎                          | 長庚大學                      | 21       | 2     |
| 漲漲漲                                              | 長庚大學                      | 3        | 6     |
| 架中柱很難                                          | 長庚大學                      | 6        | 3     |
| 誠徵對正念減壓課程有興趣的人                        | 長庚大學 職能治療學系         | 10       | 10    |
| 遺失眼鏡                                            | 長庚大學                      | 4        | 3     |
| 問宿舍上下舖                                        | 長庚大學                      | 16       | 1     |
| 正在吃晶讚自助餐的慎入                              | 長庚大學                      | 15       | 30    |
| 問 設導                                             | 長庚大學                      | 1        | 1     |
| 想自己帶便當                                        | 長庚大學                      | 17       | 2     |
| 明德網路                                            | 長庚大學                      | 1        | 0     |
| 林口飛鏢                                            | 長庚大學                      | 10       | 3     |
| 勤勞樸實                                            | 長庚躺馬路                    | 16       | 103   |
| 交 友 配 對 長庚大學                                | 長庚大學                      | 4        | 8     |
| 你妹的據德警鈴                                      | 帥到沒人權                    | 3        | 12    |
| 長庚食記 麵13                                       | 長庚大學 呼吸治療學系         | 19       | 85    |
| 一個晚上警鈴是要響幾次                              | 長庚大學                      | 0        | 2     |
| 院區的cama徵白班店員                                | 長庚大學                      | 4        | 11    |
| 勤勞樸實到燈都不用開                                | 長庚大學                      | 4        | 26    |
| 校車會開到體大捷運站嗎                              | 長庚大學                      | 8        | 5     |
| 規定在哪                                            | 長庚大學                      | 47       | 30    |
| 暫停申請體適能中心會員                              | 長庚大學                      | 8        | 3     |
| 想成立 社                                           | 長庚大學                      | 25       | 32    |
| 想成立阿卡貝拉社                                    | 長庚大學                      | 12       | 22    |
| 腦磁圖 MEG 實驗                                     | 長庚大學 職能治療學系         | 1        | 8     |
| 收購二手古典短篇小說概論用書                        | 長庚大學 醫學影像暨放射科學系 | 6        | 1     |
| 桌遊社                                              | 長庚大學                      | 4        | 2     |
| 獎學金問題                                          | 長庚大學                      | 12       | 21    |
| 在學校遇到李榮浩                                    | 長庚大學 生物醫學系           | 11       | 13    |
| 圖 明德五樓高潮了                                   | 長庚大學                      | 1        | 30    |
| 基礎素描                                            | 長庚大學                      | 2        | 1     |
| 科大有社團請國手來授課                              | 長庚大學                      | 3        | 10    |
| 有人想跟我一起創社嗎                                | 長庚大學 醫學影像暨放射科學系 | 42       | 97    |
| 影像中的社會與文化                                  | 長庚大學                      | 5        | 1     |
| 中藥的養生保健與美容                                | 長庚大學                      | 8        | 4     |
| 投資理財分享                                        | 長庚大學                      | 11       | 19    |
| 長庚醫院大專志工隊                                  | 長庚大學                      | 6        | 11    |
| 誰的襪襪                                            | 長庚大學                      | 4        | 3     |
| 求幫一個忙                                          | 長庚大學                      | 5        | 2     |
| 總務處來貼警告單來嘍                                | 長庚大學 資訊管理學系         | 8        | 16    |
| 長庚約會好去處get                                   | 長庚大學                      | 35       | 93    |
| 誰的鞋子                                            | 長庚大學                      | 1        | 1     |
| 水果蛋糕                                            | 長庚大學                      | 12       | 22    |
| 狂人                                                | 長庚大學                      | 12       | 32    |
| 販賣機吃錢                                          | 長庚大學                      | 4        | 0     |
| 妳的側臉                                            | 長庚大學                      | 26       | 45    |
| 宿網                                                | 長庚大學                      | 6        | 3     |
| 桃捷統計快來看看                                    | 長庚大學                      | 7        | 13    |
| 問 有關機車                                         | 長庚大學                      | 3        | 0     |
| 二醫花生什麼事                                      | 長庚大學                      | 5        | 3     |
| 智慧財產權                                          | 長庚大學 生物醫學系           | 4        | 2     |
| 桌球男孩                                            | 長庚大學                      | 21       | 9     |
| 學期成績名次                                        | 長庚大學                      | 10       | 0     |
| 網購退貨                                            | 長庚大學                      | 3        | 0     |
| 請益 數位革新 智慧型人機介面                        | 長庚大學                      | 0        | 0     |
| 請問 中國近 現代史 多元                             | 長庚大學                      | 4        | 1     |
| 請益 台灣詩鄉土情                                   | 長庚大學                      | 1        | 1     |
| 問7 11地址                                          | 長庚大學                      | 5        | 1     |
| 請益 電影與音樂                                     | 長庚大學                      | 5        | 0     |
| 幫高調                                              | 長庚大學                      | 20       | 66    |
| 請益 文學與人生                                     | 長庚大學                      | 4        | 0     |
| 菸品                                                | 長庚大學                      | 8        | 7     |
| 學校有撞球高手嗎                                    | 長庚大學                      | 8        | 4     |
|                                                     | 長庚大學                      | 5        | 28    |
| 遺失鑰匙                                            | 長庚大學 工商管理學系         | 0        | 2     |
| 美麗的沙茶                                          | 長庚大學                      | 4        | 8     |
| 選課指南針                                          | 長庚大學                      | 6        | 7     |
| 請益 營養與保健                                     | 長庚大學                      | 5        | 2     |
| 請益道家思想                                        | 長庚大學                      | 1        | 0     |
| 啊啊啊啊啊啊                                        | 長庚大學 醫學系               | 5        | 1     |
| 宿網雷                                              | 長庚大學                      | 9        | 19    |
| 宿網                                                | 長庚大學                      | 5        | 5     |
| 妳的背影                                            | 長庚大學                      | 33       | 38    |
| 管院萊爾富                                          | 榦你娘                        | 13       | 27    |
| 明德樓又沒水壓了啦                                  | 長庚大學                      | 1        | 2     |
| 宿舍網路問題                                        | 長庚大學                      | 3        | 1     |
| 短髮藍外套女孩                                      | 長庚大學                      | 14       | 6     |
| 通識 倫理與美學                                     | 長庚大學                      | 6        | 2     |
| 果汁阿姨                                            | 長庚大學                      | 2        | 15    |
| 關於停車證                                          | 長庚大學                      | 9        | 2     |
| 請益通識 藥物 食品                                  | 長庚大學                      | 1        | 0     |
| 和我說早安的發聲練習                                | 長庚大學                      | 4        | 5     |
| 庚心影印室洗照片                                    | 長庚大學                      | 4        | 3     |
| 我 看 到 了                                         | 長庚大學 電機工程學系         | 2        | 30    |
| 校車遺失物遭竊 請注意                               | 長庚大學                      | 6        | 8     |
| 圖書館置物櫃誤領                                    | 長庚大學 資訊工程學系         | 1        | 3     |
| 中醫系的生死學                                      | 長庚大學                      | 9        | 4     |
| 招募長庚大學學生進行數學學習策略之腦波實驗          | 長庚大學                      | 1        | 4     |
| 醫用台語                                            | 長庚大學                      | 6        | 1     |
| 學校操場                                            | 長庚大學                      | 6        | 7     |
| 榮譽戰魂For Honor都找不到對戰                       | 長庚大學 化工與材料工程學系   | 6        | 5     |
| 宿網登不進去                                        | 長庚大學                      | 6        | 0     |
| 問 第二代來臨                                       | 長庚大學                      | 5        | 1     |
| 機場捷運試乘                                        | 長庚大學 生物醫學系           | 19       | 88    |
| 圖書館置物櫃的問題                                  | 長庚大學                      | 4        | 3     |
| 邀請大家來修的課                                    | 長庚大學                      | 7        | 32    |
| 蘊德樓的熱水                                        | 長庚大學                      | 7        | 8     |
| 有關健身房如何申請                                  | 長庚大學                      | 9        | 0     |
| 英文工作坊                                          | 長庚大學                      | 8        | 2     |
| 英文簡報技巧                                        | 長庚大學                      | 2        | 3     |
| 要開學囉                                            | 長庚大學                      | 10       | 7     |
| 誠徵 腦波實驗 受試者 曾為左撇子                     | 長庚大學                      | 3        | 2     |
| 明德樓浴室水壓不穩                                  | 長庚大學                      | 15       | 6     |
| 今天是怎樣                                          | 長庚大學                      | 6        | 7     |
| 蘊德停水                                            | 長庚大學                      | 4        | 2     |
| 228彈性放假疑問                                     | 長庚大學                      | 13       | 5     |
| 繳學費                                              | 長庚大學                      | 9        | 5     |
| 遇到的 聽到的                                       | 長庚大學                      | 10       | 5     |
| 工學院交換學生                                      | 長庚大學                      | 7        | 9     |
| 正妹報報                                            | 長庚大學                      | 14       | 11    |
| 關於計程車的問題                                    | 長庚大學                      | 16       | 2     |
| 有關於吃藥                                          | 長庚大學                      | 14       | 5     |
| 重機駕訓班                                          | 長庚大學                      | 10       | 14    |
| 想包紅包給女友                                      | 長庚大學                      | 15       | 67    |
| 過年快樂                                            | 長庚大學                      | 12       | 50    |
| 課程 105上 黃寬重 中國近世歷史與世人文化            | 選課雷達                      | 0        | 9     |
| 課程 105下 陳信壅骨科職能治療及副木學               | 選課雷達                      | 13       | 5     |
| 課程 105上 洪進丁西洋美術巡禮                       | 選課雷達                      | 0        | 1     |
| 課程 105上 陳麗如 現代公民的社會學想像              | 選課雷達                      | 5        | 7     |
| 課程 105上 洪于淳 歌劇與歌劇院                      | 選課雷達                      | 2        | 1     |
| 課程 105上 陳英淙 人權與民主法治                    | 選課雷達                      | 0        | 1     |
| 課程 105上 陳惠茹 人際溝通                          | 選課雷達                      | 2        | 2     |
| 課程 105上 許清山 微積分 一                         | 選課雷達                      | 0        | 4     |
| 課程 105上 陳麗如特殊教育導論                       | 選課雷達                      | 1        | 13    |
| 課程 104下 白裕彬 生物醫學辭彙                      | 選課雷達                      | 0        | 1     |
| 課程 105上 王賀白 政治學與現代公民                  | 選課雷達                      | 6        | 7     |
| 課程 104上 邸彥 哲學與文化                          | 選課雷達                      | 1        | 2     |
| 課程 105下 陳耀東 管理經濟                          | 選課雷達                      | 0        | 0     |
| 關於通識 推推                                       | 長庚大學                      | 0        | 3     |
| 醫療與社會 的艱辛                                   | 長庚大學                      | 7        | 29    |
| 請問有同學撿到錢包嗎                                | 長庚大學 資訊管理學系         | 0        | 4     |
| 問分數                                              | 長庚大學                      | 11       | 3     |
| 謝謝妳                                              | 長庚大學                      | 8        | 16    |
| 課程 105上 林永修管理學                             | 選課雷達                      | 1        | 2     |
| 課程 105上 王友蘭 說唱文學                          | 選課雷達                      | 3        | 5     |
| 課程 103上 邸彥 哲學與文化                          | 選課雷達                      | 1        | 4     |
| 課程 104下 曾華璧文化與歷史思維                     | 選課雷達                      | 0        | 4     |
| 課程 105上 黃寬重中國近世歷史與士人文化             | 選課雷達                      | 0        | 2     |
| 課程 105上 韓學宏寓言經典與多元思維                 | 選課雷達                      | 3        | 5     |
| 課程 105上 蘇家榮 大數據概論                        | 選課雷達                      | 0        | 3     |
| 課程 105上 王友蘭 說唱文學與藝術賞析                | 選課雷達                      | 0        | 0     |
| 課程 105上 林永修 管理學                            | 選課雷達                      | 0        | 1     |
| 課程 104下 吳文傑 程式設計二                        | 選課雷達                      | 7        | 2     |
| 課程 104下 鄭惠芳 倫理與美學 電影與戲劇中的莎士比亞 | 選課雷達                      | 0        | 1     |
| 課程 104上 王賀白 政治學與現代公民                  | 選課雷達                      | 3        | 1     |
| 課程 105上 蘇紹勤 科技法律                          | 選課雷達                      | 0        | 2     |
| 課程 105ㄕㄤ 廖俊瑋動力學                           | 選課雷達                      | 2        | 0     |
| 課程 105上 徐慧鈺台灣古典文學選讀                   | 選課雷達                      | 2        | 1     |
| 課程 105上 胡正申 社會心理                          | 選課雷達                      | 0        | 4     |
| 課程 105上 韓學宏 寓言 經典與多元思維               | 選課雷達                      | 0        | 0     |
| 課程 105上 曾華璧 文化與歷史思維                    | 選課雷達                      | 0        | 2     |
| 課程 105上 104上 104下 蘇文慧 陳嘉祥 楊雅晴專題討論 | 選課雷達                      | 0        | 0     |
| 課程 105上 江正誠 中國繪畫入門                      | 選課雷達                      | 0        | 1     |
| 課程 105上 周悅如 音樂的語言                        | 選課雷達                      | 3        | 0     |
| 課程 105上 黃寬重 中國近世歷史與士人文化            | 選課雷達                      | 0        | 0     |
| 課程 104下 楊吉林 英文工作坊                        | 選課雷達                      | 0        | 3     |
| 課程 105上 何金龍 普通物理                          | 選課雷達                      | 0        | 2     |
| 課程 105上 劉德玲 詩詞選讀                          | 選課雷達                      | 0        | 0     |
| 課程 105上 陳麗如 生涯發展與規劃                    | 選課雷達                      | 4        | 1     |

參考資料
--------

-   [StackOverflow問答](http://stackoverflow.com/questions/29861117/r-rvest-scraping-a-dynamic-ecommerce-page)
-   [RSelenium Github Issue](https://github.com/ropensci/RSelenium/issues)
-   [RSelenium文件](https://cran.r-project.org/web/packages/RSelenium/vignettes/RSelenium-basics.html)

後記
----

花了一點時間用自動化的方式處理瀑布式網頁的爬取，有問題可以歡迎留言討論。另外，我也嘗試過使用Google Chrome瀏覽器，搭配chromedrive，但一直卡關，後來試了firefox就沒問題，目前原因不明~

執行環境
--------

``` r
sessionInfo()
```

    ## R version 3.3.2 (2016-10-31)
    ## Platform: x86_64-w64-mingw32/x64 (64-bit)
    ## Running under: Windows 10 x64 (build 14393)
    ## 
    ## locale:
    ## [1] LC_COLLATE=Chinese (Traditional)_Taiwan.950 
    ## [2] LC_CTYPE=Chinese (Traditional)_Taiwan.950   
    ## [3] LC_MONETARY=Chinese (Traditional)_Taiwan.950
    ## [4] LC_NUMERIC=C                                
    ## [5] LC_TIME=Chinese (Traditional)_Taiwan.950    
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ##  [1] RSelenium_1.4.5      XML_3.98-1.4         RCurl_1.95-4.8      
    ##  [4] bitops_1.0-6         stringr_1.0.0        rvest_0.3.2         
    ##  [7] xml2_1.0.0           RevoUtilsMath_10.0.0 RevoUtils_10.0.2    
    ## [10] RevoMods_10.0.0      MicrosoftML_1.0.0    mrsdeploy_1.0       
    ## [13] RevoScaleR_9.0.1     lattice_0.20-34      rpart_4.1-10        
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] Rcpp_0.12.7            CompatibilityAPI_1.1.0 knitr_1.14.14         
    ##  [4] magrittr_1.5           rjson_0.2.15           R6_2.2.0              
    ##  [7] foreach_1.4.3          highr_0.6              httr_1.2.1            
    ## [10] caTools_1.17.1         tools_3.3.2            grid_3.3.2            
    ## [13] selectr_0.3-0          htmltools_0.3.5        iterators_1.0.8       
    ## [16] yaml_2.1.13            digest_0.6.10          rprojroot_1.1         
    ## [19] codetools_0.2-15       curl_2.2               evaluate_0.10         
    ## [22] rmarkdown_1.3.1        stringi_1.1.2          backports_1.0.4       
    ## [25] jsonlite_1.1
