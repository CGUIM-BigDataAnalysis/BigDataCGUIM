結巴分詞使用範例
================
曾意儒 Yi-Ju Tseng
2017/04/09

有關結巴
--------

[“结巴”中文分词：做最好的 Python 中文分词组件](https://github.com/fxsjy/jieba)

在R內使用結巴分詞
-----------------

### 安裝載入套件

安裝套件

``` r
install.packages("jiebaR")
```

載入套件

``` r
library(jiebaR) #載入jiebaR package
```

    ## Loading required package: jiebaRD

### 斷詞

新增斷詞工具

``` r
cutter <- worker()
cutter 
```

    ## Worker Type:  Jieba Segment
    ## 
    ## Default Method  :  mix
    ## Detect Encoding :  TRUE
    ## Default Encoding:  UTF-8
    ## Keep Symbols    :  FALSE
    ## Output Path     :  
    ## Write File      :  TRUE
    ## By Lines        :  FALSE
    ## Max Word Length :  20
    ## Max Read Lines  :  1e+05
    ## 
    ## Fixed Model Components:  
    ## 
    ## $dict
    ## [1] "/Library/Frameworks/R.framework/Versions/3.3/Resources/library/jiebaRD/dict/jieba.dict.utf8"
    ## 
    ## $user
    ## [1] "/Library/Frameworks/R.framework/Versions/3.3/Resources/library/jiebaRD/dict/user.dict.utf8"
    ## 
    ## $hmm
    ## [1] "/Library/Frameworks/R.framework/Versions/3.3/Resources/library/jiebaRD/dict/hmm_model.utf8"
    ## 
    ## $stop_word
    ## NULL
    ## 
    ## $user_weight
    ## [1] "max"
    ## 
    ## $timestamp
    ## [1] 1491757818
    ## 
    ## $default $detect $encoding $symbol $output $write $lines $bylines can be reset.

斷詞實作

``` r
cutter["這是一段測試用文字，請不要再戰長庚資管了"]
```

    ##  [1] "這是" "一段" "測試" "用"   "文字" "請"   "不要" "再戰" "長庚" "資管"
    ## [11] "了"

### 詞性判別

``` r
tagger <- worker("tag")
tagger["這是一段測試用文字，請不要再戰長庚資管了"]
```

    ##      x      m     vn      p      n     zg     df      v    nrt      x 
    ## "這是" "一段" "測試"   "用" "文字"   "請" "不要" "再戰" "長庚" "資管" 
    ##     ul 
    ##   "了"

### 新增自訂詞彙

``` r
new_user_word(cutter,'長庚資管',"n")
```

    ## [1] TRUE

``` r
cutter["這是一段測試用文字，請不要再戰長庚資管了"]
```

    ##  [1] "這是"     "一段"     "測試"     "用"       "文字"     "請"      
    ##  [7] "不要"     "再戰"     "長庚資管" "了"

### 自訂停止詞

``` r
readLines("stop.txt")
```

    ## Warning in readLines("stop.txt"): incomplete final line found on 'stop.txt'

    ## [1] "請"

``` r
cutter = worker(stop_word ="stop.txt")
cutter["這是一段測試用文字，請不要再戰長庚資管了"]
```

    ##  [1] "這是" "一段" "測試" "用"   "文字" "不要" "再戰" "長庚" "資管" "了"

操作範例
--------

### 載入需要做分詞的資料

``` r
library(rvest)
```

    ## Loading required package: xml2

``` r
PTTNBA<-"https://www.ptt.cc/bbs/NBA/index4671.html"
pttContent<-read_html(PTTNBA)
post_title <- pttContent %>% html_nodes(".title") %>% html_text()
post_title
```

    ##  [1] "\n\t\t\t\n\t\t\t\t[情報] 波波：不再輪休，是時候進入季後賽模式了\n\t\t\t\n\t\t\t" 
    ##  [2] "\n\t\t\t\n\t\t\t\t(本文已被刪除) [dragon803]\n\t\t\t\n\t\t\t"                    
    ##  [3] "\n\t\t\t\n\t\t\t\t[情報] Lillard本日個人得分佔全隊58.42%\n\t\t\t\n\t\t\t"        
    ##  [4] "\n\t\t\t\n\t\t\t\t[情報] TODAY\n\t\t\t\n\t\t\t"                                  
    ##  [5] "\n\t\t\t\n\t\t\t\t[討論] 雷霆當年如果留哈登會奪冠嗎\n\t\t\t\n\t\t\t"             
    ##  [6] "\n\t\t\t\n\t\t\t\t[外絮] Lillard賽後將比賽用球送給J. Johnson\n\t\t\t\n\t\t\t"    
    ##  [7] "\n\t\t\t\n\t\t\t\t[情報] NBA Standing(2017.4.9)\n\t\t\t\n\t\t\t"                 
    ##  [8] "\n\t\t\t\n\t\t\t\t[花邊] 因應輪休爭議 聯盟宣布下季賽程延長1週\n\t\t\t\n\t\t\t"   
    ##  [9] "\n\t\t\t\n\t\t\t\t[討論] 球員會想拿MVP還是拿新的獎\n\t\t\t\n\t\t\t"              
    ## [10] "\n\t\t\t\n\t\t\t\t[情報] 打鐵積分 排行榜\n\t\t\t\n\t\t\t"                        
    ## [11] "\n\t\t\t\n\t\t\t\t[討論] NBA是最愛輪休的職業運動嗎？\n\t\t\t\n\t\t\t"            
    ## [12] "\n\t\t\t\n\t\t\t\t[情報] ★今日排名(2017.04.09)★\n\t\t\t\n\t\t\t"                 
    ## [13] "\n\t\t\t\n\t\t\t\t[討論] 買飯型球員在主客場的差異?\n\t\t\t\n\t\t\t"              
    ## [14] "\n\t\t\t\n\t\t\t\tRe: [討論] 雷霆當年如果留哈登會奪冠嗎\n\t\t\t\n\t\t\t"         
    ## [15] "\n\t\t\t\n\t\t\t\t[討論] 灰狼打湖人到底誰會坦\n\t\t\t\n\t\t\t"                   
    ## [16] "\n\t\t\t\n\t\t\t\t[新聞] 籃網主場關門戰 林書豪難得半裸露肌肉\n\t\t\t\n\t\t\t"    
    ## [17] "\n\t\t\t\n\t\t\t\t[新聞] 希臘怪物雙十領軍 公鹿收下季後賽門票\n\t\t\t\n\t\t\t"    
    ## [18] "\n\t\t\t\n\t\t\t\t[討論] 勇士跟拓荒對戰\n\t\t\t\n\t\t\t"                         
    ## [19] "\n\t\t\t\n\t\t\t\t[新聞] 膝傷未癒恐成未爆彈？ 騎士厄文坦言近況遭\n\t\t\t\n\t\t\t"
    ## [20] "\n\t\t\t\n\t\t\t\t緯來賽後音樂\n\t\t\t\n\t\t\t"

### 斷詞

``` r
cutter <- worker()
cutter[post_title] ## 不分行輸出
```

    ##   [1] "情報"       "波波"       "不再"       "輪休"       "是"        
    ##   [6] "時候"       "進入"       "季後賽"     "模式"       "了"        
    ##  [11] "本文"       "已"         "被"         "刪除"       "dragon803" 
    ##  [16] "情報"       "Lillard"    "本日"       "個人"       "得分"      
    ##  [21] "佔"         "全隊"       "58.42"      "情報"       "TODAY"     
    ##  [26] "討論"       "雷霆"       "當年"       "如果"       "留"        
    ##  [31] "哈登"       "會"         "奪冠"       "嗎"         "外絮"      
    ##  [36] "Lillard"    "賽後"       "將"         "比賽"       "用球"      
    ##  [41] "送給"       "J"          "Johnson"    "情報"       "NBA"       
    ##  [46] "Standing"   "2017.4.9"   "花邊"       "因應"       "輪休"      
    ##  [51] "爭議"       "聯盟"       "宣布"       "下季"       "賽程"      
    ##  [56] "延長"       "1"          "週"         "討論"       "球員"      
    ##  [61] "會想"       "拿"         "MVP"        "還是"       "拿"        
    ##  [66] "新的獎"     "情報"       "打鐵"       "積分"       "排行榜"    
    ##  [71] "討論"       "NBA"        "是"         "最愛"       "輪休"      
    ##  [76] "的"         "職業"       "運動"       "嗎"         "情報"      
    ##  [81] "今日"       "排名"       "2017.04.09" "討論"       "買飯"      
    ##  [86] "型"         "球員"       "在"         "主客場"     "的"        
    ##  [91] "差異"       "Re"         "討論"       "雷霆"       "當年"      
    ##  [96] "如果"       "留"         "哈登"       "會"         "奪冠"      
    ## [101] "嗎"         "討論"       "灰狼"       "打湖"       "人"        
    ## [106] "到底"       "誰"         "會坦"       "新聞"       "籃網"      
    ## [111] "主場"       "關門"       "戰"         "林書豪"     "難得"      
    ## [116] "半"         "裸露"       "肌肉"       "新聞"       "希臘"      
    ## [121] "怪物"       "雙十"       "領軍"       "公鹿"       "收下"      
    ## [126] "季後賽"     "門票"       "討論"       "勇士"       "跟"        
    ## [131] "拓荒"       "對戰"       "新聞"       "膝傷"       "未"        
    ## [136] "癒"         "恐成"       "未"         "爆彈"       "騎士"      
    ## [141] "厄文"       "坦言"       "近況"       "遭"         "緯來"      
    ## [146] "賽後"       "音樂"

``` r
cutter$bylines<-T
cutter[post_title] ## 分行輸出
```

    ## [[1]]
    ##  [1] "情報"   "波波"   "不再"   "輪休"   "是"     "時候"   "進入"  
    ##  [8] "季後賽" "模式"   "了"    
    ## 
    ## [[2]]
    ## [1] "本文"      "已"        "被"        "刪除"      "dragon803"
    ## 
    ## [[3]]
    ## [1] "情報"    "Lillard" "本日"    "個人"    "得分"    "佔"      "全隊"   
    ## [8] "58.42"  
    ## 
    ## [[4]]
    ## [1] "情報"  "TODAY"
    ## 
    ## [[5]]
    ## [1] "討論" "雷霆" "當年" "如果" "留"   "哈登" "會"   "奪冠" "嗎"  
    ## 
    ## [[6]]
    ## [1] "外絮"    "Lillard" "賽後"    "將"      "比賽"    "用球"    "送給"   
    ## [8] "J"       "Johnson"
    ## 
    ## [[7]]
    ## [1] "情報"     "NBA"      "Standing" "2017.4.9"
    ## 
    ## [[8]]
    ##  [1] "花邊" "因應" "輪休" "爭議" "聯盟" "宣布" "下季" "賽程" "延長" "1"   
    ## [11] "週"  
    ## 
    ## [[9]]
    ## [1] "討論"   "球員"   "會想"   "拿"     "MVP"    "還是"   "拿"     "新的獎"
    ## 
    ## [[10]]
    ## [1] "情報"   "打鐵"   "積分"   "排行榜"
    ## 
    ## [[11]]
    ## [1] "討論" "NBA"  "是"   "最愛" "輪休" "的"   "職業" "運動" "嗎"  
    ## 
    ## [[12]]
    ## [1] "情報"       "今日"       "排名"       "2017.04.09"
    ## 
    ## [[13]]
    ## [1] "討論"   "買飯"   "型"     "球員"   "在"     "主客場" "的"     "差異"  
    ## 
    ## [[14]]
    ##  [1] "Re"   "討論" "雷霆" "當年" "如果" "留"   "哈登" "會"   "奪冠" "嗎"  
    ## 
    ## [[15]]
    ## [1] "討論" "灰狼" "打湖" "人"   "到底" "誰"   "會坦"
    ## 
    ## [[16]]
    ##  [1] "新聞"   "籃網"   "主場"   "關門"   "戰"     "林書豪" "難得"  
    ##  [8] "半"     "裸露"   "肌肉"  
    ## 
    ## [[17]]
    ## [1] "新聞"   "希臘"   "怪物"   "雙十"   "領軍"   "公鹿"   "收下"   "季後賽"
    ## [9] "門票"  
    ## 
    ## [[18]]
    ## [1] "討論" "勇士" "跟"   "拓荒" "對戰"
    ## 
    ## [[19]]
    ##  [1] "新聞" "膝傷" "未"   "癒"   "恐成" "未"   "爆彈" "騎士" "厄文" "坦言"
    ## [11] "近況" "遭"  
    ## 
    ## [[20]]
    ## [1] "緯來" "賽後" "音樂"

### 分析斷詞後最常出現的詞彙

``` r
cutter <- worker()
sort(table(cutter[post_title]),decreasing = T)
```

    ## 
    ##       討論       情報         嗎       新聞       輪休    Lillard 
    ##          7          6          3          3          3          2 
    ##        NBA       哈登       奪冠       如果     季後賽         拿 
    ##          2          2          2          2          2          2 
    ##         是         會         未       球員         留       當年 
    ##          2          2          2          2          2          2 
    ##         的       賽後       雷霆          1 2017.04.09   2017.4.9 
    ##          2          2          2          1          1          1 
    ##      58.42  dragon803          J    Johnson        MVP         Re 
    ##          1          1          1          1          1          1 
    ##   Standing      TODAY       下季       不再       主場     主客場 
    ##          1          1          1          1          1          1 
    ##         了         人       今日         佔       個人       全隊 
    ##          1          1          1          1          1          1 
    ##       公鹿       最愛       刪除       到底       勇士         半 
    ##          1          1          1          1          1          1 
    ##       厄文       因應         在       坦言         型       外絮 
    ##          1          1          1          1          1          1 
    ##       宣布         將       對戰       差異         已       希臘 
    ##          1          1          1          1          1          1 
    ##       延長       得分       怪物       恐成         戰       打湖 
    ##          1          1          1          1          1          1 
    ##       打鐵       拓荒       排名     排行榜       收下     新的獎 
    ##          1          1          1          1          1          1 
    ##       時候       會坦       會想       本文       本日     林書豪 
    ##          1          1          1          1          1          1 
    ##       模式       比賽       波波       灰狼       爆彈       爭議 
    ##          1          1          1          1          1          1 
    ##       用球         癒       積分       籃網       緯來       聯盟 
    ##          1          1          1          1          1          1 
    ##       職業       肌肉       膝傷       花邊         被       裸露 
    ##          1          1          1          1          1          1 
    ##         誰       買飯       賽程         跟       近況       送給 
    ##          1          1          1          1          1          1 
    ##         週       進入       運動         遭       還是       門票 
    ##          1          1          1          1          1          1 
    ##       關門       雙十       難得       音樂       領軍       騎士 
    ##          1          1          1          1          1          1

參考資料
--------

-   [jiebaR GitHub](https://github.com/qinwf/jiebaR)
-   [jiebaR 使用指南](http://qinwenfeng.com/jiebaR/)
-   [用結巴斷詞實作文字視覺化 — 以 2016 總統就職演講為例](http://blog.infographics.tw/2016/05/text-visualization-with-jieba/)
