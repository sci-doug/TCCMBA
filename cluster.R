
#pacotes
library(tidyverse) #pacote para manipulacao de dados
library(cluster) #algoritmo de cluster
library(dendextend) #compara dendogramas
library(factoextra) #algoritmo de cluster e visualizacao
library(fpc) #algoritmo de cluster e visualizacao
library(gridExtra) #para a funcao grid arrange
library(readxl)




#excluindo colunas para o cluster
cbase_house <- new_base_dados_house[,-c(1,2)]
cbase_house$`Confidence in estimate` <- NULL



#transformando em dataframe

cbase_house<- as.data.frame(cbase_house)

#excluindo valores não válidos
cbase_house <- arrange(cbase_house, desc(cbase_house$`Household estimate (kg/capita/year)`))
cbase_house <- cbase_house[-c(216:236),]


#passando nome dos países para observações
rownames(cbase_house) <- cbase_house[,1] # pegando info da coluna um e copiando
cbase_house <- cbase_house[,-1] #excluindo

#Transformando dados em numérico

cbase_house <- cbase_house %>% mutate_at(c(1, 2), as.numeric)

#CALCULANDO MATRIZ DE DISTANCIAS
d <- dist(cbase_house, method = "euclidean")
d

#DEFININDO O CLUSTER A PARTIR DO METODO ESCOLHIDO
#metodos disponiveis "average", "single", "complete" e "ward.D"
hc1 <- hclust(d, method = "single" )
hc2 <- hclust(d, method = "complete" )
hc3 <- hclust(d, method = "average" )
hc4 <- hclust(d, method = "ward.D" )

#DESENHANDO O DENDOGRAMA
plot(hc1, cex = 0.6, hang = -1)
plot(hc2, cex = 0.6, hang = -1)
plot(hc3, cex = 0.6, hang = -1)
plot(hc4, cex = 0.6, hang = -1)

#BRINCANDO COM O DENDOGRAMA PARA 2 GRUPOS
rect.hclust(hc4, k = 3)

#realização de comparação 
fviz_nbclust(cbase_house, FUN = hcut, method = "wss")



############### Rodando não-hierárquico#########


#Rodar o modelo
cbase_house.k2 <- kmeans(cbase_house, centers = 2)

#Visualizar os clusters
fviz_cluster(cbase_house.k2, data = cbase_house, main = "Cluster K2")

#Criar clusters
cbase_house.k3 <- kmeans(cbase_house, centers = 3)
cbase_house.k4 <- kmeans(cbase_house, centers = 4)
cbase_house.k5 <- kmeans(cbase_house, centers = 5)

#Criar graficos
G1 <- fviz_cluster(cbase_house.k2, geom = "point", data = cbase_house) + ggtitle("k = 2")
G2 <- fviz_cluster(cbase_house.k3, geom = "point",  data = cbase_house) + ggtitle("k = 3")
G3 <- fviz_cluster(cbase_house.k4, geom = "point",  data = cbase_house) + ggtitle("k = 4")
G4 <- fviz_cluster(cbase_house.k5, geom = "point",  data = cbase_house) + ggtitle("k = 5")

#Imprimir graficos na mesma tela
grid.arrange(G1, G2, G3, G4, nrow = 2)








