#Instalando e Carregando os pacotes necessários 
#install.packages("plyr")
library(plyr)
#install.packages("ggplot2")
library(ggplot2)
#install.packages("foreign")
library(foreign)
#install.packages("cluster")
library(cluster)
#install.packages ("grid")
library(grid)
#install.packages("fpc")
library(fpc)
#install.packages("NbClust")
library(NbClust)
#install.packages("clustertend")
library(clustertend)



#Abrindo a base de dados 
load("Seu/Diretorio/Aqui/ESEB2014.Rda")

# Conhecimento 1: Quem é o Ministro da Fazenda?
#table(ESEB2014$q20a)
ESEB2014$conhece1 <- as.numeric(ESEB2014$q20a)
ESEB2014$conhece1[ESEB2014$conhece1 != 3] <- 0
ESEB2014$conhece1[ESEB2014$conhece1==3] <- 1 #Guido Mantega
#table (ESEB2014$conhece1)


#Conhecimento 2: Qual a taxa de desemprego no Brasil em setembro de 2014?
#table(ESEB2014$q20b)
ESEB2014$conhece2 <- as.numeric(ESEB2014$q20b)
ESEB2014$conhece2[ESEB2014$conhece2 != 3] <- 0
ESEB2014$conhece2[ESEB2014$conhece2==3] <- 1 #5%
#table (ESEB2014$conhece2)

#Conhecimento 3: Qual o partido com a segunda maior bancada na Câmara dos Deputados?
#table(ESEB2014$q20c)
ESEB2014$conhece3 <- as.numeric(ESEB2014$q20c)
ESEB2014$conhece3[ESEB2014$conhece3 != 1] <- 0
ESEB2014$conhece3[ESEB2014$conhece3==1] <- 1 #PMDB
#table (ESEB2014$conhece3)


#Conhecimento 4: Quem é o Secretário da ONU atualmente?
#table(ESEB2014$q20d)
ESEB2014$conhece4 <- as.numeric(ESEB2014$q20d)
ESEB2014$conhece4[ESEB2014$conhece4 != 3]<-0 
ESEB2014$conhece4[ESEB2014$conhece4==3] <- 1 #Ban Ki-Moon
#table (ESEB2014$conhece4)

#Conhecimento 5: Posicionamento PT < Posicionamento PSDB

ESEB2014$posicionamento_pt<-as.numeric(ESEB2014$q11a)
ESEB2014$posicionamento_psdb<-as.numeric(ESEB2014$q11e)

table(ESEB2014$q11a)

#table(ESEB2014$posicionamento_pt)
#table(ESEB2014$posicionamento_psdb)


ESEB2014$conhece5<-as.numeric(ESEB2014$posicionamento_pt<ESEB2014$posicionamento_psdb)

ESEB2014$conhece5[ESEB2014$posicionamento_pt==12]<- 0 #Não sabe o que é esquerda e direita
ESEB2014$conhece5[ESEB2014$posicionamento_pt==13]<- 0 #Não conhece o partido
ESEB2014$conhece5[ESEB2014$posicionamento_pt==14]<- 0 #Não sabe
ESEB2014$conhece5[ESEB2014$posicionamento_pt==15]<- NA #Não respondeu
ESEB2014$conhece5[ESEB2014$posicionamento_pt==16]<- NA #Não se aplica
ESEB2014$conhece5[ESEB2014$posicionamento_psdb==12]<- 0
ESEB2014$conhece5[ESEB2014$posicionamento_psdb==13]<- 0
ESEB2014$conhece5[ESEB2014$posicionamento_psdb==14]<- 0
ESEB2014$conhece5[ESEB2014$posicionamento_psdb==15]<- NA
ESEB2014$conhece5[ESEB2014$posicionamento_psdb==16]<- NA

#table(ESEB2014$conhece5)
#hist(ESEB2014$conhece5)


#Conhecimento 6: Posicionamento PT < Posicionamento DEM

ESEB2014$posicionamento_dem<-as.numeric(ESEB2014$q11g)
#table(ESEB2014$posicionamento_dem)

ESEB2014$conhece6<-as.numeric(ESEB2014$posicionamento_pt<ESEB2014$posicionamento_dem)
#table(ESEB2014$conhece6)


ESEB2014$conhece6[ESEB2014$posicionamento_pt==12]<- 0
ESEB2014$conhece6[ESEB2014$posicionamento_pt==13]<- 0
ESEB2014$conhece6[ESEB2014$posicionamento_pt==14]<- 0
ESEB2014$conhece6[ESEB2014$posicionamento_pt==15]<- NA 
ESEB2014$conhece6[ESEB2014$posicionamento_pt==16]<- NA
ESEB2014$conhece6[ESEB2014$posicionamento_dem==12]<- 0
ESEB2014$conhece6[ESEB2014$posicionamento_dem==13]<- 0
ESEB2014$conhece6[ESEB2014$posicionamento_dem==14]<- 0
ESEB2014$conhece6[ESEB2014$posicionamento_dem==15]<- NA
ESEB2014$conhece6[ESEB2014$posicionamento_dem==16]<- NA

#table(ESEB2014$conhece6)


#Conhecimento 7: Posicionamento PSB < Posicionamento PSDB

ESEB2014$posicionamento_psb<-as.numeric(ESEB2014$q11i)
#table(ESEB2014$posicionamento_psb)

ESEB2014$conhece7<-as.numeric(ESEB2014$posicionamento_psb<ESEB2014$posicionamento_psdb)
#table(ESEB2014$conhece7)



ESEB2014$conhece7[ESEB2014$posicionamento_psb==12]<- 0
ESEB2014$conhece7[ESEB2014$posicionamento_psb==13]<- 0
ESEB2014$conhece7[ESEB2014$posicionamento_psb==14]<- 0
ESEB2014$conhece7[ESEB2014$posicionamento_psb==15]<- NA
ESEB2014$conhece7[ESEB2014$posicionamento_psb==16]<- NA
ESEB2014$conhece7[ESEB2014$posicionamento_psdb==12]<- 0
ESEB2014$conhece7[ESEB2014$posicionamento_psdb==13]<- 0
ESEB2014$conhece7[ESEB2014$posicionamento_psdb==14]<- 0
ESEB2014$conhece7[ESEB2014$posicionamento_psdb==15]<- NA
ESEB2014$conhece7[ESEB2014$posicionamento_psdb==16]<- NA

#table(ESEB2014$conhece7)


#Conhecimento 8: Posicionamento PSB < Posicionamento DEM

ESEB2014$conhece8<-as.numeric(ESEB2014$posicionamento_psb<ESEB2014$posicionamento_dem)
#table(ESEB2014$conhece8)

ESEB2014$conhece8[ESEB2014$posicionamento_psb==12]<- 0
ESEB2014$conhece8[ESEB2014$posicionamento_psb==13]<- 0
ESEB2014$conhece8[ESEB2014$posicionamento_psb==14]<- 0
ESEB2014$conhece8[ESEB2014$posicionamento_psb==15]<- NA
ESEB2014$conhece8[ESEB2014$posicionamento_psb==16]<- NA
ESEB2014$conhece8[ESEB2014$posicionamento_dem==12]<- 0
ESEB2014$conhece8[ESEB2014$posicionamento_dem==13]<- 0
ESEB2014$conhece8[ESEB2014$posicionamento_dem==14]<- 0
ESEB2014$conhece8[ESEB2014$posicionamento_dem==15]<- NA
ESEB2014$conhece8[ESEB2014$posicionamento_dem==16]<- NA

#table(ESEB2014$conhece8)


#Conhecimento político
ESEB2014$conhecimento_pol <- (ESEB2014$conhece1+ESEB2014$conhece2+
  ESEB2014$conhece3 + ESEB2014$conhece4+ESEB2014$conhece5+ESEB2014$conhece6+
    ESEB2014$conhece7+ESEB2014$conhece8)
#table(ESEB2014$conhecimento_pol)
#summary(ESEB2014$conhecimento_pol)


#Histograma do conhecimento político
grafico_conhecimento <- ggplot(ESEB2014, aes(x=conhecimento_pol)) + geom_bar() + 
  xlab("Número de respostas corretas") + ylab("Frequência") + 
  scale_x_continuous(breaks=c(0:8))
grafico_conhecimento

#Auto-identificação ideológica (00 = Esquerda, 10 = Direita)
ESEB2014$ideologia<-as.numeric(ESEB2014$q12)

#Eliminando "Não sabe", "Não sabe o que é esquerda e direita" e "Não respondeu"
ESEB2014$ideologia[ESEB2014$ideologia>11]<-NA 
#table(ESEB2014$ideologia)

#Histograma da auto-identificação ideológica
ideologia_histograma <- ggplot(ESEB2014, aes(x=ideologia)) + geom_bar() + 
  xlab("Auto-posicionamento ideológico") + ylab("Frequência") + 
  scale_x_continuous(breaks=c(1:11), labels = c("Esquerda","1","2","3","4","5","6","7","8","9","Direita"))
ideologia_histograma

#Segmentando as variáveis de interesse em uma nova base de dados
ideologia.cluster <- data.frame(ESEB2014$conhecimento_pol, ESEB2014$ideologia)

#Omitindo NAs na base de dados
ideologia.cluster <- na.omit(ideologia.cluster)

#Removendo outliers
table(ideologia.cluster$ESEB2014.conhecimento_pol)
outlier_conhecimento <- boxplot.stats(ideologia.cluster$ESEB2014.conhecimento_pol)$out
outlier_conhecimento

table(ideologia.cluster$ESEB2014.ideologia)
outlier_ideologia <- boxplot.stats(ideologia.cluster$ESEB2014.ideologia)$out
outlier_ideologia

ideologia.cluster <- ideologia.cluster[ideologia.cluster$ESEB2014.conhecimento_pol<7,]
ideologia.cluster <- ideologia.cluster[ideologia.cluster$ESEB2014.ideologia>1,]

table(ideologia.cluster$ESEB2014.ideologia)
table(ideologia.cluster$ESEB2014.conhecimento_pol)

#Padronizando as escalas das variáveis
k.ideologia.scale <- scale(ideologia.cluster)


#Análise de cluster com variáveis padronizadas
k.fit.1 <- kmeans(k.ideologia.scale, 5)
k.fit.1$centers

#Teste de Hopkins ()
hopkins(ideologia.cluster, nrow(ideologia.cluster)-1)






