#Carregando base escolaridade, média de escolaridade, população +25
base_education <- read_excel('education.xlsx')
base_education <- as.data.frame(base_education)

#Limpando a base

base_education <- base_education[-c(1,2),-c(2:12)]
rownames(base_education) <- base_education[,1]
base_education <- base_education[,-1]
base_education <- rename(base_education, 'average' =...13,
                         'desvio'=...14)
base_education <- na.omit(base_education)

save(base_education, file = 'base_education.RData')
