library(readr)

read_csv("~/Desktop/f_lvr_land_a.csv")


f_lvr_land_a <- 
  read_csv("~/Desktop/f_lvr_land_a.csv")

View(f_lvr_land_a)

f_lvr_land_a


library(xml2)
AQIURL<-"https://data.epa.gov.tw/api/v1/aqx_p_432?limit=1000&api_key=9be7b239-557b-4c10-9775-78cadfc555e9&format=xml"
AQIXML <- read_xml(AQIURL)
code_name_xml<-xml_find_all(AQIXML, ".//SiteName")
code_name<-xml_text(code_name_xml)
code_name[1:10]

# Quiz
FmURL<-"https://data.coa.gov.tw/Service/OpenData/FromM/FarmTransData.aspx?FOTT=Xml"
# Step 1. Load url to R
FmXML <- read_xml(FmURL)
#mac
# Step 2. Find "The Tag" - product name
# <product name>xxxx</product name>
# <product name>yyyy</product name>
# <product name>zzzz</product name>
prod_xml<-xml_find_all(FmXML, ".//作物名稱")
# Step 3. Clean the data
# xxxx, yyyy, zzzz
xml_text(prod_xml)
# Step 2. Find "The Tag" - price
price_xml<-xml_find_all(FmXML, ".//平均價")
# Step 3. Clean the data
xml_text(price_xml)

#windows
# ".//作物名稱" -> iconv(".//作物名稱","big-5","utf-8")
prod_xml<-
  xml_find_all(FmXML, iconv(".//作物名稱","big-5","utf-8"))
xml_text(prod_xml)


library(jsonlite)
APIData<-fromJSON("http://data.tycg.gov.tw/api/v1/rest/datastore/a1b4714b-3b75-4ff8-a8f2-cc377e4eaa0f?format=json")
FinalData<-APIData$result$records


#Quiz
library(jsonlite)
AQIJSON<-fromJSON("https://data.epa.gov.tw/api/v1/aqx_p_432?limit=1000&api_key=9be7b239-557b-4c10-9775-78cadfc555e9&format=json")
str(AQIJSON)
FinalAQI<-AQIJSON$records
# 84 obs, 25 variables
str(FinalAQI)
skimr::skim(FinalAQI)

# web scraping


