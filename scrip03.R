#join entre base house e todas as outras

load('houseWaste.RData')
load('gdpCapta.RData')
load('base_education.RData')

#Ajustando data house waste
data.House.Waste <- new_base_dados_house[,-c(1,2,6)]
data.House.Waste <- as.data.frame(data.House.Waste)
data.House.Waste <- na.omit(data.House.Waste) 
data.House.Waste<-data.House.Waste[!(data.House.Waste$`Household estimate (kg/capita/year)`=="*"),]

rownames(data.House.Waste) <- data.House.Waste[,1]
data.House.Waste <- data.House.Waste[,-1]

save(data.House.Waste, file = 'data.House.Waste.RData')

#Ajustando Pib per capta

data.PIB.capta <- rename(gdp_Capta, 'Pib per capta' = Value )

save(data.PIB.capta, file = 'data.PIB.capta.RData')


#Ajustando anos de escolaridade médio

data.ESCOLARIDADE <- base_education
save(data.ESCOLARIDADE, file = 'data.ESCOLARIDADE.RData')

#Juntando bases


dadosJuntos <- merge(data.House.Waste,data.PIB.capta, by = 0 )#juntando pelo critério de rownames
rownames(dadosJuntos) <- dadosJuntos[,1]
dadosJuntos <- dadosJuntos[,-1]

dadosJuntos<- merge(dadosJuntos,data.ESCOLARIDADE, by = 0)

save(dadosJuntos, file = 'dadosJuntos')

# Retirando info desnecessários

dataCluster1 <- dadosJuntos

rownames(dataCluster1) <- dataCluster1[,1]
dataCluster1 <- dataCluster1[,-c(1,3,4,7)] 
dataCluster1 <- rename(dataCluster1, 'escolaridade anos' = average )

save(dataCluster1, file = 'dataCluster1.RData')

                                                                             '
             
