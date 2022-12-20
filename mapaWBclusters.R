
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


load( "tabelaCluster.K6.RData")

#renomeado coluna dos paises 
MAPA_cLusters.k6<- tabelaCluster.K6
MAPA_cLusters.k6 <- as.data.frame(MAPA_cLusters.k6)
MAPA_cLusters.k6<-tibble::rownames_to_column(MAPA_cLusters.k6, "pais") 

#adequando nomes com a base do World bank

MAPA_cLusters.k6$pais[MAPA_cLusters.k6$pais == "Aruba"] <- "Aruba (Neth.)"   
MAPA_cLusters.k6$pais[MAPA_cLusters.k6$pais == "Bahamas"] <- "Bahamas, The"
MAPA_cLusters.k6$pais[MAPA_cLusters.k6$pais == "Bermuda"] <- "Bermuda (UK)"  
MAPA_cLusters.k6$pais[MAPA_cLusters.k6$pais == "Cayman Islands"] <- "Cayman Islands (UK)"   
MAPA_cLusters.k6$pais[MAPA_cLusters.k6$pais == "Czechia"] <- "Czech Republic" 
MAPA_cLusters.k6$pais[MAPA_cLusters.k6$pais == "Egypt"] <- "Egypt, Arab Republic of"    
MAPA_cLusters.k6$pais[MAPA_cLusters.k6$pais == "Gambia"] <- "Gambia, The"  
MAPA_cLusters.k6$pais[MAPA_cLusters.k6$pais == "Greenland"] <- "Greenland (Den.)"  
MAPA_cLusters.k6$pais[MAPA_cLusters.k6$pais == "Iran (Islamic Republic of)"] <- "Iran, Islamic Republic of"   
MAPA_cLusters.k6$pais[MAPA_cLusters.k6$pais == "Puerto Rico"] <- "Puerto Rico (US)"   
MAPA_cLusters.k6$pais[MAPA_cLusters.k6$pais == "Republic of Korea"] <- "Korea, Republic of"    
MAPA_cLusters.k6$pais[MAPA_cLusters.k6$pais == "Republic of Moldova"] <- "Moldova"  
MAPA_cLusters.k6$pais[MAPA_cLusters.k6$pais == "Slovakia"] <- "Slovak Republic"  
MAPA_cLusters.k6$pais[MAPA_cLusters.k6$pais == "Viet Nam"] <- "Vietnam"


#carregando shapefile e base
shp_mundo_clusters.k6 <- readOGR(dsn = "worldbank_countries", layer = "WB_countries_Admin0_10m")


#realizando merge dos dados no shapefile

mapaMundo_cluster.k6 <- merge(x= shp_mundo_clusters.k6,
                   y= MAPA_cLusters.k6,
                   by.x="WB_NAME",
                   by.y="pais")



#usando ggplot

shp_dados_clusterk6 <- tidy(mapaMundo_cluster.k6, region = "WB_NAME") %>% 
  rename(WB_NAME = id) %>% 
  left_join(mapaMundo_cluster.k6@data,
            by = "WB_NAME")

#A plotagem desperdício.
shp_dados_clusterk6 %>% 
  ggplot() +
  geom_polygon(aes(x = long, y = lat, group = group, fill = factor(cluster)),
               color = "black") +
  labs(x = "Longitude",
       y = "Latitude",
       fill = "Clusters") +
  scale_fill_brewer(palette = "Set1") +
  theme_bw()

write.csv(MAPA_cLusters.k6, file = "tabela_k6_clusters.csv")


