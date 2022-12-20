



pacotes <- c("rgdal","raster","tmap","maptools","sf","rgeos","sp","adehabitatHR",
             "tidyverse","broom","rayshader","knitr","kableExtra","RColorBrewer",
             "profvis")

if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for(i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break()}
  sapply(pacotes, require, character = T) 
} else {
  sapply(pacotes, require, character = T) 
}




install.packages("ggmap")
install.packages("rvest")

library(tidyverse)
library(rvest)
library(magrittr)
library(ggmap)
library(stringr)
library(ggplot2)


#carregando base de dados

load('dataCluster1.RData')

#renomeado coluna dos paises 
dataCluster1MAPA<- dataCluster1
dataCluster1MAPA<-tibble::rownames_to_column(dataCluster1MAPA, "pais") 

#Renomeando paises para igualar denominação do WB
datacluster2MAPA <- dataCluster1MAPA

   datacluster2MAPA$pais[datacluster2MAPA$pais == "Aruba"] <- "Aruba (Neth.)"   
   datacluster2MAPA$pais[datacluster2MAPA$pais == "Bahamas"] <- "Bahamas, The"
   datacluster2MAPA$pais[datacluster2MAPA$pais == "Bermuda"] <- "Bermuda (UK)"  
   datacluster2MAPA$pais[datacluster2MAPA$pais == "Cayman Islands"] <- "Cayman Islands (UK)"   
   datacluster2MAPA$pais[datacluster2MAPA$pais == "Czechia"] <- "Czech Republic" 
   datacluster2MAPA$pais[datacluster2MAPA$pais == "Egypt"] <- "Egypt, Arab Republic of"    
   datacluster2MAPA$pais[datacluster2MAPA$pais == "Gambia"] <- "Gambia, The"  
   datacluster2MAPA$pais[datacluster2MAPA$pais == "Greenland"] <- "Greenland (Den.)"  
   datacluster2MAPA$pais[datacluster2MAPA$pais == "Iran (Islamic Republic of)"] <- "Iran, Islamic Republic of"   
   datacluster2MAPA$pais[datacluster2MAPA$pais == "Puerto Rico"] <- "Puerto Rico (US)"   
   datacluster2MAPA$pais[datacluster2MAPA$pais == "Republic of Korea"] <- "Korea, Republic of"    
   datacluster2MAPA$pais[datacluster2MAPA$pais == "Republic of Moldova"] <- "Moldova"  
   datacluster2MAPA$pais[datacluster2MAPA$pais == "Slovakia"] <- "Slovak Republic"  
   datacluster2MAPA$pais[datacluster2MAPA$pais == "Viet Nam"] <- "Vietnam"
  



#shapefile do world bank
shp_mundo_BK <- readOGR(dsn = "worldbank_countries", layer = "WB_countries_Admin0_10m")

#realizando merge dos dados no shapefile

mapaMundo_BK <- merge(x= shp_mundo_BK,
                   y= datacluster2MAPA,
                   by.x="WB_NAME",
                   by.y="pais")

#plotando grafico espacial
tm_shape(shp = mapaMundo_BK) +
  tm_fill(col = "waste"
          , palette = "PuBu")

#saber quais são as cores disponíveis
display.brewer.all()  
#####################plot comum não está funcionando


#usando ggplot

shp_dados_novo_BK <- tidy(mapaMundo_BK, region = "WB_NAME") %>% 
  rename(WB_NAME = id) %>% 
  left_join(mapaMundo_BK@data,
            by = "WB_NAME")

#A plotagem desperdício.
shp_dados_novo_BK %>% 
  ggplot() +
  geom_polygon(aes(x = long, y = lat, group = group, fill = waste),
               color = "black", size = 0.15) +
  labs(x = "Longitude",
       y = "Latitude",
       fill = "Desperdício") +
  scale_fill_viridis_c(option = "H")+
    theme_bw()






