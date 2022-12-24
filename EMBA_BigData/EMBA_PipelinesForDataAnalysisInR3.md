Pipelines For Data Analysis In R, part 3
========================================================
author: 曾意儒 Yi-Ju Tseng
autosize: true
font-family: 'Microsoft JhengHei'
navigation: slide

資料分析步驟
========================================================
- 資料匯入
- 資料清洗處理並轉換為Tidy data
- **資料分析**
- **資料呈現與視覺化**


資料分析大綱
====================================
type:sub-section 

- 什麼是探索式資料分析
- 量化的分析方式
- dplyr

什麼是探索式資料分析
====================================
type:sub-section 

- 探索式資料分析 (**E**xploratory **D**ata **A**nalysis)
- 在資料量 大/雜/髒 的時候，探索式資料分析非常重要
- 運用**視覺化**、**基本的統計**等工具，反覆的探索**資料特性**，獲取資料所包含的資訊、結構和特點
- 在進行複雜或嚴謹的分析之前，必須要對資料有更多認識，才能訂定**對的資料分析方向**
- 通常**不需要**嚴謹的假設和細節呈現


探索式資料分析
====================================
- 分析各變數間的**關聯性**，看是否有預料之外的有趣發現
- 觀察資料內容是否符合預期，若否，檢查資料**是否有誤**
- 檢查資料是否符合分析前的假設

透過探索性分析來**調整分析的方向**，減少因分析方向錯誤所造成的時間浪費。

探索式資料分析
====================================

- 圖形化Graphical
    - 單變量Univariate
    - 雙變量Bivariate
    - 多變量Multivariate
    
- 量化Quantitative
    - 單變量Univariate
    - 雙變量Bivariate
    - 多變量Multivariate

圖形化的分析
====================================
包括做圖與列表，將會在下章節介紹，本章節著重於量化的分析方式。


量化的分析方式: 單變量
====================================
資料初步統計，量化的分析方式可包含

- 計算集中趨勢
    - 平均值 Mean `mean()`
    - 中位數 Median `median()`
    - 眾數 Mode，R無內建函數，可直接用`table()`找出現次數最多的資料
    
量化的分析方式: 單變量-集中趨勢
====================================

```r
mean(iris$Sepal.Length)
```

```
[1] 5.843333
```

```r
median(iris$Sepal.Length)
```

```
[1] 5.8
```

```r
table(iris$Species)
```

```

    setosa versicolor  virginica 
        50         50         50 
```
    
量化的分析方式: 單變量
====================================
資料初步統計，量化的分析方式可包含

- 計算資料分散程度
    - 最小值 Min `min()`
    - 最大值 Max `max()`
    - 範圍 Range `range()`
    - 四分位差 Quartiles `quantile()`
    - 變異數 Variance `var()`
    - 標準差 Standard deviation `sd()`
    
量化的分析方式: 單變量-分散程度
====================================

```r
min(iris$Sepal.Length)
```

```
[1] 4.3
```

```r
max(iris$Sepal.Length)
```

```
[1] 7.9
```

```r
range(iris$Sepal.Length)
```

```
[1] 4.3 7.9
```

量化的分析方式: 單變量
====================================

```r
quantile(iris$Sepal.Length)
```

```
  0%  25%  50%  75% 100% 
 4.3  5.1  5.8  6.4  7.9 
```

```r
var(iris$Sepal.Length)
```

```
[1] 0.6856935
```

```r
sd(iris$Sepal.Length)
```

```
[1] 0.8280661
```


量化的分析方式: 雙變量
====================================
- 列聯表 Crosstabs `table()`, `prop.table()`
- 相關性 Correlation `cor()`

量化的分析方式: 雙變量-列聯表
====================================
汽缸的數目與自手排的關係

```r
table(mtcars$cyl,mtcars$am)
```

```
   
     0  1
  4  3  8
  6  4  3
  8 12  2
```

量化的分析方式: 雙變量-相關性
====================================
油耗跟馬力的關聯性（相關係數）

```r
cor(mtcars$mpg,mtcars$hp)
```

```
[1] -0.7761684
```

量化的分析方式 w/ R
====================================
- 大多可用R的內建函數完成計算
- 但是在探索式分析時，常常需要**資料分組**
    - 觀察**男性**和**女性**的血壓差異
    - **A隊**與**B隊**的三分球命中率差異
    - **中鋒**和**後衛**的助攻次數
    - ...等
- 若只用基本的內建函數計算，相當耗時
    - `data.table`和`dplyr` packages可以快速完成**分組分析**!

data.table 參考文件與資源
====================================
- [官網](https://rdatatable.gitlab.io/data.table/)
- 指令全集[The data.table R package cheat sheet](https://s3.amazonaws.com/assets.datacamp.com/img/blog/data+table+cheat+sheet.pdf)
- [A data.table R tutorial by DataCamp](https://www.datacamp.com/community/tutorials/data-table-r-tutorial#gs.vzMYa_k)
- DataCamp [互動式教學課程](https://www.datacamp.com/courses/data-table-data-manipulation-r-tutorial)


dplyr
====================================
type:sub-section 

- [Hadley Wickham](http://hadley.nz/)開發
- 使用以下函數分析整理資料：
    - `select()`: 選要分析的欄位，欄位子集 (Column)
    - `filter()`: 選要分析的觀察值，觀察值子集 (Row)
    - `mutate()`: 增加新欄位
    - `summarise()`: 計算統計值

dplyr
====================================
type:sub-section 

- 使用以下函數分析整理資料：
    - `group_by()`: 分組依據
    - `arrange()`: 觀察值排序
    - `rename()`: 欄位重新命名
    - `slice()`: 切出需要資料
    - `%>%`: the “pipe” operator 連結上數函式，將所有函式計算串在一起執行

dplyr
====================================

如要使用必須安裝並載入`dplyr` package

```r
install.packages("dplyr") ##安裝
```

```r
library(dplyr) ##載入
```

以[房屋實價登錄資料](http://plvr.land.moi.gov.tw/Download?type=zip&fileName=lvr_landcsv.zip)為例，首先先[讀入二手屋資料](https://github.com/CGUIM-BigDataAnalysis/BigDataCGUIM/blob/master/EMBA_BigData/AllOldData.csv)

```r
library(readr)
AllOldData<-read_csv("AllOldData.csv", ,
        col_types = cols(
          電梯 = col_character(),
          非都市土地使用分區= col_character(),
          非都市土地使用編定= col_character()
          )
)
```

欄位(Column)子集 select() 
====================================
- 針對欄位 (Column)做子集
- `select(資料名稱,欄位條件1,欄位條件2,...)`
- 條件1與條件2是使用**或**的連結概念


欄位(Column)子集 select() 
====================================
- `dplyr`提供幾個方便篩選名稱的函式：
    - `starts_with()`
    - `ends_with()`
    - `contains()`
    - `matches()`: matches a regular expression
    - `num_range()`: num_range("x", 8:11).
    - `one_of()`: variables in character vector
    - `everything()`

詳細說明可在R執行視窗中輸入`?select_helpers`查看。

欄位(Column)子集 select() 
====================================
篩選欄位名稱為`土地位置建物門牌`、開頭是`交易`或是開頭是`建物`的欄位

```r
select1<-
    select(AllOldData,土地位置建物門牌,
           starts_with("交易"),
            starts_with("建物"))
select1
```

|土地位置建物門牌    |交易標的 | 交易年月日|交易筆棟數      |建物型態 | 建物移轉總面積平方公尺| 建物現況格局-房| 建物現況格局-廳| 建物現況格局-衛|建物現況格局-隔間 |
|:-------------------|:--------|----------:|:---------------|:--------|----------------------:|---------------:|---------------:|---------------:|:-----------------|
|豐年段三小段341地號 |土地     |    1111201|土地1建物0車位0 |其他     |                      0|               0|               0|               0|有                |

欄位(Column)子集 select() 
====================================

若想篩選欄位`土地位置建物門牌`到欄位`交易筆棟數`間的所有欄位，但不想要`非都市土地使用分區`欄位
- 用`:`串連欄位名稱
- 用`-`去除不要的欄位

```r
select3<-
    select(AllOldData,
           土地位置建物門牌:交易筆棟數,
           -非都市土地使用分區)
head(select3,3)
```

|土地位置建物門牌                         | 土地移轉總面積平方公尺|都市土地使用分區                                                                                |非都市土地使用編定 | 交易年月日|交易筆棟數      |
|:----------------------------------------|----------------------:|:-----------------------------------------------------------------------------------------------|:------------------|----------:|:---------------|
|豐年段三小段341地號                      |                 407.82|都市：其他:農業區。                                                                             |NA                 |    1111201|土地1建物0車位0 |
|臺北市大安區和平東路一段１９１號十樓之２ |                   4.52|商                                                                                              |NA                 |    1111201|土地2建物1車位0 |
|臺北市中山區林森北路５３６號地下三層     |                   0.55|都市：其他:第肆種商業區(依都市計畫說明書圖規定辦理，始得作第肆種商業區使用)(原屬第參種商業區)。 |NA                 |    1111201|土地1建物1車位1 |

觀察值(Row)子集 filter()
====================================
- 是針對列 (Row)做子集
- `filter(資料名稱,篩選條件1,篩選條件2)`篩選條件們是用**且**的邏輯串連
- **單價元平方公尺超過1,000,000**的房屋資料，可輸入下列指令

```r
filter(AllOldData,單價元平方公尺>1000000)
```

|鄉鎮市區 |交易標的        |土地位置建物門牌                     | 土地移轉總面積平方公尺|都市土地使用分區  |非都市土地使用分區 |非都市土地使用編定 | 交易年月日|交易筆棟數      |移轉層次 |總樓層數 |建物型態 |主要用途 |主要建材     |建築完成年月 | 建物移轉總面積平方公尺| 建物現況格局-房| 建物現況格局-廳| 建物現況格局-衛|建物現況格局-隔間 |有無管理組織 |    總價元| 單價元平方公尺|車位類別 | 車位移轉總面積(平方公尺)| 車位總價元|備註 | 主建物面積| 附屬建物面積| 陽台面積|電梯 |移轉編號 |
|:--------|:---------------|:------------------------------------|----------------------:|:-----------------|:------------------|:------------------|----------:|:---------------|:--------|:--------|:--------|:--------|:------------|:------------|----------------------:|---------------:|---------------:|---------------:|:-----------------|:------------|---------:|--------------:|:--------|------------------------:|----------:|:----|----------:|------------:|--------:|:----|:--------|
|頭份市   |房地(土地+建物) |苗栗縣頭份市仁愛里１２鄰日新街２５號 |                4964.05|都市：其他:商業區 |NA                 |NA                 |    1110810|土地1建物1車位0 |全       |一層     |透天厝   |其他     |鐵架水泥瓦頂 |NA           |                 578.09|               0|               0|               0|無                |無           | 690749000|        1194881|NA       |                        0|          0|NA   |     578.09|            0|        0|無   |NA       |
|彰化市   |房地(土地+建物) |彰化縣彰化市中山路三段５２１號       |                1026.33|NA                |鄉村區             |乙種建築用地       |    1101002|土地4建物1車位0 |全       |二層     |透天厝   |住家用   |加強磚造     |0590101      |                  42.63|               3|               1|               2|有                |無           |  64000000|        1501290|NA       |                        0|          0|NA   |      42.63|            0|        0|無   |087      |

觀察值(Row)子集 filter()
====================================
也可選擇鄉鎮市區為大安區與信義區的房屋資料

```r
filter(AllOldData,
       鄉鎮市區 %in% c("大安區","信義區"))
```

|鄉鎮市區 |交易標的        |土地位置建物門牌                             | 土地移轉總面積平方公尺|都市土地使用分區 |非都市土地使用分區 |非都市土地使用編定 | 交易年月日|交易筆棟數      |移轉層次   |總樓層數 |建物型態                   |主要用途 |主要建材     |建築完成年月 | 建物移轉總面積平方公尺| 建物現況格局-房| 建物現況格局-廳| 建物現況格局-衛|建物現況格局-隔間 |有無管理組織 |   總價元| 單價元平方公尺|車位類別 | 車位移轉總面積(平方公尺)| 車位總價元|備註                                       | 主建物面積| 附屬建物面積| 陽台面積|電梯 |移轉編號 |
|:--------|:---------------|:--------------------------------------------|----------------------:|:----------------|:------------------|:------------------|----------:|:---------------|:----------|:--------|:--------------------------|:--------|:------------|:------------|----------------------:|---------------:|---------------:|---------------:|:-----------------|:------------|--------:|--------------:|:--------|------------------------:|----------:|:------------------------------------------|----------:|------------:|--------:|:----|:--------|
|大安區   |房地(土地+建物) |臺北市大安區和平東路一段１９１號十樓之２     |                   4.52|商               |NA                 |NA                 |    1111201|土地2建物1車位0 |十層       |十四層   |住宅大樓(11層含以上有電梯) |住家用   |鋼筋混凝土造 |1071224      |                  46.98|               1|               1|               1|有                |有           | 17200000|         366113|NA       |                        0|          0|NA                                         |      25.62|         1.20|     1.69|有   |002      |
|信義區   |房地(土地+建物) |臺北市信義區仁愛路四段５１２巷１６之１號八樓 |                   6.47|住               |NA                 |NA                 |    1111105|土地2建物1車位0 |八層       |八層     |華廈(10層含以下有電梯)     |住家用   |鋼筋混凝土造 |0951226      |                  38.11|               2|               2|               1|有                |有           | 12300000|         322750|NA       |                        0|          0|其他增建；                                 |      20.35|         5.56|     0.00|有   |NA       |
|信義區   |房地(土地+建物) |臺北市信義區吳興街２８４巷２２弄７４號       |                  46.50|住               |NA                 |NA                 |    1111105|土地2建物1車位0 |一層       |四層     |公寓(5樓含以下無電梯)      |住家用   |加強磚造     |0551121      |                  82.35|               4|               2|               2|有                |無           | 18000000|         218579|NA       |                        0|          0|其他增建；                                 |      82.35|         0.00|     0.00|無   |NA       |
|信義區   |房地(土地+建物) |臺北市信義區嘉興街１５５之６號三樓           |                  26.25|住               |NA                 |NA                 |    1111103|土地1建物1車位0 |三層，陽臺 |四層     |公寓(5樓含以下無電梯)      |住家用   |鋼筋混凝土造 |0631205      |                  73.91|               3|               2|               1|有                |無           | 15100000|         204303|NA       |                        0|          0|陽台外推；                                 |      73.91|         0.00|     0.00|無   |NA       |
|信義區   |房地(土地+建物) |臺北市信義區松山路５４０巷２２號房屋地下一層 |                  23.40|住               |NA                 |NA                 |    1111106|土地1建物1車位0 |地下一層   |五層     |公寓(5樓含以下無電梯)      |其他     |鋼筋混凝土造 |0800611      |                  91.39|               3|               0|               3|有                |無           |  8660000|          94759|NA       |                        0|          0|NA                                         |      91.39|         0.00|     0.00|無   |010      |
|大安區   |房地(土地+建物) |臺北市大安區光復南路５５６號二樓之３         |                   0.80|商               |NA                 |NA                 |    1111122|土地2建物1車位0 |二層       |十二層   |住宅大樓(11層含以上有電梯) |商業用   |鋼筋混凝土造 |0781019      |                   8.45|               2|               2|               2|有                |有           |  2400000|         284024|NA       |                        0|          0|親友、員工、共有人或其他特殊關係間之交易； |       5.55|         0.00|     1.14|有   |012      |


觀察值(Row)子集 filter()
====================================
也可使用 `&` 和 `|`等符號串連邏輯

```r
filter(AllOldData,
       鄉鎮市區 %in% c("大安區","信義區")
           &單價元平方公尺>1000000)
```

|鄉鎮市區 |交易標的 |土地位置建物門牌 | 土地移轉總面積平方公尺|都市土地使用分區 |非都市土地使用分區 |非都市土地使用編定 | 交易年月日|交易筆棟數 |移轉層次 |總樓層數 |建物型態 |主要用途 |主要建材 |建築完成年月 | 建物移轉總面積平方公尺| 建物現況格局-房| 建物現況格局-廳| 建物現況格局-衛|建物現況格局-隔間 |有無管理組織 | 總價元| 單價元平方公尺|車位類別 | 車位移轉總面積(平方公尺)| 車位總價元|備註 | 主建物面積| 附屬建物面積| 陽台面積|電梯 |移轉編號 |
|:--------|:--------|:----------------|----------------------:|:----------------|:------------------|:------------------|----------:|:----------|:--------|:--------|:--------|:--------|:--------|:------------|----------------------:|---------------:|---------------:|---------------:|:-----------------|:------------|------:|--------------:|:--------|------------------------:|----------:|:----|----------:|------------:|--------:|:----|:--------|

dplyr 子集練習
====================================
type:alert
incremental:true

- 讀入[實價登錄預售屋](https://github.com/CGUIM-BigDataAnalysis/BigDataCGUIM/blob/master/EMBA_BigData/AllPreData.csv)資料

```r
library(dplyr)
library(readr)
AllPreData<-read_csv("AllPreData.csv", ,
           col_types = cols(
             非都市土地使用分區= col_character(),
              非都市土地使用編定= col_character()
              )
)
```
- 試著用dplyr語法篩選出所有**單價元平方公尺超過40萬**且**主要用途為住家用**的預售屋買賣資料
- 只留下鄉鎮市區 開頭為**土地** 以及開頭為**交易** 的 欄位


子集Subset - 二維資料grepl()
====================================
**Row的篩選**也可搭配字串搜尋函數`grepl()`

```r
grepl("color",iris$Species)
filter(iris,grepl("color",Species))##Species包含"color"的row，所有的column
```

```
[1] FALSE FALSE FALSE FALSE FALSE FALSE
```



| Sepal.Length| Sepal.Width| Petal.Length| Petal.Width|Species    |
|------------:|-----------:|------------:|-----------:|:----------|
|          7.0|         3.2|          4.7|         1.4|versicolor |
|          6.4|         3.2|          4.5|         1.5|versicolor |
|          6.9|         3.1|          4.9|         1.5|versicolor |
|          5.5|         2.3|          4.0|         1.3|versicolor |
|          6.5|         2.8|          4.6|         1.5|versicolor |
|          5.7|         2.8|          4.5|         1.3|versicolor |


增加新欄位 mutate()
====================================
- 新增新欄位`建物總坪數`，欄位值為`建物移轉總面積平方公尺*0.3025`

```r
mutate1<-
    mutate(AllOldData,
           建物總坪數=
             建物移轉總面積平方公尺*0.3025)
mutate1$建物總坪數[1:5]
```

```
[1]  0.00000 14.21145 12.72315 10.58145 10.58145
```

計算統計值 summarise() 
====================================
- **買賣筆數**、**不重複的鄉鎮區數**以及**交易標的數**等
- n(), n_distinct()

```r
summarise(AllOldData,
          nPlayer=n(),
          nC=n_distinct(鄉鎮市區),
          nTarget=n_distinct(交易標的))
```

```
# A tibble: 1 × 3
  nPlayer    nC nTarget
    <int> <int>   <int>
1    9596   319       5
```

計算統計值 summarise() 
====================================
- 通常會與其他功能合併使用
- 計算**單價元平方公尺超過1,000,000**的**交易筆數**、**平均建物移轉總面積平方公尺**以及**平均土地移轉總面積平方公尺**

```r
filter1<-filter(AllOldData,單價元平方公尺>1000000)
summarise(filter1,
    nHouse=n(),
    meanBuild=mean(建物移轉總面積平方公尺),
    meanLand=mean(土地移轉總面積平方公尺))
```

```
# A tibble: 1 × 3
  nHouse meanBuild meanLand
   <int>     <dbl>    <dbl>
1      2      310.    2995.
```

dplyr filter()+summarise() 練習
====================================
type:alert
incremental:true

- 讀入[實價登錄預售屋](https://github.com/CGUIM-BigDataAnalysis/BigDataCGUIM/blob/master/EMBA_BigData/AllPreData.csv)資料

```r
library(dplyr)
library(readr)
AllPreData<-read_csv("AllPreData.csv", ,
           col_types = cols(
             非都市土地使用分區= col_character(),
              非都市土地使用編定= col_character()
              )
)
```
- 試著用dplyr語法篩選出所有**單價元平方公尺超過40萬**且**主要用途為住家用**的預售屋買賣資料
- 計算這些房屋的**平均建物移轉總面積平方公尺**，**平均土地移轉總面積平方公尺**

pipe %>%
====================================
- 直接用**pipe**符號`%>%`將指令串連，減少暫存物件（filter1）的生成

```r
filter(AllOldData,單價元平方公尺>1000000) %>%
  summarise(nHouse=n(),
      meanBuild=mean(建物移轉總面積平方公尺),
      meanLand=mean(土地移轉總面積平方公尺))
```

```
# A tibble: 1 × 3
  nHouse meanBuild meanLand
   <int>     <dbl>    <dbl>
1      2      310.    2995.
```

分組 group_by()
====================================
- 設定分組依據
- 與`summarise()`函式合併使用
- 計算各**鄉鎮市區**（以鄉鎮市區作為分組依據）的**交易筆數**、**平均建物移轉總面積平方公尺**以及**平均土地移轉總面積平方公尺**

```r
group_by(AllOldData,鄉鎮市區)%>%
    summarise(nHouse=n(),
      meanBuild=mean(建物移轉總面積平方公尺),
      meanLand=mean(土地移轉總面積平方公尺))
```

|鄉鎮市區 | nHouse| meanBuild|  meanLand|
|:--------|------:|---------:|---------:|
|七堵區   |     10|  68.90700|   125.302|
|七美鄉   |      1|   0.00000|   443.910|
|七股區   |     11|  83.86273|  1217.344|
|三地門鄉 |      1|   0.00000| 15845.000|

分組 group_by()
====================================
- 可設定**多個**分組依據
- 計算各**鄉鎮市區**各**交易標的**（以鄉鎮市區和交易標的作為分組依據）的**交易筆數**、**平均建物移轉總面積平方公尺**以及**平均總價元**

```r
group_by(AllOldData,鄉鎮市區,交易標的)%>%
    summarise(nHouse=n(),
      meanBuild=mean(建物移轉總面積平方公尺),
      meanPrice=mean(總價元))
```

|鄉鎮市區 |交易標的             | nHouse| meanBuild| meanPrice|
|:--------|:--------------------|------:|---------:|---------:|
|七堵區   |土地                 |      2|     0.000|   1447200|
|七堵區   |房地(土地+建物)      |      5|    65.996|   4480000|
|七堵區   |房地(土地+建物)+車位 |      2|   160.315|   9675000|

排序 arrange()
====================================
排序功能，預設為**遞增排序**

```r
arrange(AllOldData,總價元)
```

|鄉鎮市區 |交易標的 |土地位置建物門牌    | 土地移轉總面積平方公尺|都市土地使用分區                          |非都市土地使用分區 |非都市土地使用編定 | 交易年月日|交易筆棟數      |移轉層次 |總樓層數 |建物型態 |主要用途 |主要建材 |建築完成年月 | 建物移轉總面積平方公尺| 建物現況格局-房| 建物現況格局-廳| 建物現況格局-衛|建物現況格局-隔間 |有無管理組織 | 總價元| 單價元平方公尺|車位類別 | 車位移轉總面積(平方公尺)| 車位總價元|備註                     | 主建物面積| 附屬建物面積| 陽台面積|電梯 |移轉編號 |
|:--------|:--------|:-------------------|----------------------:|:-----------------------------------------|:------------------|:------------------|----------:|:---------------|:--------|:--------|:--------|:--------|:--------|:------------|----------------------:|---------------:|---------------:|---------------:|:-----------------|:------------|------:|--------------:|:--------|------------------------:|----------:|:------------------------|----------:|------------:|--------:|:----|:--------|
|大園區   |土地     |林段353地號        |                   0.01|都市：其他:排水渠道用地                   |NA                 |NA                 |    1111115|土地1建物0車位0 |NA       |NA       |其他     |NA       |NA       |NA           |                      0|               0|               0|               0|有                |無           |    209|              0|NA       |                        0|          0|NA                       |          0|            0|        0|無   |NA       |
|士林區   |土地     |天山段二小段146地號 |                   0.02|都市：其他:道路用地(公共設施用地)。42/2/2 |NA                 |NA                 |    1111017|土地1建物0車位0 |NA       |NA       |其他     |NA       |NA       |NA           |                      0|               0|               0|               0|有                |無           |    566|              0|NA       |                        0|          0|包含公共設施保留地用地； |          0|            0|        0|無   |NA       |
|內湖區   |土地     |石潭段二小段300地號 |                   0.13|NA                                        |NA                 |NA                 |    1111122|土地2建物0車位0 |NA       |NA       |其他     |NA       |NA       |NA           |                      0|               0|               0|               0|有                |無           |    700|              0|NA       |                        0|          0|包含公共設施保留地用地； |          0|            0|        0|無   |043      |
|台東市   |土地     |豐聖段17-5地號      |                   0.05|都市：其他:住宅區                         |NA                 |NA                 |    1111108|土地1建物0車位0 |NA       |NA       |其他     |NA       |NA       |NA           |                      0|               0|               0|               0|有                |無           |   1018|              0|NA       |                        0|          0|政府機關標讓售；         |          0|            0|        0|無   |NA       |
|壯圍鄉   |土地     |新福段1264地號      |                   0.38|NA                                        |特定農業區         |交通用地           |    1111110|土地2建物0車位0 |NA       |NA       |其他     |NA       |NA       |NA           |                      0|               0|               0|               0|有                |無           |   1692|              0|NA       |                        0|          0|協議價購；               |          0|            0|        0|無   |NA       |
|台東市   |土地     |建華段1560地號      |                   0.92|都市：其他:道路用地                       |NA                 |NA                 |    1111129|土地1建物0車位0 |NA       |NA       |其他     |NA       |NA       |NA           |                      0|               0|               0|               0|有                |無           |   2080|              0|NA       |                        0|          0|協議價購；               |          0|            0|        0|無   |NA       |

遞減排序 arrange()
====================================
使用`desc()`將要**遞減排序**的變數包起來，就可以遞減排序

```r
arrange(AllOldData,desc(總價元))
```

|鄉鎮市區 |交易標的        |土地位置建物門牌                   | 土地移轉總面積平方公尺|都市土地使用分區          |非都市土地使用分區 |非都市土地使用編定 | 交易年月日|交易筆棟數       |移轉層次 |總樓層數 |建物型態 |主要用途 |主要建材         |建築完成年月 | 建物移轉總面積平方公尺| 建物現況格局-房| 建物現況格局-廳| 建物現況格局-衛|建物現況格局-隔間 |有無管理組織 |     總價元| 單價元平方公尺|車位類別 | 車位移轉總面積(平方公尺)| 車位總價元|備註 | 主建物面積| 附屬建物面積| 陽台面積|電梯 |移轉編號 |
|:--------|:---------------|:----------------------------------|----------------------:|:-------------------------|:------------------|:------------------|----------:|:----------------|:--------|:--------|:--------|:--------|:----------------|:------------|----------------------:|---------------:|---------------:|---------------:|:-----------------|:------------|----------:|--------------:|:--------|------------------------:|----------:|:----|----------:|------------:|--------:|:----|:--------|
|大園區   |房地(土地+建物) |桃園市大園區高鐵站前西路三段６６號 |               25025.40|NA                        |一般農業區         |丁種建築用地       |    1110930|土地15建物3車位0 |全       |五層     |透天厝   |工業用   |鋼骨鋼筋混凝土造 |1070119      |              114605.47|               0|               0|               0|無                |無           | 6300000000|          54971|NA       |                        0|          0|NA   |  114605.47|            0|        0|有   |NA       |
|橋頭區   |房地(土地+建物) |高雄市橋頭區芋寮路２９７之５號     |               83315.38|NA                        |特定專用區         |丁種建築用地       |    1110819|土地44建物1車位0 |全       |四層     |透天厝   |辦公用   |鋼筋混凝土造     |0800120      |                3865.33|               0|               0|               0|無                |無           | 2568155819|         664408|NA       |                        0|          0|NA   |    3865.33|            0|        0|無   |NA       |
|板橋區   |土地            |亞東段1023地號                     |                6906.00|都市：其他:通訊數位專用區 |NA                 |NA                 |    1111031|土地18建物0車位0 |NA       |NA       |其他     |NA       |NA               |NA           |                   0.00|               0|               0|               0|有                |無           | 2289615240|         331540|NA       |                        0|          0|NA   |       0.00|            0|        0|無   |NA       |

dplyr綜合範例
====================================
- 結合`group_by()`、`summarise()`、`arrange()`，可完成一連串的資料分析
- 計算各**鄉鎮市區**各**交易標的**（以鄉鎮市區和交易標的作為分組依據）的交易筆數、平均總價元、平均單價元平方公尺，並依平均單價元平方公尺**由大到小排序**

```r
group_by(AllOldData,鄉鎮市區,交易標的) %>%
  summarise(nHouse=n(),
    meanPrice=mean(總價元),
    meanUPrice=mean(單價元平方公尺)) %>%
  arrange(desc(meanUPrice))
```

|鄉鎮市區 |交易標的             | nHouse| meanPrice| meanUPrice|
|:--------|:--------------------|------:|---------:|----------:|
|板橋區   |土地                 |     18| 209741646|   366229.2|
|中山區   |土地                 |      2|   3129700|   360150.0|
|大安區   |房地(土地+建物)+車位 |      6|  42516667|   325935.8|

修改欄位名稱 rename()
====================================
`新名稱=舊名稱`

```r
rename1<-rename(AllOldData,門牌=土地位置建物門牌)
rename1[1:5,1:3]
```

|鄉鎮市區 |交易標的        |門牌                                     |
|:--------|:---------------|:----------------------------------------|
|北投區   |土地            |豐年段三小段341地號                      |
|大安區   |房地(土地+建物) |臺北市大安區和平東路一段１９１號十樓之２ |
|中山區   |車位            |臺北市中山區林森北路５３６號地下三層     |
|中正區   |車位            |臺北市中正區愛國東路８２號等共有部分     |
|中正區   |車位            |臺北市中正區愛國東路８２號等共有部分     |

dplyr 綜合練習
====================================
type:alert
incremental:true

- 讀入[實價登錄預售屋](https://github.com/CGUIM-BigDataAnalysis/BigDataCGUIM/blob/master/EMBA_BigData/AllPreData.csv)資料

```r
library(dplyr)
library(readr)
AllPreData<-read_csv("AllPreData.csv", ,
    col_types = cols(
      非都市土地使用分區= col_character(),
      非都市土地使用編定= col_character()
      )
)
```
- 試著用dplyr語法篩選出所有**建物型態為住宅大樓(11層含以上有電梯)**且**建物移轉總面積平方公尺 大於100**的交易資料
- 依**鄉鎮市區**分組，計算交易的平均**總價元**，平均**單價元平方公尺**
- 依平均**單價元平方公尺** **由大到小**排序
- 用pipe **%>%**

dplyr 參考文件與資源
====================================
- [Introduction to dplyr](https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html)
- DataCamp互動式教學課程 [Data Manipulation in R with dplyr](https://www.datacamp.com/courses/dplyr-data-manipulation-r-tutorial)



資料視覺化大綱
====================================
type:sub-section 

- 資料視覺化的目的
- ggplot2
- ggplot2+地圖
- 台灣面量圖
- Heatmap
- Treemap

資料視覺化的目的
====================================
type:sub-section 
- 探索圖 (Exploratory graphs)
    - 了解資料的特性
    - 尋找資料的模式(patterns)
    - 建議資料分析與建模的策略
- 結果圖 (Final graphs)
    - 結果呈現與溝通
    
探索圖特性
====================================
- 很快就可以做一張圖
- 主要目的是了解資料的樣子
- 不用做圖形格式調整美化

結果圖特性
====================================
- 比較，呈現差異
    - 比較什麼？誰跟誰比較？
- 呈現因果關係（causality）,機制（mechanism）,結果解釋（explanation）,系統化的結構（systematic structure）
    - 因果模型？為什麼你想要做這樣的比較
- 呈現多變數（Multivariate）資料
    - 多變數（Multivariate）：超過兩個變數就叫多變數
    - 所有真實事件都是多變數的

結果圖特性
====================================
- 將證據整合呈現
    - 在同一個畫面呈現文字、數字、圖表
    - 盡量用圖形呈現資料
- 將圖表做適當的標記與說明，包括xy軸名稱、單位、資料來源等
    - 資料圖表必須可以呈現你想說的故事
- 內容才是最重要的
    - 資料不好，分析不好，圖表再美也沒有用
    
常用的畫圖套件
====================================
type:sub-section 

- 基本功能(Base)：可自學
- `lattice`：可自學
- `ggplot2`

ggplot2簡介
====================================
type:sub-section 

- Dr. Leland Wilkinson [Grammar of Graphics](http://www.springer.com/us/book/9780387245447)

“In brief, the grammar tells us that a statistical graphic is a `mapping` from data to `aesthetic` attributes (colour, shape, size) of `geometric` objects (points, lines, bars). The plot may also contain statistical transformations of the data and is drawn on a specific coordinate system”

-from `ggplot2` book

ggplot2簡介
====================================
- [Hadley Wickham](http://hadley.nz/)開發
- 一直是最熱門的R packages之一
- [ggplot2 GitHub](https://github.com/tidyverse/ggplot2)

ggplot2簡介
====================================
- 做圖的文法包括兩個最主要元素
    - **Aesthetic attributes**：包括顏色、形狀、點的大小與線的粗細等
    - **Geometric objects**：包括點、線、盒狀圖、直條圖等

- 其他元素
    - **Facets**：提供在同一張圖內做多個子圖的方法，只要使用Faceting功能設定子圖分類的依據參數即可
    - **Stats**：將資料做統計轉換
    - **Scales**：修改點線的顏色、形狀、xy軸的範圍等

ggplot() 
====================================
type:sub-section 

使用ggplot2作圖有以下步驟：

- 準備好資料
- 設定**Aesthetic attributes**
    - 使用`aes(x, y, ...)`指定
- 指定**Geometric objects**
    - `geom_point()`
    - `geom_line()`
    - `geom_polygon()`
    - `geom_errorbar()`

ggplot() 
====================================

```r
library(ggplot2) 
##先安裝 install.packages("ggplot2")
```

- ggplot(data,...)

ggplot() 設定重要元素
====================================
- **Aesthetic attributes**
    - aes(x = Species, y = Sepal.Length)
- **Geometric objects**
    - geom_point()

```r
ggplot(iris, 
       aes(x = Species, y = Sepal.Length)) + 
    geom_point()
```

![plot of chunk unnamed-chunk-15](EMBA_PipelinesForDataAnalysisInR3-figure/unnamed-chunk-15-1.png)

ggplot() geom_boxpolt()
====================================
用`geom_boxplot()`改畫盒狀圖

```r
ggplot(iris, 
       aes(x = Species, 
           y = Sepal.Length)) + 
    geom_boxplot()
```

![plot of chunk unnamed-chunk-16](EMBA_PipelinesForDataAnalysisInR3-figure/unnamed-chunk-16-1.png)

ggplot() Faceting
====================================
**直向分類**~**橫向分類**

```r
ggplot(iris, 
       aes(x = Sepal.Width, 
           y = Sepal.Length)) + 
    geom_point()+facet_grid(Species~.)
```

![plot of chunk unnamed-chunk-17](EMBA_PipelinesForDataAnalysisInR3-figure/unnamed-chunk-17-1.png)

ggplot() Faceting
====================================
**直向分類**~**橫向分類**

```r
ggplot(iris, 
       aes(x = Sepal.Width, 
           y = Sepal.Length)) + 
    geom_point()+facet_grid(.~Species)
```

![plot of chunk unnamed-chunk-18](EMBA_PipelinesForDataAnalysisInR3-figure/unnamed-chunk-18-1.png)

ggplot() geom_smooth()
====================================
替xy散佈圖加上趨勢線

```r
ggplot(iris, 
       aes(x = Sepal.Width, 
           y = Sepal.Length)) + 
    geom_point()+facet_grid(Species~.)+
    geom_smooth()
```

![plot of chunk unnamed-chunk-19](EMBA_PipelinesForDataAnalysisInR3-figure/unnamed-chunk-19-1.png)

ggplot() geom_smooth()
====================================
替xy散佈圖加上趨勢線，使用linear regresion

```r
ggplot(iris, 
       aes(x = Sepal.Width, 
           y = Sepal.Length)) + 
    geom_point()+facet_grid(Species~.)+
    geom_smooth(method='lm')
```

![plot of chunk unnamed-chunk-20](EMBA_PipelinesForDataAnalysisInR3-figure/unnamed-chunk-20-1.png)

ggplot() geom_line()
====================================
改用`geom_line()`畫線

```r
ggplot(iris, 
       aes(x = Sepal.Width, 
           y = Sepal.Length)) + 
    geom_line()+facet_grid(Species~.)
```

![plot of chunk unnamed-chunk-21](EMBA_PipelinesForDataAnalysisInR3-figure/unnamed-chunk-21-1.png)

ggplot() 顏色分組
====================================
改用顏色分組，使用`aes(color='group name')`

```r
ggplot(iris, 
       aes(x = Sepal.Width, 
           y = Sepal.Length,
           color=Species)) + 
    geom_line()
```

![plot of chunk unnamed-chunk-22](EMBA_PipelinesForDataAnalysisInR3-figure/unnamed-chunk-22-1.png)

ggplot() 綜合練習 
====================================
type:alert
incremental:true

- 讀入內建iris資料
- 用**ggplot()**畫xy散佈圖
    - x軸：Sepal.Length
    - y軸：Sepal.Width
    - 子圖：Species，每個Species畫在新的**欄位**
- 用**ggplot()**做盒狀圖
    - x軸：Species
    - y軸：Sepal.Width


ggplot() 注意事項
====================================
- 提供資料時，把資料修改為想要在圖片顯示的文字
- 如果是離散性的資料，但卻又是數值時（像是1,2,3）可以用factor()轉換

ggplot() 資料標示+參數設定
====================================

- 標籤 `xlab()`, `ylab()`, `labs(x=,y=)`, `ggtitle()`
- 每一個`geom_*()`都有參數可設定
- 圖形樣式設定 `theme()`，可使用內建樣式
  - `theme_gray()`: 灰背景，預設樣式
  - `theme_bw()`: 黑白樣式
- 使用其他樣式套件
  - `ggthemes` packages [Website](https://yutannihilation.github.io/allYourFigureAreBelongToUs/ggthemes/)
  - `xkcd` packages [Website](http://xkcd.r-forge.r-project.org/)

ggplot2 參考資料
====================================
- [ggplot2 官網](http://ggplot2.tidyverse.org/)
- [ggplot2 package source code](https://github.com/tidyverse/ggplot2)
- [ggplot2 cheat sheet](https://raw.githubusercontent.com/rstudio/cheatsheets/main/data-visualization.pdf)
- [ggplot2 doc](http://docs.ggplot2.org/)


ggplot2+地圖
====================================
type:sub-section 

- Choropleth map面量圖
- ggmap()
- Density Map
- 參考資料


ggmap package
====================================
- 把google map載入並作圖的套件
- 基於`ggplot2`套件開發
- 第一次使用前需要安裝

```r
##第一次使用前先安裝
install.packages("ggmap") 
```
- `get_googlemap()`函式取得google map圖層
    - center 中心點經緯度座標
    - zoom 放大倍率
    - language 地圖語言
- `ggmap()`函式將取得的圖層畫出來


get_googlemap() + ggmap()
====================================
- 使用`register_google(key = "your key")`帶入google金鑰
- 可自行至[Google Cloud Platform](https://console.cloud.google.com/)，點選**API及服務**申請**Maps Static API**後，查詢**憑證**，複製**API key**（需綁定信用卡付款）

```r
library(ggmap)
register_google(key = "AIzaSyAvNeyA_Uy8Z3JlzDnDuXQg7FhKFeVyNbY")
twmap <- get_googlemap(center = c(lon=120.58,lat=23.58), 
                  zoom = 7,
                  language = "zh-TW")
ggmap(twmap)
```

![plot of chunk unnamed-chunk-24](EMBA_PipelinesForDataAnalysisInR3-figure/unnamed-chunk-24-1.png)

ggmap + open data 資料載入
====================================
- 只要資料有經緯度等資訊，就可以使用`ggmap` package與各式資料結合呈現
- [台北市水質資料](https://twd.water.gov.taipei/opendata/wqb/wqb.asmx/GetQualityData)

```r
library(xml2)
WaterData<-read_xml("https://twd.water.gov.taipei/opendata/wqb/wqb.asmx/GetQualityData")
code_name<-WaterData %>% xml_find_all("//code_name")%>% 
  xml_text()
longitude<-WaterData %>% xml_find_all("//longitude")%>% 
  xml_text() %>% as.numeric()
latitude<-WaterData %>% xml_find_all("//latitude")%>% 
  xml_text()%>% as.numeric()
qua_cntu<-WaterData %>% xml_find_all("//qua_cntu") %>% 
  xml_text()%>% as.numeric()
WaterDataFrame<-data.frame(code_name,longitude,latitude,qua_cntu)
WaterDataClean<-WaterDataFrame[WaterDataFrame$qua_cntu>=0,]
head(WaterDataClean)
```

```
                 code_name longitude latitude qua_cntu
1               雙溪淨水場  121.5694 25.11419     0.01
2                 衛理女中  121.5523 25.10176     0.03
3 雙溪國小                  121.5639 25.10607     0.10
4               華興加壓站  121.5444 25.09952     0.18
5               長興淨水場  121.5479 25.01451     0.02
6                 市政大樓  121.5640 25.03753     0.08
```

ggmap + open data 繪圖
====================================

```r
library(ggmap)
TaipeiMap <- get_googlemap(
    center  = c(lon=121.50,lat=25.06), 
    zoom = 11, maptype = 'roadmap')
TaipeiMapO <- ggmap(TaipeiMap)+ 
    geom_point(data=WaterDataClean, 
               aes(x=longitude, y=latitude,
                   color=qua_cntu,size=3.5))+ 
    scale_color_continuous(
        low = "yellow",high = "red")+ 
    guides(size="none")
TaipeiMapO
```

ggmap + open data
====================================
![plot of chunk unnamed-chunk-27](EMBA_PipelinesForDataAnalysisInR3-figure/unnamed-chunk-27-1.png)

ggmap + 地圖型態
====================================
`ggmap`套件提供多種地圖型態，使用者可透過設定`maptype`自行選擇適合的地圖樣式，樣式有：

- terrain
- terrain-background
- satellite
- roadmap
- hybrid (google maps)
- watercolor
- toner (stamen maps)

ggmap + extent
====================================
透過設定`extent`參數可將地圖輸出樣式改為滿版

```r
library(ggmap)
#extent = 'device' 滿版
ggmap(TaipeiMap,extent = 'device') 
```

ggmap + extent
====================================
透過設定`extent`參數可將地圖輸出樣式改為滿版
![plot of chunk unnamed-chunk-29](EMBA_PipelinesForDataAnalysisInR3-figure/unnamed-chunk-29-1.png)

ggmap() 練習 
====================================
type:alert
incremental:true

- 利用get_googlemap() + ggmap()取得桃園地區的google 圖層
    - center = c(lon=121.20,lat=25.00)
    - zoom = 11
    - language = "zh-TW"
- 在長庚大學所在地 （座標121.389539,25.035225）加上一個紅色的點
    - geom_point()
    - x= 121.389539
    - y= 25.035225
    - color ="red"

ggmap() 練習輸出圖檔
====================================
![plot of chunk unnamed-chunk-30](EMBA_PipelinesForDataAnalysisInR3-figure/unnamed-chunk-30-1.png)


ggmap 參考資料
====================================
- [ggmap package source code](https://github.com/dkahle/ggmap)
- [ggmap cheat sheet](https://www.nceas.ucsb.edu/~frazier/RSpatialGuides/ggmap/ggmapCheatsheet.pdf)
- [ggmap doc](https://dl.dropboxusercontent.com/u/24648660/ggmap%20useR%202012.pdf)


Choropleth map面量圖
====================================
- Choropleth map[面量圖](https://en.wikipedia.org/wiki/Choropleth_map)
- **把統計資料用顏色畫在對應的地圖上**
- `choroplethr` package來畫面量圖
- 基於`ggplot2` package的`面量圖`做圖工具
- 建議同時安裝`choroplethrMaps` package

```r
##第一次使用前先安裝
install.packages(c("choroplethr",
                   "choroplethrMaps")) 
```

```r
library(choroplethr)
```

choroplethr package
====================================
- 內建美國各州地圖與人口學資料
- 使用`state_choropleth()`函式畫出美國人口分布

```r
data(df_pop_state) #記載各州人口數的資料
#把各州人口畫在地圖上
state_choropleth(df_pop_state) 
```

![plot of chunk unnamed-chunk-33](EMBA_PipelinesForDataAnalysisInR3-figure/unnamed-chunk-33-1.png)

Taiwan的面量圖
====================================
type:sub-section 

- 台灣的面量圖尚無好的套件輔助
- Open Data: 台灣鄉鎮市邊界的經緯度檔案
    - [鄉鎮市區界線](http://data.gov.tw/node/7441)
    - 空間資料開放格式`shapefile` `.shp`
- 使用`shapefile`與`ggplot2`畫圖的步驟如下：
    - 取得空間資料檔案
    - 使用`rgdal`, `rgeos`,`maptools` package處理地圖檔shapefile
    - 使用`ggplot2` & `RColorBrewer` 畫圖
- [實作範例網址](http://yijutseng.github.io/DataScienceRBook/vis.html#taiwan)

Heatmap
====================================
type:sub-section 
- 熱度圖
- 使用顏色的深淺來表示數值的大小
- 搭配XY兩軸的變量
- 使用一張圖就能表示三個維度的資訊
- 在ggplot2套件中，可以使用`geom_tile()`來畫Heatmap
- 以下以NBA球員的資料作為範例

Heatmap
====================================

```r
#讀.csv檔案
nba <- read.csv("http://datasets.flowingdata.com/ppg2008.csv")
head(nba,3)
```

```
           Name  G  MIN  PTS  FGM  FGA   FGP FTM FTA   FTP X3PM X3PA  X3PP ORB
1  Dwyane Wade  79 38.6 30.2 10.8 22.0 0.491 7.5 9.8 0.765  1.1  3.5 0.317 1.1
2 LeBron James  81 37.7 28.4  9.7 19.9 0.489 7.3 9.4 0.780  1.6  4.7 0.344 1.3
3  Kobe Bryant  82 36.2 26.8  9.8 20.9 0.467 5.9 6.9 0.856  1.4  4.1 0.351 1.1
  DRB TRB AST STL BLK  TO  PF
1 3.9 5.0 7.5 2.2 1.3 3.4 2.3
2 6.3 7.6 7.2 1.7 1.1 3.0 1.7
3 4.1 5.2 4.9 1.5 0.5 2.6 2.3
```

Heatmap
====================================
為了做圖，將寬表轉長表

```r
library(tidyr) 
#寬表轉長表,以名字作依據
nba.m <- pivot_longer(nba,col = -"Name",names_to="Feature") 
head(nba.m,5)
```

|Name        |Feature | value|
|:-----------|:-------|-----:|
|Dwyane Wade |G       |  79.0|
|Dwyane Wade |MIN     |  38.6|
|Dwyane Wade |PTS     |  30.2|
|Dwyane Wade |FGM     |  10.8|
|Dwyane Wade |FGA     |  22.0|

geom_tile()
====================================
將Geometric objects指定為`geom_tile()`

```r
library(ggplot2) #for ggplot()
ggplot(nba.m, aes(Feature, Name)) + 
    geom_tile(aes(fill = value),
              colour = "white")+ 
    scale_fill_gradient(
        low = "white",high = "steelblue") 
```

![plot of chunk unnamed-chunk-37](EMBA_PipelinesForDataAnalysisInR3-figure/unnamed-chunk-37-1.png)

geom_tile() + scale()
====================================
- 因為G欄資料明顯大於其他欄位，導致顏色差異不明顯
- 將個欄位的資料標準化處理


```r
#scale處理
library(dplyr)
nba.s<-nba %>% 
    mutate_each(funs(scale), -Name) 
head(nba.s,2)
```

|Name         |         G|       MIN|      PTS|      FGM|      FGA|       FGP|      FTM|      FTA|        FTP|       X3PM|      X3PA|        X3PP|         ORB|        DRB|        TRB|      AST|      STL|       BLK|       TO|         PF|
|:------------|---------:|---------:|--------:|--------:|--------:|---------:|--------:|--------:|----------:|----------:|---------:|-----------:|-----------:|----------:|----------:|--------:|--------:|---------:|--------:|----------:|
|Dwyane Wade  | 0.6179300| 1.0019702| 3.179941| 2.920022| 2.596832| 0.5136017| 1.917475| 2.110772| -0.7401673| -0.1080044| 0.1303647| -0.15749098| -0.27213551| -0.3465676| -0.3287465| 1.652247| 2.558238| 1.2064646| 1.790445| -0.2984568|
|LeBron James | 0.7693834| 0.6119299| 2.566974| 1.957185| 1.697237| 0.4649190| 1.778729| 1.896589| -0.5233214|  0.4920201| 0.6971679|  0.02738974| -0.06117775|  1.0080940|  0.6605370| 1.516147| 1.367252| 0.8627425| 1.059651| -1.3903719|

geom_tile() + scale()
====================================

```r
nba.s.m <- pivot_longer(nba.s,col = -"Name",names_to="Feature") 
ggplot(nba.s.m, aes(Feature, Name)) + 
    geom_tile(aes(fill = value),
              colour = "white")+ 
    scale_fill_gradient(
        low = "white",high = "steelblue") 
```

![plot of chunk unnamed-chunk-40](EMBA_PipelinesForDataAnalysisInR3-figure/unnamed-chunk-40-1.png)

[How to Make a Heatmap – a Quick and Easy Solution](http://flowingdata.com/2010/01/21/how-to-make-a-heatmap-a-quick-and-easy-solution/)

Heatmap 練習 
====================================
type:alert
incremental:true
- 參考[WSJ Battling Infectious Diseases in the 20th Century](http://graphics.wsj.com/infectious-diseases-and-vaccines/)
- 下載[小兒麻痺發生率](https://raw.githubusercontent.com/CGUIM-BigDataAnalysis/BigDataCGUIM/master/104/POLIO_Incidence.csv)資料
- 將資料載入R
- 表格是寬表，需要轉成長表
- 有缺值 （-），用NA取代
    - 方法一 gsub()
    - 方法二 ifelse()
- 發生率欄位轉換成數值
    - as.numeric()
- 用年份當x軸，州名當y軸，區塊顏色用盛行率填入
    - low = "white",high = "steelblue"

Treemap
====================================
type:sub-section 
- Treemap(矩形式樹狀結構繪圖法)
- 以二維平面的方式展示包含階層結構（hierarchical）形式的統計資訊
- `treemap` packages

treemap() data
====================================

```r
library(treemap)
data(GNI2014)
knitr::kable(head(GNI2014))
```



|   |iso3 |country          |continent     | population|    GNI|
|:--|:----|:----------------|:-------------|----------:|------:|
|3  |BMU  |Bermuda          |North America |      67837| 106140|
|4  |NOR  |Norway           |Europe        |    4676305| 103630|
|5  |QAT  |Qatar            |Asia          |     833285|  92200|
|6  |CHE  |Switzerland      |Europe        |    7604467|  88120|
|7  |MAC  |Macao SAR, China |Asia          |     559846|  76270|
|8  |LUX  |Luxembourg       |Europe        |     491775|  75990|

treemap()
====================================

```r
library(treemap)
data(GNI2014)
treemap(GNI2014,
       index=c("continent", "iso3"), #分組依據
       vSize="population", #區塊大小
       vColor="GNI", #顏色深淺
       type="value")
```

![plot of chunk treemap2](EMBA_PipelinesForDataAnalysisInR3-figure/treemap2-1.png)

互動式資料呈現
====================================

- [互動式資料呈現](http://yijutseng.github.io/DataScienceRBook/InteractiveGraphics.html)
- [ggvis](http://yijutseng.github.io/DataScienceRBook/InteractiveGraphics.html#ggvis)
- [googleVis](http://yijutseng.github.io/DataScienceRBook/InteractiveGraphics.html#googlevis)
- [Plot.ly](http://yijutseng.github.io/DataScienceRBook/InteractiveGraphics.html#plot.ly)

參考資料
====================================
type:sub-section 

- 官方網站[文件](http://docs.ggplot2.org/current/)
- RStudio製作的[ggplot cheat sheet](https://www.rstudio.com/wp-content/uploads/2016/11/ggplot2-cheatsheet-2.1.pdf)
- DataCamp課程1 [Data Visualization with ggplot2 (Part 1)](https://www.datacamp.com/courses/data-visualization-with-ggplot2-1)
- DataCamp課程2 [Data Visualization with ggplot2 (Part 2)](https://www.datacamp.com/courses/data-visualization-with-ggplot2-2)
- DataCamp課程3 [Data Visualization with ggplot2 (Part 3)](https://www.datacamp.com/courses/data-visualization-with-ggplot2-3)
- [每個人心中都有一碗巷口的牛肉湯](http://tequila1979.blogspot.tw/2017/01/blog-post.html)

