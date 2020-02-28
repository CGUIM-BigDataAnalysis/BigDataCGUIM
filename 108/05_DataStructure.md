資料結構
========================================================
author: 曾意儒 Yi-Ju Tseng
autosize: true
font-family: 'Microsoft JhengHei'

對應書本章節
========================================================
[2 R 資料結構](http://yijutseng.github.io/DataScienceRBook/RDataStructure.html)

大綱
========================================================
- 向量 Vector
- 因子 Factor
- 列表 List
- 矩陣 Matrix
- 資料框 data.frame
- 資料表 data.table
- 屬性查詢函數 

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

向量元素之資料型態必須相同
========================================================
- 在同一向量中，所有元素之**資料型態必須相同**
- 上述`vec`向量，元素均為文字型態
- 若放不同類別的資料進同一個向量，資料型態會被自動轉為相同

```r
a<-c(TRUE, "a",1)
str(a)
```

```
 chr [1:3] "TRUE" "a" "1"
```

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

產生向量函數 seq()函數
========================================================   


```r
seq(from=1,to=20,by=1) ##1~20，中間相隔1
```

```
 [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
```

```r
seq(from=1,to=50,by=2) ##1~50，中間相隔2
```

```
 [1]  1  3  5  7  9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45
[24] 47 49
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

向量運算練習
====================================
type:alert
incremental:true

- a向量為1到6連續數字
- b向量是3到5的連續數字
- a+b =?

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
[1] 大學生     碩士班學生 博士班學生
Levels: 大學生 碩士班學生 博士班學生
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
[1] "小明" "大雄" "胖虎" "小新" "大白"
```

列表資料編輯設定
======================================================== 
列表資料也能用`$`符號與`<-`變數設定符號新增

```r
listSample$Gender<-c("M","F","M","F","M") ##新增Gender變量，並設定向量值
```

列表list資料編輯練習
====================================
type:alert
incremental:true

- 依投影片，新增listSample列表
- 發現學校名稱打錯了，應該是CGUST，請改列表資料
- 在列表中新增學期資料，並設定為上學期


列表資料名稱修改
======================================================== 
列表資料的名稱修改可考慮搭配`names()`函數與向量元素修改

```r
#檢查原本的名字
names(listSample) #original name
```

```
[1] "Students" "Year"     "Score"    "School"   "Gender"  
```

```r
#將第一個名字改成NewName
names(listSample)[1]<-"NewName"
#檢查新的名字
names(listSample) #modified name
```

```
[1] "NewName" "Year"    "Score"   "School"  "Gender" 
```


列表資料中的向量也可新增元素
======================================================== 
把原有`listSample$Gender`的向量取出，並加上`?`，最後寫回`listSample$Gender`

```r
listSample$Gender
```

```
[1] "M" "F" "M" "F" "M"
```

```r
listSample$Gender<-c(listSample$Gender,"?")
listSample$Gender
```

```
[1] "M" "F" "M" "F" "M" "?"
```

矩陣 matrix
======================================================== 
type:sub-section

```r
a <- matrix(c(1:6), nrow=3, ncol=2) ##建立3x2的矩陣，分別填入1~6的值
a
```

```
     [,1] [,2]
[1,]    1    4
[2,]    2    5
[3,]    3    6
```

先填Column

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
  StuID name score
1     1 小明    80
2     2 大雄    60
3     3 胖虎    90
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
- 檢查欄位名稱 `colnames()`
- 檢查欄位列名，`rownames()`

***


```r
colnames(StuDF) ##欄名
```

```
[1] "StuID" "name"  "score"
```

```r
rownames(StuDF) ##列名
```

```
[1] "1" "2" "3"
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

資料框欄位刪除
====================================
若需刪除某欄位，可將欄位值設定為`NULL`

```r
iris$Species<-NULL ##刪除Species欄位
head(iris)
```

```
  Sepal.Length Sepal.Width Petal.Length Petal.Width
1          5.1         3.5          1.4         0.2
2          4.9         3.0          1.4         0.2
3          4.7         3.2          1.3         0.2
4          4.6         3.1          1.5         0.2
5          5.0         3.6          1.4         0.2
6          5.4         3.9          1.7         0.4
```

資料表 data.table
======================================================== 
type:sub-section
- data.frame資料框型別的延伸
- 需安裝**data.table** package
- 讀取大型資料的速度快上數倍
- 進階處理語言
- **探索式資料分析**再介紹


資料屬性查詢函數
======================================================== 
type:sub-section

資料屬性可透過下列函數查詢:
- 名稱 `names()`
- 各維度名稱 `dimnames()`
- 長度 `length()`
- 各維度長度 `dim()`
- 資料型態 `class()`
- 各類資料計數 `table()`
- 總覽資料 `str()`

names()函數
======================================================== 
取得各種資料之名稱

```r
head(islands) ##R內建的資料
```

```
      Africa   Antarctica         Asia    Australia Axel Heiberg 
       11506         5500        16988         2968           16 
      Baffin 
         184 
```

```r
head(names(islands)) ##顯示上述資料之資料名稱
```

```
[1] "Africa"       "Antarctica"   "Asia"         "Australia"   
[5] "Axel Heiberg" "Baffin"      
```

names()函數
======================================================== 
若為資料框，則會顯示行（欄位）名稱

```r
head(USArrests) ##R內建的資料
```

```
           Murder Assault UrbanPop Rape
Alabama      13.2     236       58 21.2
Alaska       10.0     263       48 44.5
Arizona       8.1     294       80 31.0
Arkansas      8.8     190       50 19.5
California    9.0     276       91 40.6
Colorado      7.9     204       78 38.7
```

```r
head(names(USArrests)) ##顯示上述資料之資料名稱
```

```
[1] "Murder"   "Assault"  "UrbanPop" "Rape"    
```

dimnames()
======================================================== 
透過`dimnames()`函數可顯示資料框列與行的名稱，先顯示列**[[1]]**，再顯示行**[[2]]**

```r
dimnames(USArrests) 
```

```
[[1]]
 [1] "Alabama"        "Alaska"         "Arizona"        "Arkansas"      
 [5] "California"     "Colorado"       "Connecticut"    "Delaware"      
 [9] "Florida"        "Georgia"        "Hawaii"         "Idaho"         
[13] "Illinois"       "Indiana"        "Iowa"           "Kansas"        
[17] "Kentucky"       "Louisiana"      "Maine"          "Maryland"      
[21] "Massachusetts"  "Michigan"       "Minnesota"      "Mississippi"   
[25] "Missouri"       "Montana"        "Nebraska"       "Nevada"        
[29] "New Hampshire"  "New Jersey"     "New Mexico"     "New York"      
[33] "North Carolina" "North Dakota"   "Ohio"           "Oklahoma"      
[37] "Oregon"         "Pennsylvania"   "Rhode Island"   "South Carolina"
[41] "South Dakota"   "Tennessee"      "Texas"          "Utah"          
[45] "Vermont"        "Virginia"       "Washington"     "West Virginia" 
[49] "Wisconsin"      "Wyoming"       

[[2]]
[1] "Murder"   "Assault"  "UrbanPop" "Rape"    
```

length()
======================================================== 
透過`length()`函數可顯示資料長度，包括向量與資料框，若資料行態為資料框，則會顯示行（欄位）數

```r
length(islands) 
```

```
[1] 48
```

```r
length(USArrests) 
```

```
[1] 4
```

dim()
======================================================== 
透過`dim()`函數可顯示資料框列與行的長度，與`dimnames()`相同，先顯示列，後顯示行

```r
dim(USArrests) 
```

```
[1] 50  4
```

class()
======================================================== 
使用`class()`函數可知道變數類別

```r
class(1)
```

```
[1] "numeric"
```

```r
class("Test")
```

```
[1] "character"
```

```r
class(Sys.Date())
```

```
[1] "Date"
```

table()
======================================================== 
使用`table()`函數可知道向量中每個值出現幾次

```r
iris$Species[1:10] ##原始值，印出第1~10個元素
```

```
NULL
```

```r
table(iris$Species) ##統計結果
```

```
< table of extent 0 >
```

str()
======================================================== 
使用`str()`函數可總覽變數資訊

```r
str(USArrests)
```

```
'data.frame':	50 obs. of  4 variables:
 $ Murder  : num  13.2 10 8.1 8.8 9 7.9 3.3 5.9 15.4 17.4 ...
 $ Assault : int  236 263 294 190 276 204 110 238 335 211 ...
 $ UrbanPop: int  58 48 80 50 91 78 77 72 80 60 ...
 $ Rape    : num  21.2 44.5 31 19.5 40.6 38.7 11.1 15.8 31.9 25.8 ...
```

str()
======================================================== 
使用`str()`函數可總覽變數資訊

```r
str(listSample)
```

```
List of 5
 $ NewName: chr [1:5] "小明" "大雄" "胖虎" "小新" ...
 $ Year   : num 2017
 $ Score  : num [1:4] 60 50 80 40
 $ School : chr "CGU"
 $ Gender : chr [1:6] "M" "F" "M" "F" ...
```


資料探索練習
====================================
type:alert
incremental:true

- R的內建資料集**airquality**內有幾筆觀察值？每筆觀察值內有幾個變數？
- R的內建資料集**airquality**裡面的**Month**變數中，各月份出現的次數是多少？
