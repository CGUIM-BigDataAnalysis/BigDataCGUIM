Pipelines For Data Analysis In R, part 1
========================================================
author: 曾意儒 Yi-Ju Tseng
autosize: true
font-family: 'Microsoft JhengHei'
navigation: slide

資料分析步驟
========================================================
- **資料匯入** 
- **資料清洗處理**並轉換為Tidy data
- **資料分析**
- **資料呈現與視覺化**

在分析之前
========================================================
- RStudio怎麼用？[對應書本章節](https://yijutseng.github.io/DataScienceRBook/install.html#rstudio)
- R基本語法: [對應書本章節](https://yijutseng.github.io/DataScienceRBook/intro.html)
- R資料結構: [對應書本章節](https://yijutseng.github.io/DataScienceRBook/RDataStructure.html)

R vs. RStudio
========================================================

R: 程式核心 (引擎)
![plot of chunk unnamed-chunk-1](https://www.teslarati.com/wp-content/uploads/2018/07/model-3-drivetrain-1.jpg)

[圖片來源](https://www.teslarati.com/tesla-patent-more-efficient-electric-motors/)

R vs. RStudio
========================================================

RStudio: 操作介面 IDE (儀錶板)

![plot of chunk unnamed-chunk-2](https://i.pinimg.com/originals/b9/73/15/b97315751352729f99b02c87f454012b.jpg)


[圖片來源](https://www.theverge.com/2015/3/19/8260295/tesla-user-interface-redesign-concept)

RStudio Interface
========================================================
left: 30%
共有四個區塊，分別為：

- 程式碼編輯區 Source editor
- 執行視窗 Console
- 環境/物件
- 檔案/圖表/說明文件

***

![plot of chunk unnamed-chunk-3](figures/RStudio.png)

RStudio 使用步驟
========================================================
- New Project (如果原本沒有的話，就像把相關資料整理在**資料夾**的功能)
- New R Script (如果原本沒有的話，就像開個WORD記錄所有程式碼)
- 在左上方**程式碼編輯區 Source editor**撰寫程式碼
- 將需要執行的程式碼反白，點選**Run**或是按**Ctrl+Enter**，執行程式碼
- 將游標移至需要執行的程式碼，點選**Run**或是按**Ctrl+Enter**，也可執行該行程式碼
- 程式碼會在左下方Console視窗執行，顯示結果
- 如果有畫圖，會出現在右下方視窗
- 可在右上方視窗檢查所有變數

Console視窗
========================================================
- 可直譯的語言
- 可在執行視窗(Console)直接打程式碼
- `>` : 輸入指令
- `+` : 表示前面的程式碼還沒打完
    - 鍵入完整的程式碼
    - **Esc**跳出

RStudio hands-on
====================================
type:alert
incremental:true

- 打開RStudio
- 左上角**File**->**New Project** (如果原本沒有的話，Project名稱就會是資料夾名稱)
- 左上角**File**->**New File**->**R Script** (如果原本沒有的話)
- 在Console輸入1+，按Enter
- 試著跳出打不完的程式碼，變回輸入模式`>`

R and R Packages
========================================================

R: 程式核心 (iPhone)
![plot of chunk unnamed-chunk-4](https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-xr-white-select-201809?wid=940&hei=1112&fmt=png-alpha&qlt=80&.v=1551226036668)

R and R Packages
========================================================

R Packages: 附加程式 (APP)

![plot of chunk unnamed-chunk-5](https://3c.yipee.cc/wp-content/uploads/2019/06/a7ffbaa3df50d7cafe6801a8a8d7a3bf-620x320.jpg)

[圖片來源](https://www.apple.com/)


R = Base + Other Packages
========================================================
- 安裝套件Package的方法如下：

```r
install.packages("套件名稱")
```

- 套件名稱需要加上雙引號

```r
install.packages("ggplot2")
```

- 載入**已安裝**的套件：

```r
library(ggplot2)
```

- **不用**在套件名稱前後加雙引號

Install packages hands-on
====================================
type:alert
incremental:true

- 在剛剛新增的**R Script**中，輸入`install.packages("tidyverse")`
- 使用上方選單**Tools**->**Install packages**->在**Package**欄位輸入`SportsAnalytics`，點選**Install**

Functions - Basic
========================================================
- 內建Functions函數
- 安裝Packages套件後各套件也會提供多種函數
- 使用方式: `函數名稱(參數1,參數2,....)`
- `?函數名稱` 查詢所需參數與說明
以計算平均數為例，可使用`mean()`函數:

```r
mean(c(1,2,3,4,5,6)) ##計算1~6的平均數
```

```
[1] 3.5
```

Functions - Arguments 順序
========================================================
- 函數的參數設定有順序性
- 不想照順序-->指定參數名稱

如序列產生函數`seq()`，參數順序為`from, to, by`，代表序列起點、序列終點，以及相隔單位。

```r
seq(from=1,to=9,by=2)#1~9，每隔2產生一數字
```

```
[1] 1 3 5 7 9
```

Functions - Arguments 順序
========================================================

```r
seq(from=1,to=9,by=2)#1~9，每隔2產生一數字
```

```
[1] 1 3 5 7 9
```

```r
seq(1,9,2)#按照順序輸入參數，可省去參數名稱
```

```
[1] 1 3 5 7 9
```

```r
seq(by=2,to=9,from=1)#不照順序輸入，需要參數名稱
```

```
[1] 1 3 5 7 9
```

Variable [<-]
========================================================
- 使用 `<-` 設定變數
- **變數名稱** `<-` **變數內容(值)**
- **變數名稱**可依箭頭方向放置於左側 `<-` 或右側 `->` 
- 但為方便閱讀，**變數名稱**多放置於左側


```r
a<-1 
a
```

```
[1] 1
```

```r
2->b
b
```

```
[1] 2
```

Variable 命名規則
========================================================
- 不可使用保留字
    - break, else, FALSE, for, function, if, Inf, NA, NaN, next, repeat, return, TRUE, while等
- 開頭只能是英文字，或 `.`
- 大小寫敏感

保留字檢查
====================================
type:alert
incremental:true

- 在Source code視窗輸入`TRUE`，觀察顏色
- 在Source code視窗輸入`True`，觀察顏色

資料型態
========================================================
- **數值 (numeric)**
- **字串 (character)**
- **布林變數 (logic)**
- **日期 (Date)**

數值 (numeric)
========================================================
數值包括
- 整數（沒有小數點）
- 浮點數（有小數點）


```r
num1<-100 
num2<-1000.001
```


字串 (character)
========================================================
- 用雙引號`"`框起 : 字串格式
- 數字前後加上雙引號 : 字串格式
    - 無法進行數值的加減乘除

```r
char1<-"abcTest" 
char2<-"100"
char3<-"200"
#char2+char3 
#會輸出Error message: non-numeric argument to binary operator
paste0(char2,char3)
```

```
[1] "100200"
```


```r
paste0(char2,char3)
```

```
[1] "100200"
```
布林變數 (logic)
========================================================
- 用於邏輯判斷
- 大寫**TRUE**或**T**代表**真**
- 大寫**FALSE**或**F**代表假。

```r
boolT<-TRUE
boolT1<-T
boolF<-FALSE
boolF1<-F
```

日期 (Date)
========================================================
- 表示日期
- `Sys.Date()`可得系統日期


```r
dateBook<-Sys.Date()
dateBook
```

```
[1] "2021-11-26"
```

日期 (Date) - lubridate
========================================================
- `lubridate` package : 日期與字串的相關轉換操作，含在`tidyverse`套件中
- `ymd()`函數 : 將`年/月/日`格式的文字轉換為日期物件
    - y表年year
    - m表月month
    - d表日day

```r
library(lubridate)
ymd('2012/3/3')
```

```
[1] "2012-03-03"
```


日期 (Date) - lubridate
========================================================
- `mdy()`函數 : 將`月/日/年`格式的文字轉換為日期物件
    - y表年year
    - m表月month
    - d表日day
- 以此類推


```r
mdy('3/3/2012')
```

```
[1] "2012-03-03"
```

- 其他使用方法：[Cheatsheet](https://rawgit.com/rstudio/cheatsheets/main/lubridate.pdf)

基本運算子: 數學運算
========================================================
數學運算與其他程式語言相同

- 加 `+`
- 減 `-`

```r
num1<-1
num2<-100
num1+num2
```

```
[1] 101
```

```r
num1-num2
```

```
[1] -99
```
***
- 乘 `*`
- 除 `/`
- 餘數 `%%`
- 次方 `^`

```r
num1*num2
```

```
[1] 100
```

```r
num1/num2
```

```
[1] 0.01
```


基本運算子: 邏輯運算
========================================================
常用之邏輯判斷也可在R中直接使用
- 大於 `>`
- 小於 `<`

```r
num1<-1
num2<-100
num1>num2
```

```
[1] FALSE
```

```r
num1<num2
```

```
[1] TRUE
```

***

- 等於 `==`，**雙等號**
- 大於等於 `>=`
- 小於等於 `<=`

```r
num1==num2
```

```
[1] FALSE
```

```r
1==1
```

```
[1] TRUE
```

基本運算子: 邏輯運算
========================================================
文字字串也可比較大小

```r
char1<-"abcTest" 
char2<-"defTest"
char1>char2
```

```
[1] FALSE
```

基本運算子: 邏輯判斷
========================================================
在R中使用**單符號**即可表示且`&`和或`|`
- 且 `&`


```r
TRUE & TRUE
```

```
[1] TRUE
```

```r
TRUE & FALSE
```

```
[1] FALSE
```

***
在R中使用**單符號**即可表示且`&`和或`|`
- 或 `|`

```r
TRUE | TRUE
```

```
[1] TRUE
```

```r
TRUE | FALSE
```

```
[1] TRUE
```

基本運算子: 反向布林變數 !
========================================================


```r
!TRUE
```

```
[1] FALSE
```

```r
!FALSE
```

```
[1] TRUE
```


解讀錯誤訊息
========================================================

- Message：有可能的錯誤通知，程式會繼續執行
- Warning：有錯誤，但是不會影響太多，程式會繼續執行
- Error：有錯，而且無法繼續執行程式
- Condition：可能會發生的情況

```r
log(-1)
```

```
[1] NaN
```

```r
mena(NA)
```

```
Error in mena(NA): could not find function "mena"
```

解讀錯誤訊息 範例
========================================================
```
# Error: could not find function "fetch_NBAPlayerStatistics"
# 找不到"fetch_NBAPlayerStatistics" function
```
可能原因：沒安裝或沒讀入SportsAnalytics package


```
# Error in library(knitr): there is no package called 'knitr'
# 找不到"knitr" package
```
可能原因：沒安裝knitr package

可能是最常見的錯誤訊息
====================================
type:alert
incremental:true

- 在Source code視窗輸入`fetch_NBAPlayerStatistics("20-21")`並執行
- 試著安裝`SportsAnalytics` package
- 試著載入`SportsAnalytics` package
- 再次執行`fetch_NBAPlayerStatistics("20-21")`
- 在Source code視窗輸入`library(knitr)`並執行

Help
========================================================
- R語言與套件均有完整的文件與範例可以參考
- 輸入`?函數名稱`或`?套件名稱`

```r
?ggplot2
?ymd
```

- Google
- [Stack Overflow](http://stackoverflow.com/)也有許多問答


R 常見的資料結構
========================================================
- 向量 Vector
- 因子 Factor
- 列表 List
- 矩陣 Matrix
- 資料框 data.frame
- 屬性查詢函數 

R 常見的資料結構
========================================================
![plot of chunk unnamed-chunk-15](figures/DataStructure.png)

向量 Vector
========================================================
type:sub-section
- 一維資料
- 所有元素之**資料型態必須相同**
- `c()`函數 定義向量

```r
vec<-c('a','b','c','d','e')
```

- a~e: **元素(element)**
- 順序固定
    - `a`: 第**1**個元素
    - `b`: 第**2**個元素

向量 Vector 取值
========================================================  

若要將`vec`向量的第**4**個元素取出，可使用**向量名稱[元素位置]**: 

```r
vec[4] ## 第4個元素
```

```
[1] "d"
```
也可同時取出多個元素

```r
vec[c(2,3)] ## 第2與第3個元素
```

```
[1] "b" "c"
```


向量 Vector 元素設定
========================================================   

```r
vec[3]
```

```
[1] "c"
```

```r
vec[3]<-'z' ##第三個元素值設定為“z”
vec[3] 
```

```
[1] "z"
```

產生向量函數
========================================================   

若要產生連續向量，如1~20，可使用`:`來串連首字與最後一字

```r
1:20 ## c(1,2,...,19,20)
```

```
 [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
```

向量取值練習
====================================
type:alert
incremental:true

- 新增一向量a，包含數字1到10
- 新增一向量b，包含數字1到20中的所有偶數
- 取出a向量的第4個元素
- 取出b向量的第5,6,7個元素


向量運算
========================================================  
向量也可直接做加減乘除運算，如

```r
numvec<-1:10 ## c(1,2,3,4,5,6,7,8,9,10)
numvec+3 ## 所有元素+3
```

```
 [1]  4  5  6  7  8  9 10 11 12 13
```

```r
numvec*2 ## 所有元素*2
```

```
 [1]  2  4  6  8 10 12 14 16 18 20
```

向量運算
========================================================  
向量和向量也可做運算，如

```r
numvec1<-1:3 ## c(1,2,3)
numvec2<-4:6 ## c(4,5,6)
numvec1+numvec2
```

```
[1] 5 7 9
```

```r
numvec1*numvec2
```

```
[1]  4 10 18
```


因子 factor
========================================================
type:sub-section
- 由向量轉換而成
- 表示**類別**數據
- 使用方法為`factor(資料向量,levels=類別次序)`

```r
factor(c("大學生","碩士班學生","博士班學生"),
       levels = c("大學生","碩士班學生","博士班學生"))
```

```
[1] \u5927\u5b78\u751f             \u78a9\u58eb\u73ed\u5b78\u751f
[3] \u535a\u58eb\u73ed\u5b78\u751f
3 Levels: \u5927\u5b78\u751f ... \u535a\u58eb\u73ed\u5b78\u751f
```
因子變量一但決定其類別的種類與數目時，通常不會再作更動，也就是任何新增的元素都要是大學生、碩士班學生與博士班學生其中一種。

列表 list
======================================================== 
type:sub-section
- **向量**和**因子**都只能儲存一種元素
- 保有彈性: **列表list**
- 元素可分屬不同資料類別，
- **數值**、**文字**、**向量**、**因子**
- `list()`函數

列表 list
======================================================== 

```r
listSample<-list(Students=c("Tom","Kobe","Emma"),
                 Year=2017,
                 Score=c(60,50,80,40),
                 School="CGU")
listSample
```

```
$Students
[1] "Tom"  "Kobe" "Emma"

$Year
[1] 2017

$Score
[1] 60 50 80 40

$School
[1] "CGU"
```

列表資料擷取
======================================================== 
列表可用`$`符號做資料擷取

```r
listSample$Students ##取得listSample列表中的Students變量
```

```
[1] "Tom"  "Kobe" "Emma"
```

列表資料擷取
======================================================== 
- 若要取得**值**，要使用雙中括號`[[]]`

```r
listSample[[1]] ##第一個變量的值
```

```
[1] "Tom"  "Kobe" "Emma"
```
- 只使用單中括號`[]`，回傳的資料型態會是**列表list**

```r
listSample[1] ##第一個變量（列表型態）
```

```
$Students
[1] "Tom"  "Kobe" "Emma"
```

列表list取值練習
====================================
type:alert
incremental:true

- 依投影片，新增listSample列表
- 取出分數資料 (值)
    - 方法一
    - 方法二
- 取出分數資料 （列表）


列表資料編輯設定
======================================================== 
列表資料和向量資料一樣，可重新編輯設定

```r
listSample[[1]] 
```

```
[1] "Tom"  "Kobe" "Emma"
```

```r
listSample[[1]]<-c("小明","大雄","胖虎","小新","大白") ##將Students變量重新設定
listSample[[1]] 
```

```
[1] "\u5c0f\u660e" "\u5927\u96c4" "\u80d6\u864e" "\u5c0f\u65b0" "\u5927\u767d"
```

列表資料編輯設定
======================================================== 
列表資料也能用`$`符號與`<-`變數設定符號新增

```r
listSample$Gender<-c("M","F","M","F","M") ##新增Gender變量，並設定向量值
```

資料框 data.frame
======================================================== 
type:sub-section
- 二維資料格式 (Excel試算表)
- 由欄位（Column）和列（Row）組成
- 使用`data.frame()`來創建新的資料框

```r
StuDF <- data.frame(StuID=c(1,2,3), ##欄位名稱=欄位值
                  name=c("小明","大雄","胖虎"),
                  score=c(80,60,90))
StuDF 
```

```
  StuID         name score
1     1 \u5c0f\u660e    80
2     2 \u5927\u96c4    60
3     3 \u80d6\u864e    90
```


資料框 data.frame
======================================================== 
- 每列：觀察值 / 每欄：變數
- 欄位需有名稱
    - StuID, name, score
    - 若沒有設定，自動指派V1~Vn
- 欄位的資料型態相同
- 每一列有列名
    - 依序指派1~n作為列名


資料框 data.frame
======================================================== 
- 檢查欄位名稱 `colnames()`
- 檢查欄位列名，`rownames()`

```r
colnames(StuDF) #檢查欄位名稱
```

```
[1] "StuID" "name"  "score"
```

```r
rownames(StuDF) #檢查列名
```

```
[1] "1" "2" "3"
```

```r
nrow(StuDF) #幾列
```

```
[1] 3
```

```r
ncol(StuDF) #幾欄
```

```
[1] 3
```

資料框 data.frame
======================================================== 
如需檢查個欄位之資料型別，可使用`str()`函數

**解釋iris資料框**???


```r
str(iris) 
```

```
'data.frame':	150 obs. of  5 variables:
 $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
 $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
 $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
 $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
 $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
```

資料框 data.frame 搭配skimr套件
======================================================== 

```r
install.packages("skimr")
```

```r
library(skimr)
skim(iris) 
```


Table: Data summary

|                         |     |
|:------------------------|:----|
|Name                     |iris |
|Number of rows           |150  |
|Number of columns        |5    |
|_______________________  |     |
|Column type frequency:   |     |
|factor                   |1    |
|numeric                  |4    |
|________________________ |     |
|Group variables          |None |


**Variable type: factor**

|skim_variable | n_missing| complete_rate|ordered | n_unique|top_counts                |
|:-------------|---------:|-------------:|:-------|--------:|:-------------------------|
|Species       |         0|             1|FALSE   |        3|set: 50, ver: 50, vir: 50 |


**Variable type: numeric**

|skim_variable | n_missing| complete_rate| mean|   sd|  p0| p25|  p50| p75| p100|hist  |
|:-------------|---------:|-------------:|----:|----:|---:|---:|----:|---:|----:|:-----|
|Sepal.Length  |         0|             1| 5.84| 0.83| 4.3| 5.1| 5.80| 6.4|  7.9|▆▇▇▅▂ |
|Sepal.Width   |         0|             1| 3.06| 0.44| 2.0| 2.8| 3.00| 3.3|  4.4|▁▆▇▂▁ |
|Petal.Length  |         0|             1| 3.76| 1.77| 1.0| 1.6| 4.35| 5.1|  6.9|▇▁▆▇▂ |
|Petal.Width   |         0|             1| 1.20| 0.76| 0.1| 0.3| 1.30| 1.8|  2.5|▇▁▇▅▃ |
資料框 data.frame 搭配skimr套件
======================================================== 

Table: Data summary

|                         |     |
|:------------------------|:----|
|Name                     |iris |
|Number of rows           |150  |
|Number of columns        |5    |
|_______________________  |     |
|Column type frequency:   |     |
|factor                   |1    |
|numeric                  |4    |
|________________________ |     |
|Group variables          |None |


**Variable type: factor**

|skim_variable | n_missing| complete_rate|ordered | n_unique|top_counts                |
|:-------------|---------:|-------------:|:-------|--------:|:-------------------------|
|Species       |         0|             1|FALSE   |        3|set: 50, ver: 50, vir: 50 |


**Variable type: numeric**

|skim_variable | n_missing| complete_rate| mean|   sd|  p0| p25|  p50| p75| p100|hist  |
|:-------------|---------:|-------------:|----:|----:|---:|---:|----:|---:|----:|:-----|
|Sepal.Length  |         0|             1| 5.84| 0.83| 4.3| 5.1| 5.80| 6.4|  7.9|▆▇▇▅▂ |
|Sepal.Width   |         0|             1| 3.06| 0.44| 2.0| 2.8| 3.00| 3.3|  4.4|▁▆▇▂▁ |
|Petal.Length  |         0|             1| 3.76| 1.77| 1.0| 1.6| 4.35| 5.1|  6.9|▇▁▆▇▂ |
|Petal.Width   |         0|             1| 1.20| 0.76| 0.1| 0.3| 1.30| 1.8|  2.5|▇▁▇▅▃ |

資料框資料擷取
======================================================== 
資料框可用`$`符號做**欄位**資料擷取

```r
iris$Species ##取得iris資料框中的Species欄位
```

```
  [1] setosa     setosa     setosa     setosa     setosa     setosa    
  [7] setosa     setosa     setosa     setosa     setosa     setosa    
 [13] setosa     setosa     setosa     setosa     setosa     setosa    
 [19] setosa     setosa     setosa     setosa     setosa     setosa    
 [25] setosa     setosa     setosa     setosa     setosa     setosa    
 [31] setosa     setosa     setosa     setosa     setosa     setosa    
 [37] setosa     setosa     setosa     setosa     setosa     setosa    
 [43] setosa     setosa     setosa     setosa     setosa     setosa    
 [49] setosa     setosa     versicolor versicolor versicolor versicolor
 [55] versicolor versicolor versicolor versicolor versicolor versicolor
 [61] versicolor versicolor versicolor versicolor versicolor versicolor
 [67] versicolor versicolor versicolor versicolor versicolor versicolor
 [73] versicolor versicolor versicolor versicolor versicolor versicolor
 [79] versicolor versicolor versicolor versicolor versicolor versicolor
 [85] versicolor versicolor versicolor versicolor versicolor versicolor
 [91] versicolor versicolor versicolor versicolor versicolor versicolor
 [97] versicolor versicolor versicolor versicolor virginica  virginica 
[103] virginica  virginica  virginica  virginica  virginica  virginica 
[109] virginica  virginica  virginica  virginica  virginica  virginica 
[115] virginica  virginica  virginica  virginica  virginica  virginica 
[121] virginica  virginica  virginica  virginica  virginica  virginica 
[127] virginica  virginica  virginica  virginica  virginica  virginica 
[133] virginica  virginica  virginica  virginica  virginica  virginica 
[139] virginica  virginica  virginica  virginica  virginica  virginica 
[145] virginica  virginica  virginica  virginica  virginica  virginica 
Levels: setosa versicolor virginica
```

資料框資料編輯
======================================================== 
資料框可用`$`符號做**欄位**資料擷取後，當成向量，並使用**[]**做資料編輯。

```r
iris$Species[2]<-"versicolor"
head(iris$Species)
```

```
[1] setosa     versicolor setosa     setosa     setosa     setosa    
Levels: setosa versicolor virginica
```

資料框資料編輯練習
====================================
type:alert
incremental:true

- iris$Time<-1 會發生什麼事情?



