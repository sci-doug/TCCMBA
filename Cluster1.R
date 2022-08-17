library(cluster)#cluster
library(factoextra) #cluster
library(fpc) #algoritmo de cluster e visualizacao
library(gridExtra) #para a funcao grid arrange

load('dataCluster1.RData')


dataCluster1 <- rename(dataCluster1, waste = 'Household estimate (kg/capita/year)',
                       PIBcapta = 'Pib per capta',
                       Escolaridade = 'escolaridade anos')

                 
dataCluster1 <- transform(dataCluster1, waste = as.numeric(waste),
                   PIBcapta = as.numeric(PIBcapta),
                   Escolaridade = as.numeric(Escolaridade)
  
)


dataCluster1 <- scale(dataCluster1)# padronizando



#### realizando o cluster


#testeando algumas opções
dataCluster1.k3 <- kmeans(dataCluster1, centers = 3)
dataCluster1.k4 <- kmeans(dataCluster1, centers = 4)
dataCluster1.k5 <- kmeans(dataCluster1, centers = 5)
dataCluster1.k6 <- kmeans(dataCluster1, centers = 6)

#Gráficos
G1 <- fviz_cluster(dataCluster1.k3, geom = "point", data = dataCluster1) + ggtitle("k = 3")
G2 <- fviz_cluster(dataCluster1.k4, geom = "point", data = dataCluster1) + ggtitle("k = 4")
G3 <- fviz_cluster(dataCluster1.k5, geom = "point", data = dataCluster1) + ggtitle("k = 5")
G4 <- fviz_cluster(dataCluster1.k6, geom = "point", data = dataCluster1) + ggtitle("k = 6")


#Criar uma matriz com 4 graficos
grid.arrange(G1, G2, G3, G4, nrow = 2)

#VERIFICANDO ELBOW 
fviz_nbclust(dataCluster1, FUN = hcut, method = "wss")
fviz_nbclust(dataCluster1, FUN = hcut, method = "silhouette")
fviz_nbclust(dataCluster1, FUN = hcut, method = "gap_stat")




####realizando cluster para 6 centros com paises

G6 <- fviz_cluster(dataCluster1.k6, geom = "text", repel = TRUE, data = dataCluster1) + ggtitle("k = 6")
grid.arrange(G6, nrow = 1)
