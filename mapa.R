
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



#carregando shapefile e base
shp_mundo <- readOGR(dsn = "shapefile_mundo", layer = "mundo")


#realizando merge dos dados no shapefile

mapaMundo <- merge(x= shp_mundo,
                   y= dataCluster1MAPA,
                   by.x="name",
                   by.y="pais")

#plotando grafico espacial
tm_shape(shp = mapaMundo) +
  tm_fill(col = "waste"
          , palette = "PuBu")

#saber quais são as cores disponíveis
display.brewer.all()  
  
  

#usando ggplot

shp_dados_novo <- tidy(mapaMundo, region = "name") %>% 
  rename(name = id) %>% 
  left_join(mapaMundo@data,
            by = "name")

#A plotagem desperdício.
shp_dados_novo %>% 
  ggplot() +
  geom_polygon(aes(x = long, y = lat, group = group, fill = waste),
               color = "black") +
  labs(x = "Longitude",
       y = "Latitude",
       fill = "Desperdício") +
   scale_fill_viridis_c(option = "C") +
  theme_bw()


#####verificando

tabelaPol <- tidy(shp_mundo)
comparando <-  merge(x= tabelaPol,
                     y= dataCluster1MAPA,
                     by.x="name",
                     by.y="pais") 

tabelamapa <- as.data.frame(mapaMundo)
tabelamapaOmit <- na.omit(tabelamapa)
view(tabelamapaOmit)
tabelaOrdenada <- tabelamapa[order(tabelamapa$waste),]

MAPAXLS <- as.data.frame(shp_mundo) 
write.csv(MAPAXLS, file = "MAPAXLS.csv")
BASEORIGINAL <- write.csv(dataCluster1, file = "BASEORIGINAL.csv")
