R Markdown and Markdown
========================================================
author: 曾意儒 Yi-Ju Tseng
autosize: true
font-family: 'Microsoft JhengHei'

R Markdown
========================================================
![plot of chunk unnamed-chunk-1](figures/bandThree2.png)

投影片和書都是以R Markdown為基礎編寫而成

R Markdown
========================================================
- 用來"溝通"：資料分析的最後一步
- 包含**程式碼**與**分析結果**，可與其他資料科學家分享
- 可重現分析結果的文件 （分析/實驗再現性高）
- 支援各種輸出格式：Slides, PDF, HTML. Word,…

R Markdown
========================================================
- http://rmarkdown.rstudio.com/
- R + Markdown (基於Markdown文件)
- 所有寫在**R Code Chunks**的R程式碼都會執行，並將結果輸出
- 輸出選擇：
    - 文件：HTML, PDF, Word
    - 投影片：HTML, PDF
    - Shiny
    - 模板：放上GitHub使用的.md檔


R Markdown - New File
========================================================
![plot of chunk unnamed-chunk-2](figures/RM.png)

R Markdown - 輸出文件
========================================================
![plot of chunk unnamed-chunk-3](figures/RMDoc.png)

R Markdown - 輸出投影片
========================================================
![plot of chunk unnamed-chunk-4](figures/RMPre.png)

R Markdown - 輸出模板（GitHub）
========================================================
![plot of chunk unnamed-chunk-5](figures/RMTem.png)


R Markdown & Markdown 
========================================================
**R Markdown** (.Rmd) —knitr—> **Markdown** (.md)

**Markdown** (.md) —markdown—> **HTML**

邊寫完.Rmd檔後，按下**knit**按鈕，輸出PDF/HTML/Markdown

Markdown 基本語言
========================================================
Heading

- `#`
- `##`
- `###`

List
- `-`
    - `(tab)-`
    
Markdown 基本語言
========================================================

圖
- `![alt text](http://example.com/logo.png)`

連結
- `[website name](url)`


R Markdown @RStudio
========================================================
Step 1 開啟新的R Markdown 檔案

![plot of chunk unnamed-chunk-6](figures/RM.png)

R Markdown @RStudio
========================================================
Step 2 設定輸出格式

最後要放上GitHub，所以選From Template裡的GitHub Document

![plot of chunk unnamed-chunk-7](figures/RMTem.png)

R Markdown @RStudio
========================================================
Step 3 設定文件基本資訊

title: "Untitled"

output: github_document

![plot of chunk unnamed-chunk-8](figures/RMMD.png)

R Code Chunk的參數
========================================================

- eval：要不要**執行並顯示**在輸出的Markdown檔案內
  - T：執行+顯示
  - F：只顯示，不執行
- echo：要不要**顯示程式碼**(不顯示程式碼仍會執行，但只顯示執行結果)
  - T：執行+顯示
  - F：不顯示程式碼，只執行，並顯示結果
- warning, error, message：要不要顯示錯誤訊息
  - T：顯示
  - F：不顯示
- cache：是否要暫存結果

Table
========================================================

若需要輸出表格，預設的輸出方式如下：

```r
mtcars[1:5, 1:5]
```

```
                   mpg cyl disp  hp drat
Mazda RX4         21.0   6  160 110 3.90
Mazda RX4 Wag     21.0   6  160 110 3.90
Datsun 710        22.8   4  108  93 3.85
Hornet 4 Drive    21.4   6  258 110 3.08
Hornet Sportabout 18.7   8  360 175 3.15
```

Table (knitr::kable)
========================================================

如果想要呈現的更清楚，建議使用**knitr::kable**

```r
knitr::kable(
  mtcars[1:5, 1:5], caption = "A knitr kable."
)
```



|                  |  mpg| cyl| disp|  hp| drat|
|:-----------------|----:|---:|----:|---:|----:|
|Mazda RX4         | 21.0|   6|  160| 110| 3.90|
|Mazda RX4 Wag     | 21.0|   6|  160| 110| 3.90|
|Datsun 710        | 22.8|   4|  108|  93| 3.85|
|Hornet 4 Drive    | 21.4|   6|  258| 110| 3.08|
|Hornet Sportabout | 18.7|   8|  360| 175| 3.15|


