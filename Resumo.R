library(dplyr)




load('dataCluster1.RData')


dataCluster1 <- rename(dataCluster1, waste = 'Household estimate (kg/capita/year)',
                       PIBcapta = 'Pib per capta',
                       Escolaridade = 'escolaridade anos')


dataCluster1 <- transform(dataCluster1, waste = as.factor(waste),PIBcapta = as.factor(PIBcapta),
                          Escolaridade = as.factor(Escolaridade)
)
dataCluster1 <- transform(dataCluster1, waste = as.numeric(waste),
                          PIBcapta = as.numeric(PIBcapta),
                          Escolaridade = as.numeric(Escolaridade))

data.Resumo <- dataCluster1

save(data.Resumo, file =  'data.Resumo.RData')                          
                          
load('data.Resumo.RData')



#Criando o resumo


data.Resumo <- rename(data.Resumo, 'Despedício (kg per capta)' = waste,
                        'Pib per capta'= PIBcapta,
                      'Escolaridade (anos)' = Escolaridade )






                        