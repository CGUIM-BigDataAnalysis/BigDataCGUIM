#install.packages("xml2")
library(xml2)
## farm
ProdUrl<-"https://data.coa.gov.tw/Service/OpenData/FromM/FarmTransData.aspx?FOTT=Xml"
PrdoXML<-read_xml(ProdUrl)
PrdoEle<-xml_find_all(PrdoXML,".//作物名稱")
ProdText<-xml_text(PrdoEle)
PriceEle<-xml_find_all(PrdoXML,".//平均價")
PriceText<-xml_text(PriceEle)

AnsDF<-data.frame(Name=ProdText,
                  Price=PriceText)

# Youbike
library(jsonlite)
APIURL<-"http://data.tycg.gov.tw/api/v1/rest/datastore/a1b4714b-3b75-4ff8-a8f2-cc377e4eaa0f?format=json"
APIData<-fromJSON(APIURL)
BikeData<-APIData$result$records

# Parking
ParkURL<-"https://data.tycg.gov.tw/opendata/datalist/datasetMeta/download?id=f4cc0b12-86ac-40f9-8745-885bddc18f79&rid=0daad6e6-0632-44f5-bd25-5e1de1e9146f"
ParkAPIData<-fromJSON(ParkURL)
ParkData<-ParkAPIData$parkingLots
# you can use read_json to load the data, too
test<-read_json(ParkURL)
