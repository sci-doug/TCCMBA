load('houseWaste.RData')
load('retailWaste.RData')
load('seviceWaste.RData')
load('gdpCapta.RData')
load('gdpTotal.RData')
load('base_education.RData')


#Juntando os desperdícios


sumWaste <- left_join(new_base_dados_house, new_base_dados_retail)
sumWaste <- left_join(sumWaste,new_base_dados_service)

save(sumWaste, file = 'sumWaste.RData')


#Preparando data para cluster com todos despedícios

sumWaste <- sumWaste[,-c(1,2,5,6,8,10)]

######################################
#Retirando Na da base
sumWaste_Na <- na.omit(sumWaste)

sumWaste_Na <- as.data.frame(sumWaste_Na)
rownames(sumWaste_Na) <- sumWaste_Na[,1]
sumWaste_Na <-sumWaste_Na[,-1] 

#converter em numeric
sumWaste_Na[] <- lapply(sumWaste_Na, function(x) as.numeric(as.character(x)))


#REALIZAR CLUSTER

#Padronizar variaveis
sumWaste_Na.padro <- scale(sumWaste_Na)





### método k-means

#Agora vamos rodar de 3 a 6 centros  e visualizar qual a melhor divisao
sumwaste.k3 <- kmeans(sumWaste_Na.padro, centers = 3)
sumwaste.k4 <- kmeans(sumWaste_Na.padro, centers = 4)


#Graficos
G1 <- fviz_cluster(sumwaste.k3, geom = "point", data = sumWaste_Na.padro) + ggtitle("k = 3")
G2 <- fviz_cluster(sumwaste.k4, geom = "point",  data = sumWaste_Na.padro) + ggtitle("k = 4")


#Criar uma matriz com 4 graficos
grid.arrange(G1, G2, nrow = 2)

#VERIFICANDO ELBOW 
fviz_nbclust(sumWaste_Na.padro, FUN = hcut, method = "wss")





