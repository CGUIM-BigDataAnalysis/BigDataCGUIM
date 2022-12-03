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

