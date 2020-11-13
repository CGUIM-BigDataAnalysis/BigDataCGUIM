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
 [1] "基隆" "汐止" "萬里" "新店" "土城" "板橋" "新莊" "菜寮" "林口" "淡水"
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

```
List of 2
 $ success: logi TRUE
 $ result :List of 8
  ..$ include_total : logi TRUE
  ..$ resource_id   : chr "a1b4714b-3b75-4ff8-a8f2-cc377e4eaa0f"
  ..$ fields        :'data.frame':	15 obs. of  2 variables:
  .. ..$ type: chr [1:15] "int" "text" "text" "text" ...
  .. ..$ id  : chr [1:15] "_id" "sno" "sna" "tot" ...
  ..$ records_format: chr "objects"
  ..$ records       :'data.frame':	100 obs. of  15 variables:
  .. ..$ _id    : int [1:100] 1 2 3 4 5 6 7 8 9 10 ...
  .. ..$ sno    : chr [1:100] "2001" "2002" "2003" "2004" ...
  .. ..$ sna    : chr [1:100] "中央大學圖書館" "中壢高中" "中正公園(中美路)" "中壢火車站(前站)" ...
  .. ..$ tot    : chr [1:100] "60" "52" "54" "114" ...
  .. ..$ sbi    : chr [1:100] "37" "33" "24" "70" ...
  .. ..$ sarea  : chr [1:100] "中壢區" "中壢區" "中壢區" "中壢區" ...
  .. ..$ mday   : chr [1:100] "20201113171816" "20201113171842" "20201113171827" "20201113171825" ...
  .. ..$ lat    : chr [1:100] "24.968128" "24.960815" "24.959113" "24.953874" ...
  .. ..$ lng    : chr [1:100] "121.194666" "121.212038" "121.224805" "121.2256" ...
  .. ..$ ar     : chr [1:100] "中大路300號(中央大學校內圖書館前)" "中央西路二段215號對面人行道" "中美路101-113號對面人行道" "中和路139號對面圓環" ...
  .. ..$ sareaen: chr [1:100] "Zhongli Dist." "Zhongli Dist." "Zhongli Dist." "Zhongli Dist." ...
  .. ..$ snaen  : chr [1:100] "National Central University Library" "Jhungli Senior High School" "Zhongzheng Park (Zhongmei Rd.)" "TRA Zhongli Station (Front)" ...
  .. ..$ aren   : chr [1:100] "No.300, Zhongda Rd." "No.215, Sec. 2, Zhongyang W. Rd. (opposite)" "No.101 to No.113, Zhongmei Rd. (opposite)" "No.139, Zhonghe Rd. (opposite)" ...
  .. ..$ bemp   : chr [1:100] "22" "19" "29" "44" ...
  .. ..$ act    : chr [1:100] "1" "1" "1" "1" ...
  ..$ offset        : int 0
  ..$ total         : int 363
  ..$ limit         : int 100
```

JSON檔案解析
====================================
- 使用`$`符號截取元素與子元素

```r
head(APIData$result$records)
```

| _id|sno  |sna              |tot |sbi |sarea  |mday           |lat       |lng        |
|---:|:----|:----------------|:---|:---|:------|:--------------|:---------|:----------|
|   1|2001 |中央大學圖書館   |60  |37  |中壢區 |20201113171816 |24.968128 |121.194666 |
|   2|2002 |中壢高中         |52  |33  |中壢區 |20201113171842 |24.960815 |121.212038 |
|   3|2003 |中正公園(中美路) |54  |24  |中壢區 |20201113171827 |24.959113 |121.224805 |
|   4|2004 |中壢火車站(前站) |114 |70  |中壢區 |20201113171825 |24.953874 |121.2256   |
|   5|2005 |中原大學         |82  |21  |中壢區 |20201113171826 |24.957943 |121.240201 |
|   6|2006 |銀河廣場         |58  |27  |中壢區 |20201113171837 |24.961716 |121.224241 |
|   7|2007 |中壢區公所       |40  |14  |中壢區 |20201113171827 |24.965697 |121.224696 |
|   8|2008 |光明公園         |96  |60  |中壢區 |20201113171839 |24.962812 |121.217385 |

JSON檔案解析
====================================
分析各項**地區**車站數

```r
table(APIData$result$records$sarea)
```

|Var1   | Freq|
|:------|----:|
|八德區 |    5|
|大園區 |    2|
|大溪區 |    2|
|中壢區 |   35|
|平鎮區 |    7|
|桃園區 |   32|
|龜山區 |   10|
|蘆竹區 |    7|
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
[1] "金馬57｜最好的時光：點亮世界的電影夢"      
[2] "強光下的暗憂──背負情緒隱傷的高學業成就青年"
[3] "港人移台進行式──移民浪潮下的台港新地景"    
[4] "健保的崩時代"                              
[5] "家園變鐵道──南鐵東移的公權與私權戰役"      
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
[1] "\r\n\r\n<!--\r\n\tGenLink2stk('AS1101','台泥');\r\n//-->\r\n"
[2] "\r\n\r\n<!--\r\n\tGenLink2stk('AS1102','亞泥');\r\n//-->\r\n"
[3] "\r\n\r\n<!--\r\n\tGenLink2stk('AS1216','統一');\r\n//-->\r\n"
[4] "\r\n\r\n<!--\r\n\tGenLink2stk('AS1301','台塑');\r\n//-->\r\n"
[5] "\r\n\r\n<!--\r\n\tGenLink2stk('AS1303','南亞');\r\n//-->\r\n"
[6] "\r\n\r\n<!--\r\n\tGenLink2stk('AS1326','台化');\r\n//-->\r\n"
```

```r
head(NanoStockPrice)
```

```
[1] "42.45"     "29,451"    "60"        "42.30"     "11,868"    "1,248,911"
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

|name                    |X1       |X2      |X3 |X4       |X5     |X6         |
|:-----------------------|:--------|:-------|:--|:--------|:------|:----------|
|('AS1101','台泥')       |42.45    |29,451  |60 |42.30    |11,868 |1,248,911  |
|('AS1102','亞泥')       |43.60    |5,932   |22 |43.55    |3,343  |256,638    |
|('AS1216','統一')       |68.20    |34,573  |80 |68.20    |11,481 |2,344,874  |
|('AS1301','台塑')       |87.00    |18,749  |65 |87.00    |11,428 |1,629,994  |
|('AS1303','南亞')       |63.90    |4,677   |29 |64.10    |6,811  |299,760    |
|('AS1326','台化')       |76.90    |9,903   |44 |76.90    |6,823  |759,500    |
|('AS1402','遠東新')     |27.55    |8,465   |33 |27.50    |2,263  |231,277    |
|('AS2002','中鋼')       |21.50    |39,073  |72 |21.50    |28,552 |840,156    |
|('AS2105','正新')       |40.00    |11,227  |33 |39.90    |4,121  |455,265    |
|('AS2207','和泰車')     |665.00   |1,001   |28 |664.00   |317    |664,230    |
|('AS2301','光寶科')     |47.30    |4,628   |30 |47.05    |7,021  |218,987    |
|('AS2303','聯電')       |31.20    |31,418  |73 |31.20    |31,652 |978,364    |
|('AS2308','台達電')     |200.00   |9,714   |63 |200.00   |5,335  |1,940,989  |
|('AS2317','鴻海')       |81.50    |95,844  |86 |81.40    |58,345 |7,813,860  |
|('AS2327','國巨')       |398.00   |18,458  |76 |397.00   |8,029  |7,349,863  |
|('AS2330','台積電')     |460.50   |208,443 |88 |462.00   |64,438 |95,799,486 |
|('AS2357','華碩')       |247.50   |6,644   |59 |247.00   |3,063  |1,640,463  |
|('AS2379','瑞昱')       |362.00   |9,396   |62 |363.00   |3,045  |3,376,136  |
|('AS2382','廣達')       |71.80    |7,159   |41 |71.90    |3,363  |512,143    |
|('AS2395','研華')       |294.50   |294     |15 |294.50   |2,125  |86,666     |
|('AS2408','南亞科')     |62.00    |7,164   |34 |61.90    |3,167  |443,240    |
|('AS2412','中華電')     |110.00   |10,030  |54 |110.00   |6,826  |1,099,711  |
|('AS2454','聯發科')     |675.00   |29,730  |86 |679.00   |4,318  |19,977,552 |
|('AS2474','可成')       |191.50   |7,961   |46 |192.00   |1,860  |1,518,117  |
|('AS2633','台灣高鐵')   |31.35    |3,986   |28 |31.40    |2,992  |125,271    |
|('AS2801','彰銀')       |17.85    |6,981   |33 |17.90    |13,740 |124,465    |
|('AS2880','華南金')     |18.30    |37,000  |63 |18.30    |22,983 |675,701    |
|('AS2881','富邦金')     |45.10    |18,654  |47 |45.20    |10,525 |842,604    |
|('AS2882','國泰金')     |40.50    |12,286  |54 |40.45    |12,168 |497,911    |
|('AS2883','開發金')     |8.65     |9,897   |45 |8.64     |12,712 |85,625     |
|('AS2884','玉山金')     |26.10    |72,785  |84 |26.10    |46,633 |1,896,328  |
|('AS2885','元大金')     |18.55    |37,365  |71 |18.55    |15,642 |694,888    |
|('AS2886','兆豐金')     |29.35    |26,093  |68 |29.35    |20,033 |762,997    |
|('AS2887','台新金')     |13.20    |25,588  |62 |13.20    |27,905 |337,234    |
|('AS2890','永豐金')     |11.20    |15,626  |41 |11.15    |13,721 |174,851    |
|('AS2891','中信金')     |19.55    |29,974  |64 |19.55    |17,302 |586,010    |
|('AS2892','第一金')     |21.45    |37,130  |73 |21.50    |29,589 |795,075    |
|('AS2912','統一超')     |269.50   |7,676   |60 |270.00   |2,338  |2,072,024  |
|('AS3008','大立光')     |3,380.00 |15,707  |88 |3,370.00 |2,324  |52,457,395 |
|('AS3045','台灣大')     |99.30    |14,168  |43 |99.40    |4,096  |1,409,352  |
|('AS3711','日月光投控') |70.80    |21,422  |69 |70.50    |10,669 |1,513,632  |
|('AS4904','遠傳')       |61.20    |6,609   |34 |61.50    |1,676  |405,508    |
|('AS4938','和碩')       |63.90    |23,800  |68 |64.10    |7,370  |1,519,697  |
|('AS5871','中租KY')     |158.00   |21,138  |77 |158.50   |8,512  |3,338,554  |
|('AS5876','上海商銀')   |40.00    |4,231   |21 |40.10    |1,659  |170,285    |
|('AS5880','合庫金')     |20.15    |26,341  |62 |20.20    |31,724 |530,954    |
|('AS6415','矽力KY')     |2,140.00 |526     |35 |2,085.00 |916    |1,137,705  |
|('AS6505','台塑化')     |91.60    |7,592   |45 |92.00    |3,881  |692,291    |
|('AS6669','緯穎')       |707.00   |10,529  |64 |710.00   |1,276  |7,373,794  |
|('AS9910','豐泰')       |186.50   |4,526   |30 |186.00   |2,918  |843,141    |

    
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

```r
library(rtweet)
create_token(
  app = "teach0309",
  consumer_key = "Wbba6ysyPKGstGAqohmtyWZOE",
  consumer_secret = "GJweDzVvXGrbjz26bHTr3d6dFI7q9gFCH98f3Ct2yk3APPWigc",
  access_token = "216362944-VbXiYOjGtENwSI6eJ9AoDK5OVvoQWlj7yIeXraGt",
  access_secret = "jnfDCvuMdxdmxswUUPPi3gomxIWZq3BTdumykLJb7GW5A")
```

```
<Token>
<oauth_endpoint>
 request:   https://api.twitter.com/oauth/request_token
 authorize: https://api.twitter.com/oauth/authenticate
 access:    https://api.twitter.com/oauth/access_token
<oauth_app> teach0309
  key:    Wbba6ysyPKGstGAqohmtyWZOE
  secret: <hidden>
<credentials> oauth_token, oauth_token_secret
---
```

rtweet package - 搜尋hashtag
====================================

```r
## search for 3000 tweets using the trump hashtag
rt <- search_tweets(
  "#trump", n = 3000, include_rts = FALSE
)
head(rt)
```




























































































































```
processing file: EMBA_PipelinesForDataAnalysisInR2.Rpres

Attaching package: 'rtweet'

The following object is masked from 'package:jsonlite':

    flatten

Requesting token on behalf of user...
Quitting from lines 512-516 (EMBA_PipelinesForDataAnalysisInR2.Rpres) 
錯誤: API user token required. see http://rtweet.info/articles/auth.html for instructions
此外: Warning messages:
1: package 'xml2' was built under R version 4.0.2 
2: package 'rtweet' was built under R version 4.0.3 
停止執行
```
