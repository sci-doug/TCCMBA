library(corrplot)


#Abrindo a base
load("dataCluster1.RData")

view(head(dataCluster1))
summary(dataCluster1)

#Novo objeto
mapaCorrel <- dataCluster1

#Mapa de correlação

corrplot(cor(mapaCorrel), method = "circle", addCoef.col = "black")

corrplot(cor(mapaCorrel), order = 'AOE', addCoef.col = 'black', tl.pos = 'd',
         cl.pos = 'n', col = COL2('PuOr'))

corrplot(cor(mapaCorrel), method = 'square', order = 'AOE', addCoef.col = 'black', tl.pos = 'd',
         cl.pos = 'n', col = COL2('RdBu'), is.corr = TRUE)         

corrplot(cor(mapaCorrel), method = 'square', order = 'FPC', type = 'lower',addCoef.col = 'black',
         diag = FALSE)

padronizadoMapa <- scale(mapaCorrel)

corrplot(cor(padronizadoMapa), method = 'square', order = 'AOE', addCoef.col = 'black', tl.pos = 'd',
         cl.pos = 'n', col = COL2('RdBu'), is.corr = TRUE) 


teste <- scale(dataCluster1)
summary(teste)
makeDataReport(dataCluster1)
sd(dataCluster1)
st(dataCluster1, digits = 2)

