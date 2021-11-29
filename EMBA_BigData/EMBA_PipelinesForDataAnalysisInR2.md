Pipelines For Data Analysis In R, part 2
========================================================
author: 曾意儒 Yi-Ju Tseng
autosize: true
font-family: 'Microsoft JhengHei'
navigation: slide

資料分析步驟
========================================================
- **資料匯入** 
- **資料清洗處理**並轉換為Tidy data
- 資料分析
- 資料呈現與視覺化

資料匯入
====================================
- 從檔案匯入
- 從網路匯入
- 從Twitter匯入
- 資料匯出

從檔案匯入
====================================
type:section
- Import Dataset功能 (RStudio)
- R物件 .rds
- R程式 .R
- 純文字資料 (無分隔)
- 其他格式

Import Dataset功能 (RStudio)
====================================
選取RStudio四分割視窗右上角的Environment標籤，選擇**Import Dataset**

![plot of chunk unnamed-chunk-1](figures/import.png)

Import Dataset功能 (RStudio)
====================================
- 選取`From CSV`
- 點選`Browse`按鈕開啟檔案選取器

![plot of chunk unnamed-chunk-2](figures/csv.png)

Import Dataset功能 (RStudio)
====================================
- 利用下方`Import Options`的選項微調參數
    - `Delimiter`分隔符號
    - `First Row as Names`首列是否為欄位名稱
    
![plot of chunk unnamed-chunk-3](figures/csv2.png)

Import Dataset功能 (RStudio)
====================================
type:alert
incremental:true

- 操作[範例檔案](https://raw.githubusercontent.com/CGUIM-BigDataAnalysis/BigDataCGUIM/master/EMBA_BigData/f_lvr_land_a.csv)
- 若匯入的檔案為**tab分隔文字檔**? 該如何調整參數？


R物件 .rds
====================================
type:sub-section
如果在R程式內處理完資料後，必須儲存一份以供後續分析，使用R物件儲存是最佳的方式

- 檔案小
- 讀取快速
- 推薦使用`readRDS()`函數讀取RDS檔案
- [A better way of saving and loading objects in R](http://www.fromthebottomoftheheap.net/2012/04/01/saving-and-loading-r-objects/)

```r
dataset <- readRDS("檔案路徑與名稱")
```

R程式 .R
====================================
type:sub-section
- `source`函數
- 讀R的Obejct or script, **執行**
- **實際操作範例**
    - 有一份example.R檔在工作環境中
    - 一次執行檔案內所有R指令

```r
source("example.R") 
```

純文字資料 (無分隔)
====================================
type:sub-section
`readLines`, 逐行讀取文字資料

從網路匯入
====================================
type:section

- Open Data
- XML 可延伸標記式語言
- 網頁爬蟲 Webscraping
- API (Application programming interfaces)
- JSON格式檔案

Open Data 開放資料
====================================
type:sub-section
- 2011年推動開放政府與開放資料 ([維基百科](https://zh.wikipedia.org/wiki/%E9%96%8B%E6%94%BE%E8%B3%87%E6%96%99))
- 不受著作權、專利權，以及其他管理機制所限制，任何人都可以自由出版使用
- 常見的儲存方式為: 
    - `CSV`
    - `JSON`
    - `XML`
    
Open Data 開放資料常見平台
====================================
- [政府資料開放平台](http://data.gov.tw/)
- [Data Taipei](http://data.taipei/)
- [開放資料 x 開放桃園](http://data.tycg.gov.tw/)
- [內政資料開放平台](http://data.moi.gov.tw/)

XML 可延伸標記式語言
====================================
type:sub-section

- E**x**tensible **m**arkup **l**anguage
- 描述**結構化**資料的語言
- 處理XML檔案是網頁**Html**爬蟲的基礎
- Components
    - Markup 標記 - labels that give the text structure
    - Content 內文 - the actual text of the document
- [XML Wiki](https://zh.wikipedia.org/wiki/XML)

XML 可延伸標記式語言
====================================
Tags, elements and attributes

- Tags correspond to general labels
    - Start tags `<breakfast_menu>`, `<price>`
    - End tags `</breakfast_menu>`,`</price>`
    - Empty tags `<line-break />`
- Elements are specific examples of tags
    - `<name>Belgian Waffles</name>`
- Attributes are components of the label
    - `<book category="web">`
    
XML 可延伸標記式語言-讀取
====================================
- [空氣品質指標(AQI)](https://data.epa.gov.tw/api/v1/aqx_p_432?limit=1000&api_key=9be7b239-557b-4c10-9775-78cadfc555e9&format=xml)
- 安裝`xml2` package
- `xmlParse()`函數將XML檔案匯入


```r
library(xml2)
AQIURL<-"https://data.epa.gov.tw/api/v1/aqx_p_432?limit=1000&api_key=9be7b239-557b-4c10-9775-78cadfc555e9&format=xml"
AQIXML <- read_xml(AQIURL)
```

xpath?
====================================
- XML路徑語言（XML Path Language）
- 基於XML的樹狀結構，提供在資料結構樹中找尋節點的能力
- [維基百科](https://zh.wikipedia.org/wiki/XPath)
- [常見語法](http://tech-marsw.logdown.com/blog/2016/01/11/parsing-lxml-xpath-sheet)

XML 可延伸標記式語言-解析
====================================
使用`xml_find_all()`以及`xml_text()`函數取得指定標籤內的資料

```r
#取得所有"code_name"標籤內的資料
code_name_xml<-xml_find_all(AQIXML, ".//SiteName")
code_name<-xml_text(code_name_xml)
code_name[1:10]
```

```
 [1] "\u57fa\u9686" "\u6c50\u6b62" "\u842c\u91cc" "\u65b0\u5e97" "\u571f\u57ce"
 [6] "\u677f\u6a4b" "\u65b0\u838a" "\u83dc\u5bee" "\u6797\u53e3" "\u6de1\u6c34"
```

XML 可延伸標記式語言-解析
====================================
使用`xml_find_all()`以及`xml_text()`函數取得指定標籤內的資料

```r
#取得各監測站的經度longitude
longitude_xml<-xml_find_all(AQIXML, ".//Longitude")
longitude<-xml_text(longitude_xml)
longitude[1:10]
```

```
 [1] "121.760056" "121.6423"   "121.689881" "121.537778" "121.451861"
 [6] "121.458667" "121.4325"   "121.481028" "121.376869" "121.449239"
```

XML檔案匯入練習
====================================
type:alert
incremental:true
- 載入[農產品交易行情](https://data.coa.gov.tw/Service/OpenData/FromM/FarmTransData.aspx?FOTT=Xml)
- 嘗試取得各筆交易的作物名稱與平均價
- 參考剛剛的AQI範例

```r
library(xml2)
AQIURL<-"https://data.epa.gov.tw/api/v1/aqx_p_432?limit=1000&api_key=9be7b239-557b-4c10-9775-78cadfc555e9&format=xml"
AQIXML <- read_xml(AQIURL)
code_name_xml<-xml_find_all(AQIXML, ".//SiteName")
code_name<-xml_text(code_name_xml)
code_name[1:10]
```



API
====================================
type:sub-section
- 應用程式介面
- **A**pplication **P**rogramming **I**nterfaces
- 為了讓第三方的開發者可以額外開發應用程式來強化他們的產品，推出可以與系統溝通的介面
- 有API輔助可將資料擷取過程自動化
    -  以下載Open Data為例，若檔案更新頻繁，使用手動下載相當耗時
- [維基百科](https://zh.wikipedia.org/zh-tw/%E5%BA%94%E7%94%A8%E7%A8%8B%E5%BA%8F%E6%8E%A5%E5%8F%A3)

API - Open Data
====================================
- [桃園公共自行車即時服務資料](http://data.tycg.gov.tw/opendata/datalist/datasetMeta?oid=5ca2bfc7-9ace-4719-88ae-4034b9a5a55c)資料
- 每日更新
- 不可能每日手動下載
- 提供透過**API**下載的服務
- 透過API下載的資料格式: **JSON格式**

***

- [桃園公共自行車即時服務資料API資訊](http://data.tycg.gov.tw/opendata/datalist/datasetMeta/outboundDesc?id=5ca2bfc7-9ace-4719-88ae-4034b9a5a55c&rid=a1b4714b-3b75-4ff8-a8f2-cc377e4eaa0f)
    - **資料集ID**: 紀錄資料的基本參數，如包含欄位、更新頻率等
    - **資料RID**: 資料集
    - 擷取範例


JSON格式檔案
====================================
type:sub-section

- JSON (**J**ava**s**cript **O**bject **N**otation)
- 輕量級的資料交換語言
- From **a**pplication **p**rogramming **i**nterfaces (APIs)
- JavaScript、Java、Node.js應用
- 一些NoSQL資料庫用JSON儲存資料：**MongoDB**
- [Wiki](http://en.wikipedia.org/wiki/JSON)


JSON檔案匯入
====================================
- `jsonlite` package (套件使用前必須安裝)
- `fromJSON()`函數載入JSON資料
- 如果API網址為**https**，則需使用 `httr` package
    - 使用`GET()`函數處理資料擷取網址
- API網址參考[桃園公共自行車即時服務資料API資訊](http://data.tycg.gov.tw/opendata/datalist/datasetMeta/outboundDesc?id=5ca2bfc7-9ace-4719-88ae-4034b9a5a55c&rid=a1b4714b-3b75-4ff8-a8f2-cc377e4eaa0f)

```r
library(jsonlite)
library(RCurl)
APIData<-fromJSON("http://data.tycg.gov.tw/api/v1/rest/datastore/a1b4714b-3b75-4ff8-a8f2-cc377e4eaa0f?format=json")
```

JSON檔案匯入
====================================
- 轉存為`列表list`的型態
- 兩個子元素(success, result)
- result中records子元素的類別為資料框data.frame

```r
str(APIData)
```

JSON檔案解析
====================================
- 使用`$`符號截取元素與子元素

```r
head(APIData$result$records)
```


JSON檔案解析
====================================
分析各項**地區**車站數

```r
table(APIData$result$records$sarea)
```

分析可知中壢區車站較多


JSON檔案匯入練習
====================================
type:alert
incremental:true

- 練習用資料：[「空氣品質資料」API存取](https://data.epa.gov.tw/api/v1/aqx_p_432?limit=1000&api_key=9be7b239-557b-4c10-9775-78cadfc555e9&format=json)
- 使用檔案匯入**範例**，將資料匯入R中
    - 提示：**fromJSON**
- 使用str()函數觀察匯入的資料
- 請問有幾筆觀察值？幾個欄位？


網頁爬蟲 Webscraping
====================================
type:sub-section

- 不是每個網站都提供API
- 人工複製貼上?!
- 程式化的方式擷取網頁資料: **網頁爬蟲（Webscraping）**（[Webscraping Wiki](http://en.wikipedia.org/wiki/Web_scraping)）
- 可能耗費很多網頁流量和資源 －很可能被鎖IP
- 在R的處理辦法
    - 當作XML檔案處理分析
    - 使用`rvest` package輔助

網頁爬蟲 Webscraping-rvest
====================================

載入[rvest](https://github.com/hadley/rvest)套件後，經由以下步驟進行網站解析：

- 使用`read_html(“欲擷取的網站網址”)`函數讀取網頁
- 使用`html_nodes()`函數擷取所需內容 (條件為CSS或xpath標籤)
- 使用`html_text()`函數處理/清洗擷取內容，留下需要的資料
- 使用`html_attr()`函數擷取資料參數（如連結url）

網頁爬蟲 Webscraping-rvest
====================================

```r
library(rvest) ##載入
Repoterurl<-"https://www.twreporter.org/topics"
Repoterhtml<-read_html(Repoterurl)
news_title <- Repoterhtml %>% 
    html_nodes(".kmupWO") %>% html_text()
news_title
```

```
character(0)
```


網頁爬蟲 Webscraping-rvest
====================================
- 擷取條件的撰寫會因網頁語法不同而有差異
- 使用**Google Chrome開發工具**輔助觀察擷取資料的條件
    - 或使用**SelectorGadget**輔助
    - 或使用**xpath-helper**輔助xpath標籤的擷取
- 觀察需要擷取的資料所在HTML片段
    - css class為`.kmupWO`



盤中奈米股資料爬取 -1
====================================
[零股資料](https://fubon-ebrokerdj.fbs.com.tw/z/ze/zeg/zega_EBTW50E_I.djhtm)

```r
library(rvest) 
NanoStockUrl<-"https://fubon-ebrokerdj.fbs.com.tw/z/ze/zeg/zega_EBTW50E_I.djhtm"
NanoStockContent<-read_html(NanoStockUrl)
NanoStockName<-
  NanoStockContent %>% html_nodes("#oAddCheckbox") %>% 
    html_text()
NanoStockPrice<-
  NanoStockContent %>% html_nodes(".t3n1")%>% 
    html_text()

head(NanoStockName)
```

```
[1] "\r\n\r\n<!--\r\n\tGenLink2stk('AS1101','\u53f0\u6ce5');\r\n//-->\r\n"      
[2] "\r\n\r\n<!--\r\n\tGenLink2stk('AS1216','\u7d71\u4e00');\r\n//-->\r\n"      
[3] "\r\n\r\n<!--\r\n\tGenLink2stk('AS1301','\u53f0\u5851');\r\n//-->\r\n"      
[4] "\r\n\r\n<!--\r\n\tGenLink2stk('AS1303','\u5357\u4e9e');\r\n//-->\r\n"      
[5] "\r\n\r\n<!--\r\n\tGenLink2stk('AS1326','\u53f0\u5316');\r\n//-->\r\n"      
[6] "\r\n\r\n<!--\r\n\tGenLink2stk('AS1402','\u9060\u6771\u65b0');\r\n//-->\r\n"
```

```r
head(NanoStockPrice)
```

```
[1] "46.80"      "312,870"    "88"         "46.80"      "11,948"    
[6] "14,640,568"
```

盤中奈米股資料爬取 -2
====================================

```r
NanoStockPriceTable<-
  matrix(NanoStockPrice,ncol=6, byrow=TRUE)
NanoStockNameClean<-gsub('\\r|<|!|\\n|\\t|GenLink2stk|;|/|-|>',
                         '',
                         NanoStockName)
NanoStockData <- 
    data.frame(name = NanoStockNameClean,
               NanoStockPriceTable)
```

盤中奈米股資料爬取 -3
====================================

```r
NanoStockData
```

|name                    |X1       |X2        |X3 |X4       |X5     |X6          |
|:-----------------------|:--------|:---------|:--|:--------|:------|:-----------|
|('AS1101','台泥')       |46.80    |312,870   |88 |46.80    |11,948 |14,640,568  |
|('AS1216','統一')       |67.90    |26,118    |78 |67.60    |2,905  |1,767,902   |
|('AS1301','台塑')       |104.00   |23,046    |73 |103.50   |4,358  |2,398,345   |
|('AS1303','南亞')       |84.50    |50,332    |84 |84.50    |4,299  |4,267,448   |
|('AS1326','台化')       |80.20    |30,892    |75 |79.90    |2,925  |2,471,906   |
|('AS1402','遠東新')     |28.35    |32,077    |72 |28.30    |4,671  |910,453     |
|('AS1590','亞德客KY')   |815.00   |2,790     |68 |820.00   |106    |2,281,891   |
|('AS2002','中鋼')       |33.15    |122,260   |88 |33.15    |20,133 |4,074,994   |
|('AS2207','和泰車')     |622.00   |4,011     |70 |617.00   |500    |2,503,791   |
|('AS2303','聯電')       |62.80    |253,959   |88 |62.60    |22,349 |16,046,281  |
|('AS2308','台達電')     |253.50   |111,614   |87 |253.50   |4,606  |28,370,234  |
|('AS2317','鴻海')       |104.00   |611,850   |88 |104.00   |71,403 |63,755,637  |
|('AS2327','國巨')       |455.50   |60,424    |88 |452.50   |3,089  |27,707,117  |
|('AS2330','台積電')     |595.00   |1,202,073 |88 |596.00   |65,102 |716,989,476 |
|('AS2357','華碩')       |357.50   |21,270    |82 |357.50   |1,960  |7,616,542   |
|('AS2379','瑞昱')       |533.00   |16,926    |81 |532.00   |1,075  |9,074,960   |
|('AS2382','廣達')       |86.50    |32,924    |87 |86.60    |4,500  |2,864,690   |
|('AS2395','研華')       |375.50   |4,162     |53 |376.50   |445    |1,575,286   |
|('AS2408','南亞科')     |73.60    |43,076    |84 |73.50    |4,838  |3,184,687   |
|('AS2409','友達')       |20.65    |60,440    |85 |20.65    |4,573  |1,261,189   |
|('AS2412','中華電')     |112.50   |24,050    |76 |113.00   |4,304  |2,717,337   |
|('AS2454','聯發科')     |1,000.00 |145,170   |88 |1,005.00 |5,254  |145,883,495 |
|('AS2603','長榮')       |119.00   |471,402   |88 |119.50   |12,721 |57,061,856  |
|('AS2609','陽明')       |108.50   |222,121   |88 |109.00   |9,023  |24,608,004  |
|('AS2615','萬海')       |153.00   |100,060   |88 |153.00   |13,334 |15,494,900  |
|('AS2801','彰銀')       |16.95    |24,143    |61 |17.00    |8,220  |410,218     |
|('AS2880','華南金')     |20.65    |155,157   |85 |20.65    |12,133 |3,208,916   |
|('AS2881','富邦金')     |74.40    |183,710   |88 |74.50    |19,580 |13,706,489  |
|('AS2882','國泰金')     |60.30    |176,578   |88 |60.40    |10,032 |10,686,635  |
|('AS2884','玉山金')     |27.60    |202,590   |88 |27.65    |25,345 |5,595,185   |
|('AS2885','元大金')     |24.60    |72,828    |87 |24.55    |7,225  |1,793,493   |
|('AS2886','兆豐金')     |34.00    |177,684   |88 |34.05    |10,255 |6,062,941   |
|('AS2887','台新金')     |18.45    |265,805   |88 |18.40    |38,899 |4,905,035   |
|('AS2891','中信金')     |24.65    |78,885    |87 |24.65    |11,343 |1,946,320   |
|('AS2892','第一金')     |23.60    |122,868   |86 |23.65    |12,894 |2,899,602   |
|('AS2912','統一超')     |283.00   |32,282    |80 |280.00   |1,005  |9,075,322   |
|('AS3008','大立光')     |2,035.00 |14,175    |88 |2,030.00 |2,330  |28,915,460  |
|('AS3034','聯詠')       |464.50   |110,257   |88 |464.00   |4,533  |51,437,529  |
|('AS3045','台灣大')     |98.50    |13,930    |62 |98.50    |1,189  |1,373,117   |
|('AS3711','日月光投控') |102.00   |54,517    |87 |102.00   |7,048  |5,594,912   |
|('AS4904','遠傳')       |62.70    |12,475    |61 |63.20    |634    |783,705     |
|('AS4938','和碩')       |67.50    |22,731    |70 |67.50    |3,246  |1,537,285   |
|('AS5871','中租KY')     |244.00   |42,628    |84 |244.00   |2,526  |10,449,199  |
|('AS5876','上海商銀')   |46.00    |12,481    |61 |45.75    |2,381  |574,252     |
|('AS5880','合庫金')     |23.70    |211,908   |88 |23.70    |18,786 |5,028,741   |
|('AS6415','矽力KY')     |4,420.00 |3,162     |74 |4,445.00 |86     |14,075,230  |
|('AS6505','台塑化')     |97.50    |5,206     |55 |97.00    |4,086  |507,309     |
|('AS8046','南電')       |587.00   |31,460    |87 |585.00   |1,122  |18,372,832  |
|('AS8454','富邦媒')     |1,625.00 |11,011    |86 |1,620.00 |663    |17,844,255  |
|('AS9910','豐泰')       |207.00   |9,518     |53 |204.50   |785    |1,967,285   |

    
爬蟲練習
====================================
type:alert

- [Ptt Tech_Job 版](https://www.ptt.cc/bbs/Tech_Job/index.html)
- 試著爬出所有**標題**
- 爬出的第三個標題是？


網頁爬蟲 再想想？
====================================
incremental:true

- 其實... 很多資料有其他存取方式，像API
    - https://www.dcard.tw/_api/forums/cgu/posts
    - https://www.dcard.tw/_api/posts/225917717
    - https://www.dcard.tw/_api/posts/225917717/comments
- 隱私問題 （OkCupid事件）
    - [70,000 OkCupid Users Just Had Their Data Published](https://motherboard.vice.com/en_us/article/70000-okcupid-users-just-had-their-data-published)

進階爬蟲
====================================
- CSS Selector 語法介紹 [參考資料](https://www.w3schools.com/cssref/css_selectors.asp)
    - **.**xxx：select elements with class="xxx"
    - **#**xxx：select elements with id="xxx"
    - **[**yyy**]**：select elements with attribute yyy
    - **[**yyy=zzz**]**：select elements with attribute yyy="zzz"
    
- 瀑布式網頁爬蟲
    - 觀察Google Chrome 開發者工具，在Network內找到api呼叫方式
    - 搭配使用RSelenium 模擬瀏覽狀態 [DCard實作R Code](https://github.com/CGUIM-BigDataAnalysis/BigDataCGUIM/blob/master/105/RSelenium_rvest.md)


其他爬蟲相關參考資源
====================================
- [網路爬蟲實作 - 用 r 語言打造自己的爬蟲程式](https://www.slideshare.net/secret/mdfHLPgvIW1kPR)
- [rvest GitHub](https://github.com/hadley/rvest)
- R Bloggers 有很多[爬蟲範例](http://www.r-bloggers.com/?s=Web+Scraping)（英文）
- [Ptt爬蟲實作](http://bryannotes.blogspot.tw/2014/08/r-ptt-wantedsocial-network-analysis.html)
- [大數學堂 網頁爬蟲課程](http://www.largitdata.com/course_list/1)


從Facebook匯入
====================================
type:section
- Graph API in R
- Rfacebook package

Graph API in R
====================================
type:sub-section

- 在2018年的風波後，Graph API若要用在爬取公開粉專，須經過FB審核
- [Graph API](https://developers.facebook.com/docs/graph-api?locale=zh_TW)
    - 根據篩選條件，回傳JSON格式的資料
- [Graph API Explorer](https://developers.facebook.com/tools/explorer/)
    - 測試資料撈取方法和結果
- 必須要取得自己的**access token** (存取權杖)
    - 可在[Graph API Explorer](https://developers.facebook.com/tools/explorer/)視窗右上角的**Get Token**按鈕取得
    - [官方文件](https://developers.facebook.com/docs/facebook-login/access-tokens/?locale=zh_TW)


Rfacebook package
====================================
type:sub-section
在2018年的風波後，Graph API若要用在爬取公開粉專，須經過FB審核，因此本課程目前無法示範粉絲專頁爬取

使用 Rfacebook 取得 `tsaiingwen` 粉絲頁的資料

```r
library(Rfacebook) #初次使用須先安裝
token<-"your token" #將token複製到此處
getPage("tsaiingwen", token,n = 5)
```
若經過審核，可得下列結果

```
4 posts       from_id           from_name
1 46251501064 蔡英文 Tsai Ing-wen
2 46251501064 蔡英文 Tsai Ing-wen
3 46251501064 蔡英文 Tsai Ing-wen
4 46251501064 蔡英文 Tsai Ing-wen
```

從Twitter匯入
====================================
type:section
- Twitter API
- rtweet package

Twitter API
====================================
- https://developer.twitter.com/en/apps
- 需有Twitter帳號並通過開發者審核

rtweet package
====================================

```r
## install rtweet from CRAN
install.packages("rtweet")
## load rtweet package
library(rtweet)
```

rtweet package - token 設定
====================================































































































































```
Error in library(rtweet) : there is no package called 'rtweet'
```
