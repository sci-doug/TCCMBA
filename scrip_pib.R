#carregando a base sobre o pib, pib/per capta ano 2020

#valores de pib per/capta dólares, pib em milhões

base_gdp <- read_excel('gdp.xls')

#Limpando a base

new_base_gdp <- base_gdp[, -c(1,2,3,5,7,8,9,10)]
new_base_gdp <- new_base_gdp[,-c(5:7)]

#Separando per/capta de total

gdp_Capta <- new_base_gdp %>% filter(Element =='Value US$ per capita')
gdp_Total <- new_base_gdp %>% filter(Element == 'Value US$')

#Preparando o data.frame final

gdp_Capta <- as.data.frame(gdp_Capta)
rownames(gdp_Capta) <- gdp_Capta[,1]
gdp_Capta <- gdp_Capta %>% mutate_at(c(4), as.numeric)
gdp_Capta <- gdp_Capta[,-c(1,2)]

gdp_Total <- as.data.frame(gdp_Total)
rownames(gdp_Total) <- gdp_Total[,1]
gdp_Total <- gdp_Total %>% mutate_at(c(4),as.numeric)
gdp_Total <- gdp_Total[,-c(1,2)]


save(gdp_Capta, file = 'gdpCapta.Rdata')
save(gdp_Total, file =  'gdpTotal.Rdata')




