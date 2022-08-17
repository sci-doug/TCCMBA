base_agricultura <- read.csv('Agricultural_Index.csv')
View(head(base_agricultura,15))
remove(base_agricultura)


base_agricultura <- read_excel('index_agricultural.xls')

tabela_merge <- merge(new_base_dados_house,base_agricultura)
tabela_merge <- left_join(new_base_dados_house, base_agricultura)#left join países                      

#trocando nome da tabela para realizar o left_join
base_agricultura <-  rename(base_agricultura, Country = Area)                      



                     
base_gdp <- read_excel('gdp.xls')

teste <- as.data.frame(gdp_Capta)
teste <- as.numeric(gdp_Capta$Value)
teste <- as.data.frame(teste)
teste <- gdp_Capta %>% mutate_at(c(2), as.numeric)
teste <- as.data.frame(gdp_Total)

teste <- gdp_Total
teste <- as.data.frame(teste)
rownames(teste) <- teste[,1]
teste <- teste[,-1]
