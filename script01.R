


#Pacotes
install.packages("readxl")
install.packages("dplyr")
install.packages("tidyverse")

library(readxl)
library(dplyr)
library(tidyverse)


####Carregando os dados iniciais
#base de dados, referência casa
base_dados_house <-  read_excel("DATA_WASTE.xlsx", sheet=5, )
#base de dados, referência serviço
base_dados_service <- read_excel("DATA_WASTE.xlsx", sheet=6, col_names=TRUE)
#base de dados, referência varejo (retalho?)
base_dados_retail <- read_excel("DATA_WASTE.xlsx", sheet=7, col_names=TRUE)

View(head(base_dados_house))

new <-  base_dados_house[-c(1), ]
View(head(new))

#renomeando as colunas
new_base_dados_house<-setNames(base_dados_house, c('Region', 'M49 code', 'Country', 
                  'Household estimate (kg/capita/year)',
                  'Household estimate (tonnes/year)',
                  'Confidence in estimate')) 
#apagando linha 1 duplicada do título
new_base_dados_house <- new_base_dados_house[-c(1),]


#renomeando as colunas da base waste retail

new_base_dados_retail<-setNames(base_dados_retail, c('Region','M49 code','Country',
                                                     'Retail estimate (kg/capita/year)',
                                                     'Retail estimate (tonnes/year)',
                                                     'Confidence in estimate')) 
#apagando linha 1 duplicada do título
new_base_dados_retail <- new_base_dados_retail[-c(1),]

#renomeando as colunas da base service                                
new_base_dados_service<-setNames(base_dados_service, c('Region','M49 code','Country',
                                                       'Food service estimate (kg/capita/year)',
                                                       'Food service estimate (tonnes/year)',
                                                       'Confidence in estimate')) 
#apagando linha 1 duplicada do título
new_base_dados_service <- new_base_dados_service[-c(1),]


save(new_base_dados_house, file = 'houseWaste.RData')
save(new_base_dados_retail, file = 'retailWaste.RData')
save(new_base_dados_service, file = 'seviceWaste.RData')



