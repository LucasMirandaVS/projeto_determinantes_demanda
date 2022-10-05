# Analisando o painel
library(plm)
library(dplyr)
library(lmtest)

P.ANUAL <- read.csv("C:/Users/Lucas/Desktop/Estudos/Economia/ufop/Mestrado/pesquisa/Tabelas dissertação/P.ANUAL.csv", header=TRUE)

P.ANUAL$Y<-as.numeric(gsub(",",'.', P.ANUAL$Y))
summary(P.ANUAL)

# Agora, o painel:
data_panel<- pdata.frame(P.ANUAL, index=c('UF',"ANO")) %>%
  arrange(UF)

summary(data_panel)

#verificando se o painel e balanceado
pdim(data_panel)

#verificando a variacao das variaveis no tempo e individuos
pvar(data_panel)

##################
### POOLED OLS ###
##################
modelo1 <-plm(log(QE)~log(PEC)+
                log(PGC)+
                log(TxF)+
                log(Y)+
                factor(ANO)+
                log(PEC)*D1+
                log(PGC)*D1+
                log(PEC)*D2+
                log(PGC)*D2,
              data = data_panel,
              effect = 'twoways',
              model = 'pooling')

summary(modelo1)

#######################################################
### ESTIMADOR DE EFEITOS FIXOS E PRIMEIRA DIFERENCA ###
#######################################################
modelo2 <- plm(log(QE)~log(PEC)+
                 log(PGC)+
                 log(TxF)+
                 log(Y)+
                 factor(ANO)+
                 log(PEC)*D1+
                 log(PGC)*D1+
                 log(PEC)*D2+
                 log(PGC)*D2,
               data = data_panel,
               effect = 'twoways', # designando o efeito temporal
               model = 'within')

summary(modelo2)

# erro padrão robusto
lmtest::coeftest(modelo2,
                 vcov. = function(x) vcovSCC(x, type = "HC0"))

#######################################
### ESTIMADOR DE EFEITOS ALEATORIOS ###
#######################################
modelo3 <- plm(log(QE)~log(PEC)+
                   log(PGC)+
                   log(TxF)+
                   log(Y)+
                   factor(ANO)+
                   log(PEC)*D1+
                   log(PGC)*D1+
                   log(PEC)*D2+
                   log(PGC)*D2,
                 data = data_panel,
                 model = 'random')

summary(modelo3)

# Testes estatísticos
#####################
### TESTE DE CHOW ###
#####################
pFtest(modelo2, modelo1) # indicou o efeito fixo

########################
### TESTE DE HAUSMAN ###
########################
phtest(modelo2, modelo3)	#indicou o efeito fixo

###########################
### TESTE DE WOOLDRIDGE ###
###########################
pwartest(log(QE)~log(PEC)+
           log(PGC)+
           log(TxF)+
           log(Y)+
           factor(ANO)+
           log(PEC)*D1+
           log(PGC)*D1+
           log(PEC)*D2+
           log(PGC)*D2,
         data = data_panel,
         effect = 'twoways', # designando o efeito temporal
         model = 'within', type = "HC1")

# indicou ausencia de autocorrelação


#####
# Otimizando o modelo
# Aplicando uma coluna dummy para cada estado produtor
# SP
P.ANUAL$dsp <- 0
P.ANUAL$dsp[P.ANUAL$UF == 'SP'] <- 1
# PR
P.ANUAL$dpr <- 0
P.ANUAL$dpr[P.ANUAL$UF == 'PR'] <- 1
# MT
P.ANUAL$dmt <- 0
P.ANUAL$dmt[P.ANUAL$UF == 'MT'] <- 1
# MG
P.ANUAL$dmg <- 0
P.ANUAL$dmg[P.ANUAL$UF == 'MG'] <- 1
# GO
P.ANUAL$dgo <- 0
P.ANUAL$dgo[P.ANUAL$UF == 'GO'] <- 1
# PE
P.ANUAL$dpe <- 0
P.ANUAL$dpe[P.ANUAL$UF == 'PE'] <- 1
# MS
P.ANUAL$dms <- 0
P.ANUAL$dms[P.ANUAL$UF == 'MS'] <- 1

painel <- pdata.frame(P.ANUAL, index=c('UF',"ANO")) %>%
  arrange(UF)

# agora vou refazer as estimações
##estimador de efeitos fixos (versão completa)
modelo4 <- plm(log(QE)~
                 log(PEC)+log(PGC)+log(TxF)+log(Y)+factor(ANO)+
                 log(PEC)*D1+log(PGC)*D1+
                 log(PEC)*dsp+ log(PGC)*dsp+
                 log(PEC)*dpr+ log(PGC)*dpr+
                 log(PEC)*dmt+ log(PGC)*dmt+
                 log(PEC)*dms+ log(PGC)*dms+
                 log(PEC)*dmg+ log(PGC)*dmg+
                 log(PEC)*dgo+ log(PGC)*dgo+
                 log(PEC)*dpe+ log(PGC)*dpe,
               data = painel,
               effect = 'twoways',
               model = 'within')

summary(modelo4)

# Coeficientes com erros robustos
lmtest::coeftest(modelo4,
                 vcov. = function(x) vcovHC(x, type = "HC0"))

# Esses são os resultados que devem ser interpretados


#### Exportando os resultados
library(stargazer)

# estatísticas descritivas
pain <- P.ANUAL %>% select(3,4,5,6,7) # slicing só das variáveis de interesse
stargazer(pain, title="Estatísticas Descritivas", 
          align=TRUE, out = 'table2.html', 
          covariate.labels = c('PIB per Capita', 'Preço Etanol', 'Preço Gasolina', 
                               'Consumo Etanol','Frota'))


# Modelo 2
cov <- vcovSCC(modelo2, type = "HC1")
robust.se <- sqrt(diag(cov))

stargazer(modelo2, title="Resultados", 
          align=TRUE, out = 'table1.html',
          se=list(robust.se), column.labels= c("Consumo de Etanol"),
          covariate.labels = c('Preço Etanol', 'Preço Gasolina',
                               'Frota', 'PIB per Capita',
                               'D1*Preço Etanol', 'D1*Preço Gasolina',
                               'D2*Preço Etanol','D2*Preço Gasolina'))


cov <- vcovSCC(modelo4, type = "HC1")
robust.se <- sqrt(diag(cov))

stargazer(modelo4, title ='Resultados',
          align = TRUE, out = 'table3.html',
          font.size= 'tiny',
          se=list(robust.se),
          column.labels = 'Consumo de etanol',
          covariate.labels = c('Preço Etanol', 'Preço Gasolina',
                               'Frota', 'PIB per Capita',
                               'D1*Preço Etanol', 'D1*Preço Gasolina',
                               'DSP*Preço Etanol','DSP*Preço Gasolina',
                               'DPR*Preço Etanol','DPR*Preço Gasolina',
                               'DMT*Preço Etanol','DMT*Preço Gasolina',
                               'DMS*Preço Etanol','DMS*Preço Gasolina',
                               'DMG*Preço Etanol','DMG*Preço Gasolina',
                               'DGO*Preço Etanol','DGO*Preço Gasolina',
                               'DPE*Preço Etanol','DPE*Preço Gasolina'))



