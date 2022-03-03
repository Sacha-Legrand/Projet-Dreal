rm(list=ls())

############## Packages -----

if(!require(leaflet)){
  install.packages("leaflet")
  library(leaflet)
}
if(!require(dplyr)){
  install.packages("dplyr")
  library(dplyr)
}
if(!require(sf)){
  install.packages("sf")
  library(sf)
}
if(!require(leafpop)){
  install.packages("leafpop")
  library(leafpop)
}
if(!require(zoo)){
  install.packages("zoo")
  library(zoo)
}
if(!require(lubridate)){
  install.packages("lubridate")
  library(lubridate)
}
if(!require(shiny)){
  install.packages("shiny")
  library(shiny)
}
if(!require(htmlwidgets)){
  install.packages("htmlwidgets")
  library(htmlwidgets)
}
if(!require(dygraphs)){
  install.packages("dygraphs")
  library(dygraphs)
}
if(!require(devtools)){
  install.packages("devtools")
  library(devtools)
}
if(!require(xts)){
  install.packages("xts")
  library(xts)
}
if(!require(maptools)){
  install.packages("maptools")
  library(maptools)
}
if(!require(shinyjs)){
  install.packages("shinyjs")
  library(shinyjs)
}
if(!require(shinydashboard)){
  install.packages("shinydashboard")
  library(shinydashboard)
}
if(!require(reactable)){
  install.packages("reactable")
  library(reactable)
}

if(!require(plotly)){
  install.packages("plotly")
  library(plotly)
}

if(!require(rstatix)){
  install.packages("rstatix")
  library(rstatix)
}

if(!require(tidyr)){
  install.packages("tidyr")
  library(tidyr)
}

if(!require(openxlsx)){
  install.packages("openxlsx")
  library(openxlsx)
}
if(!require(ggpubr)){
  install.packages("ggpubr")
  library(ggpubr)
}
if(!require(TSA)){
  install.packages("TSA")
  library(TSA)
}
if(!require(dashboardthemes)){
  install.packages("dashboardthemes")
  library(dashboardthemes)
}
if(!require(flamingos)){
  install.packages("flamingos")
  library(flamingos)
}
if(!require(raster)){
  install.packages("raster")
  library(raster)
}
if(!require(ncdf4)){
  install.packages("ncdf4")
  library(ncdf4)
}
if(!require(fastICA)){
  install.packages("fastICA")
  library(fastICA)
}
if(!require(ifa)){
  install.packages("ifa")
  library(ifa)
}

if(!require(stringr)){
  install.packages("stringr")
  library(stringr)
}

if(!require(missMDA)){
  install.packages("missMDA ")
  library(missMDA)
}
if(!require(FactoMineR)){
  install.packages("FactoMineR ")
  library(FactoMineR)
}
if(!require(factoextra)){
  install.packages("factoextra")
  library(factoextra)
}


############## Working Directory -----

# Path to working directory
path = "D:/Users/Desktop/Cours/M2stat/Projet2/Projet-Dreal-main/data_treatment/"

# Setting working Directory
setwd(path)


############## Chargement des données -----

load("RData/db.RData")
load("RData/KMLs.RData")
load("RData/db_temp_synthese.RData")
load("RData/db_nc_files.RData")

############## Traitement des données -----


riv=c("La Monne","La Vie","La Taute","La Barges",
      "Ruisseau de la Grande Vallée", "La Souleuvre","La Sée Rousse","L’Egrenne",
      "La Durance","La Sée","La Bérence", "Le Glanon",
      "Ruisseau de Vingt Bec","La Fontaine au Héron","L'Odon T1","L'Odon T2",
      "L'Odon T4","L'Odon T5","L'Orne T1","L'Orne T3","L'Orne T2",
      "La Sélune T4","La Sélune T2","La Sélune T3","La Sélune T5","La Sélune T1",
      "La Touques T1","La Touques T3","La Touques T4","La Touques T6"
)

#######################################
# Tableau Stat
#######################################
db_stats = db
db_stats$an = year(db_stats$date)
db_stats = db_stats %>%
  group_by(id_sonde,date) %>%
  mutate(
    #MinJourn=min(Teau),
    #t10 = quantile(Teau,.1),
    #t25 = quantile(Teau,.25),
    #Mediane = median(Teau),
    TeauMoy = mean(Teau),
    #sd = sd(Teau),
    #t75 = quantile(Teau,.75),
    #t90 = quantile(Teau,.90),
    Ampl = max(Teau) - min(Teau)
    #Amplitude =  Max - Min
  )

db_stats = db_stats %>%
  group_by(id_sonde,an) %>%
  mutate(Min=min(TeauMoy),
         t10 = quantile(TeauMoy,.1),
         t25 = quantile(TeauMoy,.25),
         Mediane = median(TeauMoy),
         Moyenne = mean(TeauMoy),
         sd = sd(TeauMoy),
         t75 = quantile(TeauMoy,.75),
         t90 = quantile(TeauMoy,.90),
         Max = max(TeauMoy),
         `Amplitude moyenne` =  mean(Ampl),
         `Amplitude maximum` =  max(Ampl),
         `Amplitude minimum` =  min(Ampl)
  )


db_stats = db_stats[,-c(1,3,4,6,7)]
db_stats = db_stats[which(duplicated(db_stats)==F),]

db_stats <- db_stats %>%
  gather(key="Statistiques",value="Valeurs",c(3:ncol(db_stats))) %>%
  convert_as_factor(Statistiques)
db_stats$Valeurs = round(db_stats$Valeurs,3)
db_stats$id_sonde <- as.factor(db_stats$id_sonde)



db_stats$label <- factor(db_stats$id_sonde ,
                         levels =levels(db_stats$id_sonde),
                         labels =riv
)
db_stats$Statistiques <- as.factor(db_stats$Statistiques)
db_stats$an <- as.factor(db_stats$an)
db_stats= db_stats[,c(1,5,2,3,4)]


colnames(db_stats) = c("id_sonde","Sondes","Années","Statistiques","Valeurs")



############
# db_stats_Touques
############
db_stats_Touques = db_stats[db_stats$id_sonde == 825|
                              db_stats$id_sonde == 827 |
                              db_stats$id_sonde == 828 |
                              db_stats$id_sonde == 830 ,]
db_stats_Touques$Sondes <- factor(db_stats_Touques$Sondes,exclude=NULL)
db_stats_Touques = db_stats_Touques[,-1]

############
# db_stats_Orne
############
db_stats_Orne = db_stats[db_stats$id_sonde == 817|
                           db_stats$id_sonde == 819 |
                           db_stats$id_sonde == 818 ,]

db_stats_Orne$Sondes <- factor(db_stats_Orne$Sondes,exclude=NULL)
db_stats_Orne = db_stats_Orne[,-1]

############
# db_stats_Odon
############
db_stats_Odon = db_stats[db_stats$id_sonde == 812|
                           db_stats$id_sonde == 813 |
                           db_stats$id_sonde == 814 |
                           db_stats$id_sonde == 815 |
                           db_stats$id_sonde == 816,]
db_stats_Odon$Sondes <- factor(db_stats_Odon$Sondes,exclude=NULL)
db_stats_Odon = db_stats_Odon[,-1]

############
# db_stats_Selune
############
db_stats_Selune = db_stats[db_stats$id_sonde == 824|
                             db_stats$id_sonde == 821 |
                             db_stats$id_sonde == 822 |
                             db_stats$id_sonde == 820 |
                             db_stats$id_sonde == 823 ,]
db_stats_Selune$Sondes <- factor(db_stats_Selune$Sondes,exclude=NULL)
db_stats_Selune = db_stats_Selune[,-1]



## dbMM ----
db2 =db %>%
  group_by(id_sonde,date)%>%
  mutate(TeauMin = min(Teau),
         TeauMax = max(Teau),
         TeauMed = median(Teau),
         TeauMoy = mean(Teau)
  )


db2 <- db2[,-c(1,3)]
db2 = db2[which(duplicated(db2)==F),]




dbMM = db2 %>%
  group_by(id_sonde)%>%
  mutate(TeauMinMM7 = stats::filter(TeauMin,filter=rep(1/7,7)),
         TeauMinMM30 = stats::filter(TeauMin,filter=c(1/(2*30),rep(1/30,29),1/(2*30))),
         TeauMinMM365 = stats::filter(TeauMin,filter=rep(1/365,365)),
         TeauMaxMM7 = stats::filter(TeauMax,filter=rep(1/7,7)),
         TeauMaxMM30 = stats::filter(TeauMax,filter=c(1/(2*30),rep(1/30,29),1/(2*30))),
         TeauMaxMM365 = stats::filter(TeauMax,filter=rep(1/365,365)),
         TeauMeanMM7 = stats::filter(TeauMoy,filter=rep(1/7,7)),
         TeauMeanMM30 = stats::filter(TeauMoy,filter=c(1/(2*30),rep(1/30,29),1/(2*30))),
         TeauMeanMM365 = stats::filter(TeauMoy,filter=rep(1/365,365)),
         TeauMedMM7 = stats::filter(TeauMed,filter=rep(1/7,7)),
         TeauMedMM30 = stats::filter(TeauMed,filter=c(1/(2*30),rep(1/30,29),1/(2*30))),
         TeauMedMM365 = stats::filter(TeauMed,filter=rep(1/365,365))
         
  )

## db2 ----
db2$limiteTruite <- NA
db2$limiteTruite = ifelse(db2$TeauMoy <= 0.5 | db2$TeauMoy >=  25.5 ,
                          db2$limiteTruite <- "Seuil létal",
                          ifelse( db2$TeauMoy >=  19.5 ,
                                  db2$limiteTruite <- "Seuil critique",
                                  ifelse( db2$TeauMoy <= 4.5 | db2$TeauMoy >=  16.5 ,
                                          db2$limiteTruite <- "Danger pour juvéniles",
                                          db2$limiteTruite <- "Préférendum thermique" )
                          ))

db2$limiteTruite <- as.factor(db2$limiteTruite)


db2$limiteBrochet <- NA
db2$limiteBrochet = ifelse(db2$TeauMoy <= 2.5  ,
                           db2$limiteBrochet <- "Seuil létal adulte",
                           ifelse( db2$TeauMoy <=  5.5 ,
                                   db2$limiteBrochet <- "Seuil létal juvéniles",
                                   ifelse( db2$TeauMoy >=  19.5 ,
                                           db2$limiteBrochet <- "Danger pour les embryons",
                                           ifelse( db2$TeauMoy <= 9.5  ,
                                                   db2$limiteBrochet <- "Danger pour juvéniles",
                                                   ifelse( db2$TeauMoy >= 24.5  ,
                                                           db2$limiteBrochet <- "Danger pour les larves",
                                                           ifelse( db2$TeauMoy >= 30.5 ,
                                                                   db2$limiteBrochet <- "Seuil létal",
                                                                   db2$limiteBrochet <- "Préférendum thermique")
                                                   )))))

db2$limiteBrochet <- as.factor(db2$limiteBrochet)
db2$limiteR <- "Sans Espèce"

db2 <- db2 %>%
  gather(key="Espece",value="Pref",c(7:9)) %>%
  convert_as_factor(Espece)

db2$An <- year(db2$date)
colnames(db2)[6] = "Température moyenne"

## db3, pref, prefTouques ----

# tableau de récap des données pour seuil thermiques
db3 = db2
db3$nb = 1

pref = db3[db3$Espece=="limiteTruite" | db3$Espece=="limiteBrochet" ,] %>%
  group_by(An,id_sonde,Pref,Espece)%>%
  mutate(Somme = sum(nb))

pref=pref[,c(1,7,8,9,11)]
pref=pref[which(duplicated(pref)==F),]

pref$Espece <- as.factor(pref$Espece)
pref$Pref <- as.factor(pref$Pref)
pref$An <- as.factor(pref$An)


pref$Espece <- factor(pref$Espece,
                      levels = c(
                        "limiteBrochet", "limiteR" ,"limiteTruite"
                      ),
                      labels =c("Brochet","Rien","Truite")
)


prefTouques = pref[(pref$id_sonde == 825|
                      pref$id_sonde == 827|
                      pref$id_sonde == 828|
                      pref$id_sonde == 830),]


prefTouques$id_sonde <- factor(prefTouques$id_sonde,exclude=NULL)
prefTouques$id_sonde <- factor(prefTouques$id_sonde,
                               levels = c(
                                 "825", "827", "828", "830"
                               ),
                               labels =c("Touques T1","Touques T3","Touques T4","Touques T6")
)
prefTouques$Espece <- factor(prefTouques$Espece,exclude=NULL)

prefTouques$Pref=factor(prefTouques$Pref,exclude=NULL)

prefTouques$An =factor(prefTouques$An,exclude=NULL)


colnames(prefTouques) = c("Sonde","Espèce","Seuils thermiques","Années","Nombre d'occurence")


# SONDE TOUQUES ----
# sonde825 ----

#Touques sonde 825
dbsonde825MM <- dbMM[dbMM$id_sonde==825,]
db_xts_date825 = dbsonde825MM$date

# Calcule droite de régression MM30
dbsonde825MMReg <- as.data.frame(cbind(dbsonde825MM$date,dbsonde825MM$TeauMinMM30,dbsonde825MM$TeauMaxMM30))
colnames(dbsonde825MMReg)=c("date","TeauMinMM30","TeauMaxMM30")
dbsonde825MMReg$date <- as.Date(dbsonde825MMReg$date,origin="1970-01-01")
dbsonde825MMReg <- dbsonde825MMReg[is.na(dbsonde825MMReg$TeauMinMM30)==F,]
dbsonde825MMReg$t = 1:nrow(dbsonde825MMReg)
dbsonde825MMReg$regMinMM30 = lm(TeauMinMM30~t,data= dbsonde825MMReg)$fitted.values
dbsonde825MMReg$regMaxMM30 = lm(TeauMaxMM30~t,data= dbsonde825MMReg)$fitted.values
dbsonde825MMReg = dbsonde825MMReg[,-c(2:4)]


dbsonde825MM=merge(dbsonde825MM,dbsonde825MMReg,by="date",all.x=T)


# Calcule droite de régression MM365
dbsonde825MMReg <- as.data.frame(cbind(dbsonde825MM$date,dbsonde825MM$TeauMinMM365,dbsonde825MM$TeauMaxMM365))
colnames(dbsonde825MMReg)=c("date","TeauMinMM365","TeauMaxMM365")
dbsonde825MMReg$date <- as.Date(dbsonde825MMReg$date,origin="1970-01-01")
dbsonde825MMReg <- dbsonde825MMReg[is.na(dbsonde825MMReg$TeauMinMM365)==F,]
dbsonde825MMReg$t = 1:nrow(dbsonde825MMReg)
dbsonde825MMReg$regMinMM365 = lm(TeauMinMM365~t,data= dbsonde825MMReg)$fitted.values
dbsonde825MMReg$regMaxMM365 = lm(TeauMaxMM365~t,data= dbsonde825MMReg)$fitted.values
dbsonde825MMReg = dbsonde825MMReg[,-c(2:4)]
dbsonde825MM=merge(dbsonde825MM,dbsonde825MMReg,by="date",all.x=T)


db_xts_sonde825 = dbsonde825MM[, c(FALSE, FALSE, rep(T,ncol(dbsonde825MM)-2))] # pour garder que les colonnes / series de températures à transformer
db_xts_date825 = dbsonde825MM$date
db_xts_sonde825 = xts(db_xts_sonde825, order.by=db_xts_date825)
db_xts_sonde825a =  db_xts_sonde825[,c(1,4,2,5,11,8)]

db_xts_sonde825b = db_xts_sonde825[,c(6,12,9,17,18)]
db_xts_sonde825b = db_xts_sonde825b[is.na(db_xts_sonde825b$TeauMinMM30)==F,]
db_xts_sonde825c = db_xts_sonde825[,c(7,13,10,19,20)]
db_xts_sonde825c = db_xts_sonde825c[is.na(db_xts_sonde825c$TeauMinMM365)==F,]

head(db_xts_sonde825c)
rm(dbsonde825MMReg)

# sonde827 ----
dbsonde827MM <- dbMM[dbMM$id_sonde==827,]

# Calcule droite de régression MM30
dbsonde827MMReg <- as.data.frame(cbind(dbsonde827MM$date,dbsonde827MM$TeauMinMM30,dbsonde827MM$TeauMaxMM30))
colnames(dbsonde827MMReg)=c("date","TeauMinMM30","TeauMaxMM30")
dbsonde827MMReg$date <- as.Date(dbsonde827MMReg$date,origin="1970-01-01")
dbsonde827MMReg <- dbsonde827MMReg[is.na(dbsonde827MMReg$TeauMinMM30)==F,]
dbsonde827MMReg$t = 1:nrow(dbsonde827MMReg)
dbsonde827MMReg$regMinMM30 = lm(TeauMinMM30~t,data= dbsonde827MMReg)$fitted.values
dbsonde827MMReg$regMaxMM30 = lm(TeauMaxMM30~t,data= dbsonde827MMReg)$fitted.values
dbsonde827MMReg = dbsonde827MMReg[,-c(2:4)]


dbsonde827MM=merge(dbsonde827MM,dbsonde827MMReg,by="date",all.x=T)


# Calcule droite de régression MM365
dbsonde827MMReg <- as.data.frame(cbind(dbsonde827MM$date,dbsonde827MM$TeauMinMM365,dbsonde827MM$TeauMaxMM365))
colnames(dbsonde827MMReg)=c("date","TeauMinMM365","TeauMaxMM365")
dbsonde827MMReg$date <- as.Date(dbsonde827MMReg$date,origin="1970-01-01")
dbsonde827MMReg <- dbsonde827MMReg[is.na(dbsonde827MMReg$TeauMinMM365)==F,]
dbsonde827MMReg$t = 1:nrow(dbsonde827MMReg)
dbsonde827MMReg$regMinMM365 = lm(TeauMinMM365~t,data= dbsonde827MMReg)$fitted.values
dbsonde827MMReg$regMaxMM365 = lm(TeauMaxMM365~t,data= dbsonde827MMReg)$fitted.values
dbsonde827MMReg = dbsonde827MMReg[,-c(2:4)]
dbsonde827MM=merge(dbsonde827MM,dbsonde827MMReg,by="date",all.x=T)


db_xts_sonde827 = dbsonde827MM[, c(FALSE, FALSE, rep(T,ncol(dbsonde827MM)-2))] # pour garder que les colonnes / series de températures à transformer
db_xts_date827 = dbsonde827MM$date
db_xts_sonde827 = xts(db_xts_sonde827, order.by=db_xts_date827)
db_xts_sonde827a =  db_xts_sonde827[,c(1,4,2,5,11,8)]
db_xts_sonde827b = db_xts_sonde827[,c(6,12,9,17,18)]
db_xts_sonde827b = db_xts_sonde827b[is.na(db_xts_sonde827b$TeauMinMM30)==F,]
db_xts_sonde827c = db_xts_sonde827[,c(7,13,10,19,20)]
db_xts_sonde827c = db_xts_sonde827c[is.na(db_xts_sonde827c$TeauMinMM365)==F,]

rm(dbsonde827MMReg)
# sonde828 ----
dbsonde828MM <- dbMM[dbMM$id_sonde==828,]

# Calcule droite de régression MM30
dbsonde828MMReg <- as.data.frame(cbind(dbsonde828MM$date,dbsonde828MM$TeauMinMM30,dbsonde828MM$TeauMaxMM30))
colnames(dbsonde828MMReg)=c("date","TeauMinMM30","TeauMaxMM30")
dbsonde828MMReg$date <- as.Date(dbsonde828MMReg$date,origin="1970-01-01")
dbsonde828MMReg <- dbsonde828MMReg[is.na(dbsonde828MMReg$TeauMinMM30)==F,]
dbsonde828MMReg$t = 1:nrow(dbsonde828MMReg)
dbsonde828MMReg$regMinMM30 = lm(TeauMinMM30~t,data= dbsonde828MMReg)$fitted.values
dbsonde828MMReg$regMaxMM30 = lm(TeauMaxMM30~t,data= dbsonde828MMReg)$fitted.values
dbsonde828MMReg = dbsonde828MMReg[,-c(2:4)]


dbsonde828MM=merge(dbsonde828MM,dbsonde828MMReg,by="date",all.x=T)


# Calcule droite de régression MM365
dbsonde828MMReg <- as.data.frame(cbind(dbsonde828MM$date,dbsonde828MM$TeauMinMM365,dbsonde828MM$TeauMaxMM365))
colnames(dbsonde828MMReg)=c("date","TeauMinMM365","TeauMaxMM365")
dbsonde828MMReg$date <- as.Date(dbsonde828MMReg$date,origin="1970-01-01")
dbsonde828MMReg <- dbsonde828MMReg[is.na(dbsonde828MMReg$TeauMinMM365)==F,]
dbsonde828MMReg$t = 1:nrow(dbsonde828MMReg)
dbsonde828MMReg$regMinMM365 = lm(TeauMinMM365~t,data= dbsonde828MMReg)$fitted.values
dbsonde828MMReg$regMaxMM365 = lm(TeauMaxMM365~t,data= dbsonde828MMReg)$fitted.values
dbsonde828MMReg = dbsonde828MMReg[,-c(2:4)]
dbsonde828MM=merge(dbsonde828MM,dbsonde828MMReg,by="date",all.x=T)


db_xts_sonde828 = dbsonde828MM[, c(FALSE, FALSE, rep(T,ncol(dbsonde828MM)-2))] # pour garder que les colonnes / series de températures à transformer
db_xts_date828 = dbsonde828MM$date
db_xts_sonde828 = xts(db_xts_sonde828, order.by=db_xts_date828)
db_xts_sonde828a =  db_xts_sonde828[,c(1,4,2,5,11,8)]
db_xts_sonde828b = db_xts_sonde828[,c(6,12,9,17,18)]
db_xts_sonde828b = db_xts_sonde828b[is.na(db_xts_sonde828b$TeauMinMM30)==F,]
db_xts_sonde828c = db_xts_sonde828[,c(7,13,10,19,20)]
db_xts_sonde828c = db_xts_sonde828c[is.na(db_xts_sonde828c$TeauMinMM365)==F,]

rm(dbsonde828MMReg)
# sonde830 ----

dbsonde830MM <- dbMM[dbMM$id_sonde==830,]

# Calcule droite de régression MM30
dbsonde830MMReg <- as.data.frame(cbind(dbsonde830MM$date,dbsonde830MM$TeauMinMM30,dbsonde830MM$TeauMaxMM30))
colnames(dbsonde830MMReg)=c("date","TeauMinMM30","TeauMaxMM30")
dbsonde830MMReg$date <- as.Date(dbsonde830MMReg$date,origin="1970-01-01")
dbsonde830MMReg <- dbsonde830MMReg[is.na(dbsonde830MMReg$TeauMinMM30)==F,]
dbsonde830MMReg$t = 1:nrow(dbsonde830MMReg)
dbsonde830MMReg$regMinMM30 = lm(TeauMinMM30~t,data= dbsonde830MMReg)$fitted.values
dbsonde830MMReg$regMaxMM30 = lm(TeauMaxMM30~t,data= dbsonde830MMReg)$fitted.values
dbsonde830MMReg = dbsonde830MMReg[,-c(2:4)]


dbsonde830MM=merge(dbsonde830MM,dbsonde830MMReg,by="date",all.x=T)


# Calcule droite de régression MM365
dbsonde830MMReg <- as.data.frame(cbind(dbsonde830MM$date,dbsonde830MM$TeauMinMM365,dbsonde830MM$TeauMaxMM365))
colnames(dbsonde830MMReg)=c("date","TeauMinMM365","TeauMaxMM365")
dbsonde830MMReg$date <- as.Date(dbsonde830MMReg$date,origin="1970-01-01")
dbsonde830MMReg <- dbsonde830MMReg[is.na(dbsonde830MMReg$TeauMinMM365)==F,]
dbsonde830MMReg$t = 1:nrow(dbsonde830MMReg)
dbsonde830MMReg$regMinMM365 = lm(TeauMinMM365~t,data= dbsonde830MMReg)$fitted.values
dbsonde830MMReg$regMaxMM365 = lm(TeauMaxMM365~t,data= dbsonde830MMReg)$fitted.values
dbsonde830MMReg = dbsonde830MMReg[,-c(2:4)]
dbsonde830MM=merge(dbsonde830MM,dbsonde830MMReg,by="date",all.x=T)


db_xts_sonde830 = dbsonde830MM[, c(FALSE, FALSE, rep(T,ncol(dbsonde830MM)-2))] # pour garder que les colonnes / series de températures à transformer
db_xts_date830 = dbsonde830MM$date
db_xts_sonde830 = xts(db_xts_sonde830, order.by=db_xts_date830)
db_xts_sonde830a =  db_xts_sonde830[,c(1,4,2,5,11,8)]
db_xts_sonde830b = db_xts_sonde830[,c(6,12,9,17,18)]
db_xts_sonde830b = db_xts_sonde830b[is.na(db_xts_sonde830b$TeauMinMM30)==F,]
db_xts_sonde830c = db_xts_sonde830[,c(7,13,10,19,20)]
db_xts_sonde830c = db_xts_sonde830c[is.na(db_xts_sonde830c$TeauMinMM365)==F,]

rm(dbsonde830MMReg)




rm(dbsonde825MM,dbsonde827MM,dbsonde828MM,dbsonde830MM,
   db_xts_date825,db_xts_date827,db_xts_date828,db_xts_date830)
## db_Touques_xtsa, db_Touques_xtsb, db_Touques_xtsc, db_Touquesb ----

db_xts_sonde825a$id_sonde = 825
db_xts_sonde827a$id_sonde = 827
db_xts_sonde828a$id_sonde = 828
db_xts_sonde830a$id_sonde = 830



db_Touques_xtsa = rbind(db_xts_sonde825a,db_xts_sonde827a,db_xts_sonde828a,db_xts_sonde830a)

db_xts_sonde825b$id_sonde = 825
db_xts_sonde827b$id_sonde = 827
db_xts_sonde828b$id_sonde = 828
db_xts_sonde830b$id_sonde = 830

db_Touques_xtsb = rbind(db_xts_sonde825b,db_xts_sonde827b,db_xts_sonde828b,db_xts_sonde830b)

db_xts_sonde825c$id_sonde = 825
db_xts_sonde827c$id_sonde = 827
db_xts_sonde828c$id_sonde = 828
db_xts_sonde830c$id_sonde = 830

db_Touques_xtsc = rbind(db_xts_sonde825c,db_xts_sonde827c,db_xts_sonde828c,db_xts_sonde830c)


nameCola = c("Température minimale","Température moyenne","Température maximale",
             "Température minimale MM7","Température moyenne MM7","Température maximale MM7","id_sonde")
colnames(db_Touques_xtsa)=nameCola

nameColb = c("Température minimale MM30","Température moyenne MM30","Température maximale MM30",
             "Régression températures min","Régression températures max","id_sonde")
colnames(db_Touques_xtsb)=nameColb

nameColc = c("Température minimale MM365","Température moyenne MM365","Température maximale MM365",
             "Régression températures min","Régression températures max","id_sonde")
colnames(db_Touques_xtsc) = nameColc


db_Touquesb = as.data.frame(db_Touques_xtsb)

# SONDE ORNE ----
# sonde 817 ----
dbsonde817MM <- dbMM[dbMM$id_sonde==817,]

# Calcule droite de régression MM30
dbsonde817MMReg <- as.data.frame(cbind(dbsonde817MM$date,dbsonde817MM$TeauMinMM30,dbsonde817MM$TeauMaxMM30))
colnames(dbsonde817MMReg)=c("date","TeauMinMM30","TeauMaxMM30")
dbsonde817MMReg$date <- as.Date(dbsonde817MMReg$date,origin="1970-01-01")
dbsonde817MMReg <- dbsonde817MMReg[is.na(dbsonde817MMReg$TeauMinMM30)==F,]
dbsonde817MMReg$t = 1:nrow(dbsonde817MMReg)
dbsonde817MMReg$regMinMM30 = lm(TeauMinMM30~t,data= dbsonde817MMReg)$fitted.values
dbsonde817MMReg$regMaxMM30 = lm(TeauMaxMM30~t,data= dbsonde817MMReg)$fitted.values
dbsonde817MMReg = dbsonde817MMReg[,-c(2:4)]


dbsonde817MM=merge(dbsonde817MM,dbsonde817MMReg,by="date",all.x=T)


# Calcule droite de régression MM365
dbsonde817MMReg <- as.data.frame(cbind(dbsonde817MM$date,dbsonde817MM$TeauMinMM365,dbsonde817MM$TeauMaxMM365))
colnames(dbsonde817MMReg)=c("date","TeauMinMM365","TeauMaxMM365")
dbsonde817MMReg$date <- as.Date(dbsonde817MMReg$date,origin="1970-01-01")
dbsonde817MMReg <- dbsonde817MMReg[is.na(dbsonde817MMReg$TeauMinMM365)==F,]
dbsonde817MMReg$t = 1:nrow(dbsonde817MMReg)
dbsonde817MMReg$regMinMM365 = lm(TeauMinMM365~t,data= dbsonde817MMReg)$fitted.values
dbsonde817MMReg$regMaxMM365 = lm(TeauMaxMM365~t,data= dbsonde817MMReg)$fitted.values
dbsonde817MMReg = dbsonde817MMReg[,-c(2:4)]
dbsonde817MM=merge(dbsonde817MM,dbsonde817MMReg,by="date",all.x=T)


db_xts_sonde817 = dbsonde817MM[, c(FALSE, FALSE, rep(T,ncol(dbsonde817MM)-2))] # pour garder que les colonnes / series de températures à transformer
db_xts_date817 = dbsonde817MM$date
db_xts_sonde817 = xts(db_xts_sonde817, order.by=db_xts_date817)
db_xts_sonde817a =  db_xts_sonde817[,c(1,4,2,5,11,8)]
db_xts_sonde817b = db_xts_sonde817[,c(6,12,9,17,18)]
db_xts_sonde817b = db_xts_sonde817b[is.na(db_xts_sonde817b$TeauMinMM30)==F,]
db_xts_sonde817c = db_xts_sonde817[,c(7,13,10,19,20)]
db_xts_sonde817c = db_xts_sonde817c[is.na(db_xts_sonde817c$TeauMinMM365)==F,]

rm(dbsonde817MMReg)



# sonde 818 ----
dbsonde818MM <- dbMM[dbMM$id_sonde==818,]

# Calcule droite de régression MM30
dbsonde818MMReg <- as.data.frame(cbind(dbsonde818MM$date,dbsonde818MM$TeauMinMM30,dbsonde818MM$TeauMaxMM30))
colnames(dbsonde818MMReg)=c("date","TeauMinMM30","TeauMaxMM30")
dbsonde818MMReg$date <- as.Date(dbsonde818MMReg$date,origin="1970-01-01")
dbsonde818MMReg <- dbsonde818MMReg[is.na(dbsonde818MMReg$TeauMinMM30)==F,]
dbsonde818MMReg$t = 1:nrow(dbsonde818MMReg)
dbsonde818MMReg$regMinMM30 = lm(TeauMinMM30~t,data= dbsonde818MMReg)$fitted.values
dbsonde818MMReg$regMaxMM30 = lm(TeauMaxMM30~t,data= dbsonde818MMReg)$fitted.values
dbsonde818MMReg = dbsonde818MMReg[,-c(2:4)]


dbsonde818MM=merge(dbsonde818MM,dbsonde818MMReg,by="date",all.x=T)


# Calcule droite de régression MM365
dbsonde818MMReg <- as.data.frame(cbind(dbsonde818MM$date,dbsonde818MM$TeauMinMM365,dbsonde818MM$TeauMaxMM365))
colnames(dbsonde818MMReg)=c("date","TeauMinMM365","TeauMaxMM365")
dbsonde818MMReg$date <- as.Date(dbsonde818MMReg$date,origin="1970-01-01")
dbsonde818MMReg <- dbsonde818MMReg[is.na(dbsonde818MMReg$TeauMinMM365)==F,]
dbsonde818MMReg$t = 1:nrow(dbsonde818MMReg)
dbsonde818MMReg$regMinMM365 = lm(TeauMinMM365~t,data= dbsonde818MMReg)$fitted.values
dbsonde818MMReg$regMaxMM365 = lm(TeauMaxMM365~t,data= dbsonde818MMReg)$fitted.values
dbsonde818MMReg = dbsonde818MMReg[,-c(2:4)]
dbsonde818MM=merge(dbsonde818MM,dbsonde818MMReg,by="date",all.x=T)


db_xts_sonde818 = dbsonde818MM[, c(FALSE, FALSE, rep(T,ncol(dbsonde818MM)-2))] # pour garder que les colonnes / series de températures à transformer
db_xts_date818 = dbsonde818MM$date
db_xts_sonde818 = xts(db_xts_sonde818, order.by=db_xts_date818)
db_xts_sonde818a =  db_xts_sonde818[,c(1,4,2,5,11,8)]
db_xts_sonde818b = db_xts_sonde818[,c(6,12,9,17,18)]
db_xts_sonde818b = db_xts_sonde818b[is.na(db_xts_sonde818b$TeauMinMM30)==F,]
db_xts_sonde818c = db_xts_sonde818[,c(7,13,10,19,20)]
db_xts_sonde818c = db_xts_sonde818c[is.na(db_xts_sonde818c$TeauMinMM365)==F,]

rm(dbsonde818MMReg)

# sonde 819 ----
dbsonde819MM <- dbMM[dbMM$id_sonde==819,]

# Calcule droite de régression MM30
dbsonde819MMReg <- as.data.frame(cbind(dbsonde819MM$date,dbsonde819MM$TeauMinMM30,dbsonde819MM$TeauMaxMM30))
colnames(dbsonde819MMReg)=c("date","TeauMinMM30","TeauMaxMM30")
dbsonde819MMReg$date <- as.Date(dbsonde819MMReg$date,origin="1970-01-01")
dbsonde819MMReg <- dbsonde819MMReg[is.na(dbsonde819MMReg$TeauMinMM30)==F,]
dbsonde819MMReg$t = 1:nrow(dbsonde819MMReg)
dbsonde819MMReg$regMinMM30 = lm(TeauMinMM30~t,data= dbsonde819MMReg)$fitted.values
dbsonde819MMReg$regMaxMM30 = lm(TeauMaxMM30~t,data= dbsonde819MMReg)$fitted.values
dbsonde819MMReg = dbsonde819MMReg[,-c(2:4)]


dbsonde819MM=merge(dbsonde819MM,dbsonde819MMReg,by="date",all.x=T)


# Calcule droite de régression MM365
dbsonde819MMReg <- as.data.frame(cbind(dbsonde819MM$date,dbsonde819MM$TeauMinMM365,dbsonde819MM$TeauMaxMM365))
colnames(dbsonde819MMReg)=c("date","TeauMinMM365","TeauMaxMM365")
dbsonde819MMReg$date <- as.Date(dbsonde819MMReg$date,origin="1970-01-01")
dbsonde819MMReg <- dbsonde819MMReg[is.na(dbsonde819MMReg$TeauMinMM365)==F,]
dbsonde819MMReg$t = 1:nrow(dbsonde819MMReg)
dbsonde819MMReg$regMinMM365 = lm(TeauMinMM365~t,data= dbsonde819MMReg)$fitted.values
dbsonde819MMReg$regMaxMM365 = lm(TeauMaxMM365~t,data= dbsonde819MMReg)$fitted.values
dbsonde819MMReg = dbsonde819MMReg[,-c(2:4)]
dbsonde819MM=merge(dbsonde819MM,dbsonde819MMReg,by="date",all.x=T)


db_xts_sonde819 = dbsonde819MM[, c(FALSE, FALSE, rep(T,ncol(dbsonde819MM)-2))] # pour garder que les colonnes / series de températures à transformer
db_xts_date819 = dbsonde819MM$date
db_xts_sonde819 = xts(db_xts_sonde819, order.by=db_xts_date819)
db_xts_sonde819a =  db_xts_sonde819[,c(1,4,2,5,11,8)]
db_xts_sonde819b = db_xts_sonde819[,c(6,12,9,17,18)]
db_xts_sonde819b = db_xts_sonde819b[is.na(db_xts_sonde819b$TeauMinMM30)==F,]
db_xts_sonde819c = db_xts_sonde819[,c(7,13,10,19,20)]
db_xts_sonde819c = db_xts_sonde819c[is.na(db_xts_sonde819c$TeauMinMM365)==F,]

rm(dbsonde819MMReg)


rm(dbsonde817MM,dbsonde818MM,dbsonde819MM,dbsonde830MM,
   db_xts_date817,db_xts_date818,db_xts_date819,db_xts_date830)
## db_Orne_xtsa, db_Orne_xtsb, db_Orne_xtsc ----
db_xts_sonde817a$id_sonde = 817
db_xts_sonde818a$id_sonde = 818
db_xts_sonde819a$id_sonde = 819

db_Orne_xtsa = rbind(db_xts_sonde817a,db_xts_sonde818a,db_xts_sonde819a)

db_xts_sonde817b$id_sonde = 817
db_xts_sonde818b$id_sonde = 818
db_xts_sonde819b$id_sonde = 819

db_Orne_xtsb = rbind(db_xts_sonde817b,db_xts_sonde818b,db_xts_sonde819b)

db_xts_sonde817c$id_sonde = 817
db_xts_sonde818c$id_sonde = 818
db_xts_sonde819c$id_sonde = 819

db_Orne_xtsc = rbind(db_xts_sonde817c,db_xts_sonde818c,db_xts_sonde819c)
# SONDE ODON ----
# sonde 812 ----
dbsonde812MM <- dbMM[dbMM$id_sonde==812,]

# Calcule droite de régression MM30
dbsonde812MMReg <- as.data.frame(cbind(dbsonde812MM$date,dbsonde812MM$TeauMinMM30,dbsonde812MM$TeauMaxMM30))
colnames(dbsonde812MMReg)=c("date","TeauMinMM30","TeauMaxMM30")
dbsonde812MMReg$date <- as.Date(dbsonde812MMReg$date,origin="1970-01-01")
dbsonde812MMReg <- dbsonde812MMReg[is.na(dbsonde812MMReg$TeauMinMM30)==F,]
dbsonde812MMReg$t = 1:nrow(dbsonde812MMReg)
dbsonde812MMReg$regMinMM30 = lm(TeauMinMM30~t,data= dbsonde812MMReg)$fitted.values
dbsonde812MMReg$regMaxMM30 = lm(TeauMaxMM30~t,data= dbsonde812MMReg)$fitted.values
dbsonde812MMReg = dbsonde812MMReg[,-c(2:4)]


dbsonde812MM=merge(dbsonde812MM,dbsonde812MMReg,by="date",all.x=T)


# Calcule droite de régression MM365
dbsonde812MMReg <- as.data.frame(cbind(dbsonde812MM$date,dbsonde812MM$TeauMinMM365,dbsonde812MM$TeauMaxMM365))
colnames(dbsonde812MMReg)=c("date","TeauMinMM365","TeauMaxMM365")
dbsonde812MMReg$date <- as.Date(dbsonde812MMReg$date,origin="1970-01-01")
dbsonde812MMReg <- dbsonde812MMReg[is.na(dbsonde812MMReg$TeauMinMM365)==F,]
dbsonde812MMReg$t = 1:nrow(dbsonde812MMReg)
dbsonde812MMReg$regMinMM365 = lm(TeauMinMM365~t,data= dbsonde812MMReg)$fitted.values
dbsonde812MMReg$regMaxMM365 = lm(TeauMaxMM365~t,data= dbsonde812MMReg)$fitted.values
dbsonde812MMReg = dbsonde812MMReg[,-c(2:4)]
dbsonde812MM=merge(dbsonde812MM,dbsonde812MMReg,by="date",all.x=T)


db_xts_sonde812 = dbsonde812MM[, c(FALSE, FALSE, rep(T,ncol(dbsonde812MM)-2))] # pour garder que les colonnes / series de températures à transformer
db_xts_date812 = dbsonde812MM$date
db_xts_sonde812 = xts(db_xts_sonde812, order.by=db_xts_date812)
db_xts_sonde812a =  db_xts_sonde812[,c(1,4,2,5,11,8)]
db_xts_sonde812b = db_xts_sonde812[,c(6,12,9,17,18)]
db_xts_sonde812b = db_xts_sonde812b[is.na(db_xts_sonde812b$TeauMinMM30)==F,]
db_xts_sonde812c = db_xts_sonde812[,c(7,13,10,19,20)]
db_xts_sonde812c = db_xts_sonde812c[is.na(db_xts_sonde812c$TeauMinMM365)==F,]

rm(dbsonde812MMReg)



# sonde 813 ----
dbsonde813MM <- dbMM[dbMM$id_sonde==813,]

# Calcule droite de régression MM30
dbsonde813MMReg <- as.data.frame(cbind(dbsonde813MM$date,dbsonde813MM$TeauMinMM30,dbsonde813MM$TeauMaxMM30))
colnames(dbsonde813MMReg)=c("date","TeauMinMM30","TeauMaxMM30")
dbsonde813MMReg$date <- as.Date(dbsonde813MMReg$date,origin="1970-01-01")
dbsonde813MMReg <- dbsonde813MMReg[is.na(dbsonde813MMReg$TeauMinMM30)==F,]
dbsonde813MMReg$t = 1:nrow(dbsonde813MMReg)
dbsonde813MMReg$regMinMM30 = lm(TeauMinMM30~t,data= dbsonde813MMReg)$fitted.values
dbsonde813MMReg$regMaxMM30 = lm(TeauMaxMM30~t,data= dbsonde813MMReg)$fitted.values
dbsonde813MMReg = dbsonde813MMReg[,-c(2:4)]


dbsonde813MM=merge(dbsonde813MM,dbsonde813MMReg,by="date",all.x=T)


# Calcule droite de régression MM365
dbsonde813MMReg <- as.data.frame(cbind(dbsonde813MM$date,dbsonde813MM$TeauMinMM365,dbsonde813MM$TeauMaxMM365))
colnames(dbsonde813MMReg)=c("date","TeauMinMM365","TeauMaxMM365")
dbsonde813MMReg$date <- as.Date(dbsonde813MMReg$date,origin="1970-01-01")
dbsonde813MMReg <- dbsonde813MMReg[is.na(dbsonde813MMReg$TeauMinMM365)==F,]
dbsonde813MMReg$t = 1:nrow(dbsonde813MMReg)
dbsonde813MMReg$regMinMM365 = lm(TeauMinMM365~t,data= dbsonde813MMReg)$fitted.values
dbsonde813MMReg$regMaxMM365 = lm(TeauMaxMM365~t,data= dbsonde813MMReg)$fitted.values
dbsonde813MMReg = dbsonde813MMReg[,-c(2:4)]
dbsonde813MM=merge(dbsonde813MM,dbsonde813MMReg,by="date",all.x=T)


db_xts_sonde813 = dbsonde813MM[, c(FALSE, FALSE, rep(T,ncol(dbsonde813MM)-2))] # pour garder que les colonnes / series de températures à transformer
db_xts_date813 = dbsonde813MM$date
db_xts_sonde813 = xts(db_xts_sonde813, order.by=db_xts_date813)
db_xts_sonde813a =  db_xts_sonde813[,c(1,4,2,5,8,11)]
db_xts_sonde813b = db_xts_sonde813[,c(6,12,9,17,18)]
db_xts_sonde813b = db_xts_sonde813b[is.na(db_xts_sonde813b$TeauMinMM30)==F,]
db_xts_sonde813c = db_xts_sonde813[,c(7,13,10,19,20)]
db_xts_sonde813c = db_xts_sonde813c[is.na(db_xts_sonde813c$TeauMinMM365)==F,]

rm(dbsonde813MMReg)

# sonde 815 ----
dbsonde815MM <- dbMM[dbMM$id_sonde==815,]

# Calcule droite de régression MM30
dbsonde815MMReg <- as.data.frame(cbind(dbsonde815MM$date,dbsonde815MM$TeauMinMM30,dbsonde815MM$TeauMaxMM30))
colnames(dbsonde815MMReg)=c("date","TeauMinMM30","TeauMaxMM30")
dbsonde815MMReg$date <- as.Date(dbsonde815MMReg$date,origin="1970-01-01")
dbsonde815MMReg <- dbsonde815MMReg[is.na(dbsonde815MMReg$TeauMinMM30)==F,]
dbsonde815MMReg$t = 1:nrow(dbsonde815MMReg)
dbsonde815MMReg$regMinMM30 = lm(TeauMinMM30~t,data= dbsonde815MMReg)$fitted.values
dbsonde815MMReg$regMaxMM30 = lm(TeauMaxMM30~t,data= dbsonde815MMReg)$fitted.values
dbsonde815MMReg = dbsonde815MMReg[,-c(2:4)]


dbsonde815MM=merge(dbsonde815MM,dbsonde815MMReg,by="date",all.x=T)


# Calcule droite de régression MM365
dbsonde815MMReg <- as.data.frame(cbind(dbsonde815MM$date,dbsonde815MM$TeauMinMM365,dbsonde815MM$TeauMaxMM365))
colnames(dbsonde815MMReg)=c("date","TeauMinMM365","TeauMaxMM365")
dbsonde815MMReg$date <- as.Date(dbsonde815MMReg$date,origin="1970-01-01")
dbsonde815MMReg <- dbsonde815MMReg[is.na(dbsonde815MMReg$TeauMinMM365)==F,]
dbsonde815MMReg$t = 1:nrow(dbsonde815MMReg)
dbsonde815MMReg$regMinMM365 = lm(TeauMinMM365~t,data= dbsonde815MMReg)$fitted.values
dbsonde815MMReg$regMaxMM365 = lm(TeauMaxMM365~t,data= dbsonde815MMReg)$fitted.values
dbsonde815MMReg = dbsonde815MMReg[,-c(2:4)]
dbsonde815MM=merge(dbsonde815MM,dbsonde815MMReg,by="date",all.x=T)


db_xts_sonde815 = dbsonde815MM[, c(FALSE, FALSE, rep(T,ncol(dbsonde815MM)-2))] # pour garder que les colonnes / series de températures à transformer
db_xts_date815 = dbsonde815MM$date
db_xts_sonde815 = xts(db_xts_sonde815, order.by=db_xts_date815)
db_xts_sonde815a =  db_xts_sonde815[,c(1,4,2,5,11,8)]
db_xts_sonde815b = db_xts_sonde815[,c(6,12,9,17,18)]
db_xts_sonde815b = db_xts_sonde815b[is.na(db_xts_sonde815b$TeauMinMM30)==F,]
db_xts_sonde815c = db_xts_sonde815[,c(7,13,10,19,20)]
db_xts_sonde815c = db_xts_sonde815c[is.na(db_xts_sonde815c$TeauMinMM365)==F,]

rm(dbsonde815MMReg)

# sonde 816 ----
dbsonde816MM <- dbMM[dbMM$id_sonde==816,]

# Calcule droite de régression MM30
dbsonde816MMReg <- as.data.frame(cbind(dbsonde816MM$date,dbsonde816MM$TeauMinMM30,dbsonde816MM$TeauMaxMM30))
colnames(dbsonde816MMReg)=c("date","TeauMinMM30","TeauMaxMM30")
dbsonde816MMReg$date <- as.Date(dbsonde816MMReg$date,origin="1970-01-01")
dbsonde816MMReg <- dbsonde816MMReg[is.na(dbsonde816MMReg$TeauMinMM30)==F,]
dbsonde816MMReg$t = 1:nrow(dbsonde816MMReg)
dbsonde816MMReg$regMinMM30 = lm(TeauMinMM30~t,data= dbsonde816MMReg)$fitted.values
dbsonde816MMReg$regMaxMM30 = lm(TeauMaxMM30~t,data= dbsonde816MMReg)$fitted.values
dbsonde816MMReg = dbsonde816MMReg[,-c(2:4)]


dbsonde816MM=merge(dbsonde816MM,dbsonde816MMReg,by="date",all.x=T)


# Calcule droite de régression MM365
dbsonde816MMReg <- as.data.frame(cbind(dbsonde816MM$date,dbsonde816MM$TeauMinMM365,dbsonde816MM$TeauMaxMM365))
colnames(dbsonde816MMReg)=c("date","TeauMinMM365","TeauMaxMM365")
dbsonde816MMReg$date <- as.Date(dbsonde816MMReg$date,origin="1970-01-01")
dbsonde816MMReg <- dbsonde816MMReg[is.na(dbsonde816MMReg$TeauMinMM365)==F,]
dbsonde816MMReg$t = 1:nrow(dbsonde816MMReg)
dbsonde816MMReg$regMinMM365 = lm(TeauMinMM365~t,data= dbsonde816MMReg)$fitted.values
dbsonde816MMReg$regMaxMM365 = lm(TeauMaxMM365~t,data= dbsonde816MMReg)$fitted.values
dbsonde816MMReg = dbsonde816MMReg[,-c(2:4)]
dbsonde816MM=merge(dbsonde816MM,dbsonde816MMReg,by="date",all.x=T)


db_xts_sonde816 = dbsonde816MM[, c(FALSE, FALSE, rep(T,ncol(dbsonde816MM)-2))] # pour garder que les colonnes / series de températures à transformer
db_xts_date816 = dbsonde816MM$date
db_xts_sonde816 = xts(db_xts_sonde816, order.by=db_xts_date816)
db_xts_sonde816a =  db_xts_sonde816[,c(1,4,2,5,11,8)]
db_xts_sonde816b = db_xts_sonde816[,c(6,12,9,17,18)]
db_xts_sonde816b = db_xts_sonde816b[is.na(db_xts_sonde816b$TeauMinMM30)==F,]
db_xts_sonde816c = db_xts_sonde816[,c(7,13,10,19,20)]
db_xts_sonde816c = db_xts_sonde816c[is.na(db_xts_sonde816c$TeauMinMM365)==F,]

rm(dbsonde816MMReg)

rm(dbsonde812MM,dbsonde813MM,dbsonde815MM,dbsonde816MM,
   db_xts_date812,db_xts_date813,db_xts_date815,db_xts_date816)

## db_Odon_xtsa, db_Odon_xtsb, db_Odon_xtsc ----
db_xts_sonde812a$id_sonde = 812
db_xts_sonde813a$id_sonde = 813
db_xts_sonde815a$id_sonde = 815
db_xts_sonde816a$id_sonde = 816

db_Odon_xtsa = rbind(db_xts_sonde812a,db_xts_sonde813a,db_xts_sonde815a,db_xts_sonde816a)

db_xts_sonde812b$id_sonde = 812
db_xts_sonde813b$id_sonde = 813
db_xts_sonde815b$id_sonde = 815
db_xts_sonde816b$id_sonde = 816

db_Odon_xtsb = rbind(db_xts_sonde812b,db_xts_sonde813b,db_xts_sonde815b,db_xts_sonde816b)

db_xts_sonde812c$id_sonde = 812
db_xts_sonde813c$id_sonde = 813
db_xts_sonde815c$id_sonde = 815
db_xts_sonde816c$id_sonde = 816

db_Odon_xtsc = rbind(db_xts_sonde812c,db_xts_sonde813c,db_xts_sonde815c,db_xts_sonde816c)
# SONDE SÉLUNE ----
# sonde 824 ----
dbsonde824MM <- dbMM[dbMM$id_sonde==824,]

# Calcule droite de régression MM30
dbsonde824MMReg <- as.data.frame(cbind(dbsonde824MM$date,dbsonde824MM$TeauMinMM30,dbsonde824MM$TeauMaxMM30))
colnames(dbsonde824MMReg)=c("date","TeauMinMM30","TeauMaxMM30")
dbsonde824MMReg$date <- as.Date(dbsonde824MMReg$date,origin="1970-01-01")
dbsonde824MMReg <- dbsonde824MMReg[is.na(dbsonde824MMReg$TeauMinMM30)==F,]
dbsonde824MMReg$t = 1:nrow(dbsonde824MMReg)
dbsonde824MMReg$regMinMM30 = lm(TeauMinMM30~t,data= dbsonde824MMReg)$fitted.values
dbsonde824MMReg$regMaxMM30 = lm(TeauMaxMM30~t,data= dbsonde824MMReg)$fitted.values
dbsonde824MMReg = dbsonde824MMReg[,-c(2:4)]


dbsonde824MM=merge(dbsonde824MM,dbsonde824MMReg,by="date",all.x=T)


# Calcule droite de régression MM365
dbsonde824MMReg <- as.data.frame(cbind(dbsonde824MM$date,dbsonde824MM$TeauMinMM365,dbsonde824MM$TeauMaxMM365))
colnames(dbsonde824MMReg)=c("date","TeauMinMM365","TeauMaxMM365")
dbsonde824MMReg$date <- as.Date(dbsonde824MMReg$date,origin="1970-01-01")
dbsonde824MMReg <- dbsonde824MMReg[is.na(dbsonde824MMReg$TeauMinMM365)==F,]
dbsonde824MMReg$t = 1:nrow(dbsonde824MMReg)
dbsonde824MMReg$regMinMM365 = lm(TeauMinMM365~t,data= dbsonde824MMReg)$fitted.values
dbsonde824MMReg$regMaxMM365 = lm(TeauMaxMM365~t,data= dbsonde824MMReg)$fitted.values
dbsonde824MMReg = dbsonde824MMReg[,-c(2:4)]
dbsonde824MM=merge(dbsonde824MM,dbsonde824MMReg,by="date",all.x=T)


db_xts_sonde824 = dbsonde824MM[, c(FALSE, FALSE, rep(T,ncol(dbsonde824MM)-2))] # pour garder que les colonnes / series de températures à transformer
db_xts_date824 = dbsonde824MM$date
db_xts_sonde824 = xts(db_xts_sonde824, order.by=db_xts_date824)
db_xts_sonde824a =  db_xts_sonde824[,c(1,4,2,5,11,8)]
db_xts_sonde824b = db_xts_sonde824[,c(6,12,9,17,18)]
db_xts_sonde824b = db_xts_sonde824b[is.na(db_xts_sonde824b$TeauMinMM30)==F,]
db_xts_sonde824c = db_xts_sonde824[,c(7,13,10,19,20)]
db_xts_sonde824c = db_xts_sonde824c[is.na(db_xts_sonde824c$TeauMinMM365)==F,]

rm(dbsonde824MMReg)



# sonde 821 ----
dbsonde821MM <- dbMM[dbMM$id_sonde==821,]

# Calcule droite de régression MM30
dbsonde821MMReg <- as.data.frame(cbind(dbsonde821MM$date,dbsonde821MM$TeauMinMM30,dbsonde821MM$TeauMaxMM30))
colnames(dbsonde821MMReg)=c("date","TeauMinMM30","TeauMaxMM30")
dbsonde821MMReg$date <- as.Date(dbsonde821MMReg$date,origin="1970-01-01")
dbsonde821MMReg <- dbsonde821MMReg[is.na(dbsonde821MMReg$TeauMinMM30)==F,]
dbsonde821MMReg$t = 1:nrow(dbsonde821MMReg)
dbsonde821MMReg$regMinMM30 = lm(TeauMinMM30~t,data= dbsonde821MMReg)$fitted.values
dbsonde821MMReg$regMaxMM30 = lm(TeauMaxMM30~t,data= dbsonde821MMReg)$fitted.values
dbsonde821MMReg = dbsonde821MMReg[,-c(2:4)]


dbsonde821MM=merge(dbsonde821MM,dbsonde821MMReg,by="date",all.x=T)


# Calcule droite de régression MM365
dbsonde821MMReg <- as.data.frame(cbind(dbsonde821MM$date,dbsonde821MM$TeauMinMM365,dbsonde821MM$TeauMaxMM365))
colnames(dbsonde821MMReg)=c("date","TeauMinMM365","TeauMaxMM365")
dbsonde821MMReg$date <- as.Date(dbsonde821MMReg$date,origin="1970-01-01")
dbsonde821MMReg <- dbsonde821MMReg[is.na(dbsonde821MMReg$TeauMinMM365)==F,]
dbsonde821MMReg$t = 1:nrow(dbsonde821MMReg)
dbsonde821MMReg$regMinMM365 = lm(TeauMinMM365~t,data= dbsonde821MMReg)$fitted.values
dbsonde821MMReg$regMaxMM365 = lm(TeauMaxMM365~t,data= dbsonde821MMReg)$fitted.values
dbsonde821MMReg = dbsonde821MMReg[,-c(2:4)]
dbsonde821MM=merge(dbsonde821MM,dbsonde821MMReg,by="date",all.x=T)


db_xts_sonde821 = dbsonde821MM[, c(FALSE, FALSE, rep(T,ncol(dbsonde821MM)-2))] # pour garder que les colonnes / series de températures à transformer
db_xts_date821 = dbsonde821MM$date
db_xts_sonde821 = xts(db_xts_sonde821, order.by=db_xts_date821)
db_xts_sonde821a =  db_xts_sonde821[,c(1,4,2,5,11,8)]
db_xts_sonde821b = db_xts_sonde821[,c(6,12,9,17,18)]
db_xts_sonde821b = db_xts_sonde821b[is.na(db_xts_sonde821b$TeauMinMM30)==F,]
db_xts_sonde821c = db_xts_sonde821[,c(7,13,10,19,20)]
db_xts_sonde821c = db_xts_sonde821c[is.na(db_xts_sonde821c$TeauMinMM365)==F,]

rm(dbsonde821MMReg)

# sonde 822 ----
dbsonde822MM <- dbMM[dbMM$id_sonde==822,]

# Calcule droite de régression MM30
dbsonde822MMReg <- as.data.frame(cbind(dbsonde822MM$date,dbsonde822MM$TeauMinMM30,dbsonde822MM$TeauMaxMM30))
colnames(dbsonde822MMReg)=c("date","TeauMinMM30","TeauMaxMM30")
dbsonde822MMReg$date <- as.Date(dbsonde822MMReg$date,origin="1970-01-01")
dbsonde822MMReg <- dbsonde822MMReg[is.na(dbsonde822MMReg$TeauMinMM30)==F,]
dbsonde822MMReg$t = 1:nrow(dbsonde822MMReg)
dbsonde822MMReg$regMinMM30 = lm(TeauMinMM30~t,data= dbsonde822MMReg)$fitted.values
dbsonde822MMReg$regMaxMM30 = lm(TeauMaxMM30~t,data= dbsonde822MMReg)$fitted.values
dbsonde822MMReg = dbsonde822MMReg[,-c(2:4)]


dbsonde822MM=merge(dbsonde822MM,dbsonde822MMReg,by="date",all.x=T)


# Calcule droite de régression MM365
dbsonde822MMReg <- as.data.frame(cbind(dbsonde822MM$date,dbsonde822MM$TeauMinMM365,dbsonde822MM$TeauMaxMM365))
colnames(dbsonde822MMReg)=c("date","TeauMinMM365","TeauMaxMM365")
dbsonde822MMReg$date <- as.Date(dbsonde822MMReg$date,origin="1970-01-01")
dbsonde822MMReg <- dbsonde822MMReg[is.na(dbsonde822MMReg$TeauMinMM365)==F,]
dbsonde822MMReg$t = 1:nrow(dbsonde822MMReg)
dbsonde822MMReg$regMinMM365 = lm(TeauMinMM365~t,data= dbsonde822MMReg)$fitted.values
dbsonde822MMReg$regMaxMM365 = lm(TeauMaxMM365~t,data= dbsonde822MMReg)$fitted.values
dbsonde822MMReg = dbsonde822MMReg[,-c(2:4)]
dbsonde822MM=merge(dbsonde822MM,dbsonde822MMReg,by="date",all.x=T)


db_xts_sonde822 = dbsonde822MM[, c(FALSE, FALSE, rep(T,ncol(dbsonde822MM)-2))] # pour garder que les colonnes / series de températures à transformer
db_xts_date822 = dbsonde822MM$date
db_xts_sonde822 = xts(db_xts_sonde822, order.by=db_xts_date822)
db_xts_sonde822a =  db_xts_sonde822[,c(1,4,2,5,11,8)]
db_xts_sonde822b = db_xts_sonde822[,c(6,12,9,17,18)]
db_xts_sonde822b = db_xts_sonde822b[is.na(db_xts_sonde822b$TeauMinMM30)==F,]
db_xts_sonde822c = db_xts_sonde822[,c(7,13,10,19,20)]
db_xts_sonde822c = db_xts_sonde822c[is.na(db_xts_sonde822c$TeauMinMM365)==F,]

rm(dbsonde822MMReg)

# sonde 820 ----
dbsonde820MM <- dbMM[dbMM$id_sonde==820,]

# Calcule droite de régression MM30
dbsonde820MMReg <- as.data.frame(cbind(dbsonde820MM$date,dbsonde820MM$TeauMinMM30,dbsonde820MM$TeauMaxMM30))
colnames(dbsonde820MMReg)=c("date","TeauMinMM30","TeauMaxMM30")
dbsonde820MMReg$date <- as.Date(dbsonde820MMReg$date,origin="1970-01-01")
dbsonde820MMReg <- dbsonde820MMReg[is.na(dbsonde820MMReg$TeauMinMM30)==F,]
dbsonde820MMReg$t = 1:nrow(dbsonde820MMReg)
dbsonde820MMReg$regMinMM30 = lm(TeauMinMM30~t,data= dbsonde820MMReg)$fitted.values
dbsonde820MMReg$regMaxMM30 = lm(TeauMaxMM30~t,data= dbsonde820MMReg)$fitted.values
dbsonde820MMReg = dbsonde820MMReg[,-c(2:4)]


dbsonde820MM=merge(dbsonde820MM,dbsonde820MMReg,by="date",all.x=T)


# Calcule droite de régression MM365
dbsonde820MMReg <- as.data.frame(cbind(dbsonde820MM$date,dbsonde820MM$TeauMinMM365,dbsonde820MM$TeauMaxMM365))
colnames(dbsonde820MMReg)=c("date","TeauMinMM365","TeauMaxMM365")
dbsonde820MMReg$date <- as.Date(dbsonde820MMReg$date,origin="1970-01-01")
dbsonde820MMReg <- dbsonde820MMReg[is.na(dbsonde820MMReg$TeauMinMM365)==F,]
dbsonde820MMReg$t = 1:nrow(dbsonde820MMReg)
dbsonde820MMReg$regMinMM365 = lm(TeauMinMM365~t,data= dbsonde820MMReg)$fitted.values
dbsonde820MMReg$regMaxMM365 = lm(TeauMaxMM365~t,data= dbsonde820MMReg)$fitted.values
dbsonde820MMReg = dbsonde820MMReg[,-c(2:4)]
dbsonde820MM=merge(dbsonde820MM,dbsonde820MMReg,by="date",all.x=T)


db_xts_sonde820 = dbsonde820MM[, c(FALSE, FALSE, rep(T,ncol(dbsonde820MM)-2))] # pour garder que les colonnes / series de températures à transformer
db_xts_date820 = dbsonde820MM$date
db_xts_sonde820 = xts(db_xts_sonde820, order.by=db_xts_date820)
db_xts_sonde820a =  db_xts_sonde820[,c(1,4,2,5,11,8)]
db_xts_sonde820b = db_xts_sonde820[,c(6,12,9,17,18)]
db_xts_sonde820b = db_xts_sonde820b[is.na(db_xts_sonde820b$TeauMinMM30)==F,]
db_xts_sonde820c = db_xts_sonde820[,c(7,13,10,19,20)]
db_xts_sonde820c = db_xts_sonde820c[is.na(db_xts_sonde820c$TeauMinMM365)==F,]

rm(dbsonde820MMReg)

rm(dbsonde824MM,dbsonde821MM,dbsonde822MM,dbsonde820MM,
   db_xts_date824,db_xts_date821,db_xts_date822,db_xts_date820)


# sonde 823 ----
dbsonde823MM <- dbMM[dbMM$id_sonde==823,]

# Calcule droite de régression MM30
dbsonde823MMReg <- as.data.frame(cbind(dbsonde823MM$date,dbsonde823MM$TeauMinMM30,dbsonde823MM$TeauMaxMM30))
colnames(dbsonde823MMReg)=c("date","TeauMinMM30","TeauMaxMM30")
dbsonde823MMReg$date <- as.Date(dbsonde823MMReg$date,origin="1970-01-01")
dbsonde823MMReg <- dbsonde823MMReg[is.na(dbsonde823MMReg$TeauMinMM30)==F,]
dbsonde823MMReg$t = 1:nrow(dbsonde823MMReg)
dbsonde823MMReg$regMinMM30 = lm(TeauMinMM30~t,data= dbsonde823MMReg)$fitted.values
dbsonde823MMReg$regMaxMM30 = lm(TeauMaxMM30~t,data= dbsonde823MMReg)$fitted.values
dbsonde823MMReg = dbsonde823MMReg[,-c(2:4)]


dbsonde823MM=merge(dbsonde823MM,dbsonde823MMReg,by="date",all.x=T)


# Calcule droite de régression MM365
dbsonde823MMReg <- as.data.frame(cbind(dbsonde823MM$date,dbsonde823MM$TeauMinMM365,dbsonde823MM$TeauMaxMM365))
colnames(dbsonde823MMReg)=c("date","TeauMinMM365","TeauMaxMM365")
dbsonde823MMReg$date <- as.Date(dbsonde823MMReg$date,origin="1970-01-01")
dbsonde823MMReg <- dbsonde823MMReg[is.na(dbsonde823MMReg$TeauMinMM365)==F,]
dbsonde823MMReg$t = 1:nrow(dbsonde823MMReg)
dbsonde823MMReg$regMinMM365 = lm(TeauMinMM365~t,data= dbsonde823MMReg)$fitted.values
dbsonde823MMReg$regMaxMM365 = lm(TeauMaxMM365~t,data= dbsonde823MMReg)$fitted.values
dbsonde823MMReg = dbsonde823MMReg[,-c(2:4)]
dbsonde823MM=merge(dbsonde823MM,dbsonde823MMReg,by="date",all.x=T)


db_xts_sonde823 = dbsonde823MM[, c(FALSE, FALSE, rep(T,ncol(dbsonde823MM)-2))] # pour garder que les colonnes / series de températures à transformer
db_xts_date823 = dbsonde823MM$date
db_xts_sonde823 = xts(db_xts_sonde823, order.by=db_xts_date823)
db_xts_sonde823a =  db_xts_sonde823[,c(1,4,2,5,11,8)]
db_xts_sonde823b = db_xts_sonde823[,c(6,12,9,17,18)]
db_xts_sonde823b = db_xts_sonde823b[is.na(db_xts_sonde823b$TeauMinMM30)==F,]
db_xts_sonde823c = db_xts_sonde823[,c(7,13,10,19,20)]
db_xts_sonde823c = db_xts_sonde823c[is.na(db_xts_sonde823c$TeauMinMM365)==F,]

rm(dbsonde823MMReg)

rm(dbsonde824MM,dbsonde821MM,dbsonde822MM,dbsonde823MM,
   db_xts_date824,db_xts_date821,db_xts_date822,db_xts_date823)




## db_Selune_xtsa, db_Selune_xtsb, db_Selune_xtsc ----
db_xts_sonde820a$id_sonde = 820
db_xts_sonde821a$id_sonde = 821
db_xts_sonde822a$id_sonde = 822
db_xts_sonde823a$id_sonde = 823
db_xts_sonde824a$id_sonde = 824

db_Selune_xtsa = rbind(db_xts_sonde820a,db_xts_sonde821a,db_xts_sonde822a,db_xts_sonde823a,db_xts_sonde824a)

db_xts_sonde820b$id_sonde = 820
db_xts_sonde821b$id_sonde = 821
db_xts_sonde822b$id_sonde = 822
db_xts_sonde823b$id_sonde = 823
db_xts_sonde824b$id_sonde = 824

db_Selune_xtsb = rbind(db_xts_sonde820b,db_xts_sonde821b,db_xts_sonde822b,db_xts_sonde823b,db_xts_sonde824b)

db_xts_sonde820c$id_sonde = 820
db_xts_sonde821c$id_sonde = 821
db_xts_sonde822c$id_sonde = 822
db_xts_sonde823c$id_sonde = 823
db_xts_sonde824c$id_sonde = 824

db_Selune_xtsc = rbind(db_xts_sonde820c,db_xts_sonde821c,db_xts_sonde822c,db_xts_sonde823c,db_xts_sonde824c)







####################
# Stats avec MM30 pour tableau récap moyenne mensuelle et annuelles
####################

db_stats_MM30 = dbMM[,c( 1,2,8,11 )]

db_stats_MM30 = db_stats_MM30[
  is.na(db_stats_MM30$TeauMaxMM30)==F,
]



str(db_Touques_stats_MM30)



db_stats_MM30$mois = month(db_stats_MM30$date)
db_stats_MM30$mois = as.factor(db_stats_MM30$mois)
db_stats_MM30$An = year(db_stats_MM30$date)
db_stats_MM30$An = as.factor(db_stats_MM30$An)


db_stats_MM30_mois = db_stats_MM30%>%
  group_by(id_sonde,mois,An)%>%
  mutate(MoyenneMaxMM30Mens = mean(TeauMaxMM30),
         MoyenneMinMM30Mens=mean(TeauMinMM30))

db_stats_MM30_mois=db_stats_MM30_mois[,-c(2,3,4)]
db_stats_MM30_mois=db_stats_MM30_mois[
  duplicated(db_stats_MM30_mois)==F,
]

colnames(db_stats_MM30_mois) = c("Sondes","Mois","Années",
                                 "Maximum",
                                 "Minimum")

db_stats_MM30_An = db_stats_MM30_mois %>%
  group_by(Sondes,Années)%>%
  mutate(MoyenneMaxMM30An = mean(Maximum),
         MoyenneMinMM30An=mean(Minimum))

db_stats_MM30_An=db_stats_MM30_An[,-c(2,4,5)]
db_stats_MM30_An=db_stats_MM30_An[
  duplicated(db_stats_MM30_An)==F,
]
colnames(db_stats_MM30_An) = c("Sondes","Années",
                               "Maximum",
                               "Minimum")
##########
# Stats Touques
#########

db_Touques_stats_MM30_mois=db_stats_MM30_mois[db_stats_MM30_mois$Sondes == 825 |
                                                db_stats_MM30_mois$Sondes == 827 |
                                                db_stats_MM30_mois$Sondes == 828 |
                                                db_stats_MM30_mois$Sondes == 830 ,
]
db_Touques_stats_MM30_mois$Sondes <- factor(db_Touques_stats_MM30_mois$Sondes,exclude=NULL)
db_Touques_stats_MM30_mois$Sondes <- factor(db_Touques_stats_MM30_mois$Sondes,
                                            levels = c(
                                              "825", "827", "828", "830"
                                            ),
                                            labels =c("Touques T1","Touques T3","Touques T4","Touques T6")
)

db_Touques_stats_MM30_An =db_stats_MM30_An[db_stats_MM30_An$Sondes == 825 |
                                             db_stats_MM30_An$Sondes == 827 |
                                             db_stats_MM30_An$Sondes == 828 |
                                             db_stats_MM30_An$Sondes == 830 ,
]

db_Touques_stats_MM30_An$Sondes <- factor(db_Touques_stats_MM30_An$Sondes,exclude=NULL)
db_Touques_stats_MM30_An$Sondes <- factor(db_Touques_stats_MM30_An$Sondes,
                                          levels = c(
                                            "825", "827", "828", "830"
                                          ),
                                          labels =c("Touques T1","Touques T3","Touques T4","Touques T6")
)
##########
# Stats Orne
#########

db_Orne_stats_MM30_mois=db_stats_MM30_mois[db_stats_MM30_mois$Sondes == 817 |
                                             db_stats_MM30_mois$Sondes == 818 |
                                             db_stats_MM30_mois$Sondes == 819  ,]


db_Orne_stats_MM30_mois$Sondes <- factor(db_Orne_stats_MM30_mois$Sondes,exclude=NULL)
db_Orne_stats_MM30_mois$Sondes <- factor(db_Orne_stats_MM30_mois$Sondes,
                                         levels = c(
                                           "817", "818", "819"
                                         ),
                                         labels =c("Orne T1","Orne T3","Orne T2")
)

db_Orne_stats_MM30_An =db_stats_MM30_An[db_stats_MM30_An$Sondes == 817 |
                                          db_stats_MM30_An$Sondes == 818 |
                                          db_stats_MM30_An$Sondes == 819 ,
]

db_Orne_stats_MM30_An$Sondes <- factor(db_Orne_stats_MM30_An$Sondes,exclude=NULL)
db_Orne_stats_MM30_An$Sondes <- factor(db_Orne_stats_MM30_An$Sondes,
                                       levels = c(
                                         "817", "818", "819"
                                       ),
                                       labels =c("Orne T1","Orne T3","Orne T2")
)


##########
# Stats Odon
#########

db_Odon_stats_MM30_mois=db_stats_MM30_mois[db_stats_MM30_mois$Sondes == 812 |
                                             db_stats_MM30_mois$Sondes == 813 |
                                             db_stats_MM30_mois$Sondes == 814 |
                                             db_stats_MM30_mois$Sondes == 815 |
                                             db_stats_MM30_mois$Sondes == 816,
]
db_Odon_stats_MM30_mois$Sondes <- factor(db_Odon_stats_MM30_mois$Sondes,exclude=NULL)
db_Odon_stats_MM30_mois$Sondes <- factor(db_Odon_stats_MM30_mois$Sondes,
                                         levels = c(
                                           "812", "813", "814", "815","816"
                                         ),
                                         labels =c("Odon T1","Odon T2","Odon T3","Odon T4","Odon T5")
)

db_Odon_stats_MM30_An =db_stats_MM30_An[db_stats_MM30_An$Sondes == 812 |
                                          db_stats_MM30_An$Sondes == 813 |
                                          db_stats_MM30_An$Sondes == 814 |
                                          db_stats_MM30_An$Sondes == 815 ,
]

db_Odon_stats_MM30_An$Sondes <- factor(db_Odon_stats_MM30_An$Sondes,exclude=NULL)
db_Odon_stats_MM30_An$Sondes <- factor(db_Odon_stats_MM30_An$Sondes,
                                       levels = c(
                                         "812", "813", "814", "815","816"
                                       ),
                                       labels =c("Odon T1","Odon T2","Odon T3","Odon T4","Odon T5")
)

##########
# Stats Selune
#########

db_Selune_stats_MM30_mois=db_stats_MM30_mois[db_stats_MM30_mois$Sondes == 820 |
                                               db_stats_MM30_mois$Sondes == 821 |
                                               db_stats_MM30_mois$Sondes == 822 |
                                               db_stats_MM30_mois$Sondes == 823 |
                                               db_stats_MM30_mois$Sondes == 824,
]
db_Selune_stats_MM30_mois$Sondes <- factor(db_Selune_stats_MM30_mois$Sondes,exclude=NULL)
db_Selune_stats_MM30_mois$Sondes <- factor(db_Selune_stats_MM30_mois$Sondes,
                                           levels = c(
                                             "820", "821", "822", "823","824"
                                           ),
                                           labels =c("Selune T4","Selune T2","Selune T3","Selune T5","Selune T1")
)

db_Selune_stats_MM30_An =db_stats_MM30_An[db_stats_MM30_An$Sondes == 820 |
                                            db_stats_MM30_An$Sondes == 821 |
                                            db_stats_MM30_An$Sondes == 822 |
                                            db_stats_MM30_An$Sondes == 823 |
                                            db_stats_MM30_An$Sondes == 824,
]

db_Selune_stats_MM30_An$Sondes <- factor(db_Selune_stats_MM30_An$Sondes,exclude=NULL)
db_Selune_stats_MM30_An$Sondes <- factor(db_Selune_stats_MM30_An$Sondes,
                                         levels = c(
                                           "820", "821", "822", "823","824"
                                         ),
                                         labels =c("Selune T4","Selune T2","Selune T3","Selune T5","Selune T1")
)




# COMPARAISON SONDES ----
## db_xts_comp_teau_moy ----
# moyennes journalières
min_date = min(db$date)
max_date = max(db$date)

db_xts_comp_teau_moy = data.frame(date=seq(min_date, max_date, "day"))

for(id_s in unique(db$id_sonde)){
  #id_s = 813
  db_tempo = db[which(db$id_sonde==id_s),]
  db_tempo = aggregate(Teau~date,data=db_tempo, FUN=mean)
  
  db_tempo[[id_s]] = db_tempo$Teau
  
  
  db_xts_comp_teau_moy = merge(db_xts_comp_teau_moy, db_tempo[,c("date", id_s)], by="date", all=TRUE)
  
}








## db_xts_comp_teau_MM30 ----
db_xts_comp_teau_MM30 = db_xts_comp_teau_moy

for(i in 2:ncol(db_xts_comp_teau_MM30)){
  db_xts_comp_teau_MM30[[i]] = stats::filter(db_xts_comp_teau_MM30[[i]],filter=c(1/(2*30),rep(1/30,29),1/(2*30)))
}




## db_xts_comp_teau_MM365 ----
db_xts_comp_teau_MM365 = db_xts_comp_teau_moy

for(i in 2:ncol(db_xts_comp_teau_MM365)){
  db_xts_comp_teau_MM365[[i]] = stats::filter(db_xts_comp_teau_MM365[[i]],filter=rep(1/365,365))
}

## db_xts_comp_teau_bih ----
min_t = min(db$t)
max_t = max(db$t)
db_xts_comp_teau_bih = data.frame(t=seq(from = min_t, to = max_t, by = "2 hour"))

for(id_s in unique(db$id_sonde)){
  db_tempo = db[which(db$id_sonde==id_s),]
  db_tempo[[id_s]] = db_tempo$Teau
  db_tempo$t = ymd_hms(paste0(year(db_tempo$t), "-",
                              month(db_tempo$t), "-",
                              day(db_tempo$t), " ",
                              ifelse(hour(db_tempo$t)%%2==0, hour(db_tempo$t), (hour(db_tempo$t))-1), ":00:00"))
  db_tempo = aggregate(db_tempo[id_s], by=db_tempo['t'], mean)
  
  
  db_xts_comp_teau_bih = merge(db_xts_comp_teau_bih, db_tempo[,c("t", id_s)], by="t", all=TRUE)
  
}


## db_teau_tair, db_teau_tair2 ----
db_teau_tair = db_xts_comp_teau_moy

db_teau_tair = merge(db_teau_tair, db_Tair_moy, all.x=TRUE, suffixes=c("Teau", "Tair"), by="date")


##########################################################
# BDD pour corrélations Tair et Teau
##########################################################


############
# Nettoyage de la BDD db_teau_tair pour la rendre exploitable
############
colnames(db_teau_tair)

order=order(colnames(db_teau_tair)[2:31], decreasing = FALSE)+1
order
db_teau_tair2 = db_teau_tair[,
                             c(1,8, 30, 25,  2, 16, 24, 18,  5,  4, 17,  3,  7,
                               31,  6,  9, 10, 11, 12, 13, 14, 15, 22, 20, 21,
                               23, 19, 26, 27, 28, 29,
                               32:ncol(db_teau_tair))]


colnames(db_teau_tair2)

############
# Calculs des droites de régressions
###########



Name=vector()
dataReg = as.data.frame(db_teau_tair2[,1])
colnames(dataReg)="date"

dataRegCoeff = as.data.frame(matrix(
  rep(0,3*((ncol(db_teau_tair2)-1)/2)),
  nrow = 3,ncol=(ncol(db_teau_tair2)-1)/2))



for (j in 2:(((ncol(db_teau_tair2)-1)/2)+1)){
  
  
  name=substr(colnames(db_teau_tair2)[j],1,3)
  base_temp = as.data.frame(cbind(db_teau_tair2[,1],
                                  db_teau_tair2[,j],
                                  db_teau_tair2[,j+((ncol(db_teau_tair2)-1)/2)]
  ))
  
  
  base_temp[,1] <- as.Date(base_temp[,1], origin="1970-01-01")
  
  base_temp=base_temp[which(is.na(base_temp[,2])==F)[1]:nrow(base_temp),]
  
  base_temp=base_temp[is.na(base_temp[,2])==F,]
  base_temp=base_temp[is.na(base_temp[,3])==F,]
  reg = lm(base_temp[,2]~base_temp[,3])
  base_temp$reg = reg$fitted.values
  colnames(base_temp)=c("date",paste("Teau",name,sep=""),
                        paste("Tair",name,sep=""),
                        paste(name,sep=""))
  base_temp = base_temp[,c(1,4)]
  dataRegCoeff[1,j-1]=reg$coefficients[1]
  dataRegCoeff[2,j-1]=reg$coefficients[2]
  dataRegCoeff[3,j-1]=summary(reg)$adj.r.squared
  
  dataReg= merge(dataReg,base_temp,by="date",all.x=T)
  Name=append(Name,name)
}


rownames(dataRegCoeff) = c("Intercept","Pente","Rcarré")
colnames(dataRegCoeff) =colnames(dataReg)[2:31]

colnames(dataReg)[2:ncol(dataReg)] =as.character(
  as.factor(
    factor(colnames(dataReg)[2:ncol(dataReg)],
           levels = colnames(dataReg)[2:ncol(dataReg)],
           labels =riv)))


db_teau_tair3 <- db_Tair_moy

db_teau_tair3=db_teau_tair3[,c(ncol(db_teau_tair3),2:ncol(db_teau_tair3)-1)]


db_teau_tair3 <- db_teau_tair3 %>%
  gather(key="id_sonde",value="Tair",c(2:ncol(db_teau_tair3))) %>%
  convert_as_factor(id_sonde)

db_teau_tair3 = merge(db2[,c(1,2,6)],db_teau_tair3,by=c("date","id_sonde"),all.x=T)
colnames(db_teau_tair3)=c("date","id_sonde","Température de l'eau","Température de l'air")




####################################################################################
# Base de données O'Driscoll
###################################################################################
db_ordriscoll = db_teau_tair2[,c("date","812Teau","813Teau","815Teau","816Teau", # Odon
                                 "817Teau","818Teau","819Teau", # Orne
                                 "820Teau","821Teau","822Teau","823Teau","824Teau", # Sélune
                                 "825Teau","827Teau","828Teau","830Teau",
                                 "812Tair","813Tair","815Tair","816Tair", # Odon
                                 "817Tair","818Tair","819Tair", # Orne
                                 "820Tair","821Tair","822Tair","823Tair","824Tair", # Sélune
                                 "825Tair","827Tair","828Tair","830Tair"
)]


n = ncol(db_ordriscoll)
db_ordriscoll <- db_ordriscoll %>%
  gather(key="SondeTeau",value="Teau",c(2:(((n-1)/2)+1))) %>%
  convert_as_factor(SondeTeau)

db_ordriscoll <- db_ordriscoll %>%
  gather(key="SondeTair",value="Tair",c(2:(((n-1)/2)+1))) %>%
  convert_as_factor(SondeTair)

db_ordriscoll = db_ordriscoll[is.na(db_ordriscoll$Teau)==F,]
db_ordriscoll = db_ordriscoll[is.na(db_ordriscoll$Tair)==F,]

db_ordriscoll = db_ordriscoll %>%
  group_by(SondeTeau) %>%
  mutate(TeauMM7  = stats::filter(Teau,filter=rep(1/7,7)))


db_ordriscoll = db_ordriscoll %>%
  group_by(SondeTair) %>%
  mutate(TairMM7  = stats::filter(Tair,filter=rep(1/7,7)))


coefficient <- db_ordriscoll %>%
  group_by(SondeTeau)%>%
  mutate(aa = lm(TeauMM7~TairMM7)$coefficients[1])%>%
  mutate(bb = lm(TeauMM7~TairMM7)$coefficients[2])

coefficient

unique(db_ordriscoll$SondeTeau)

odris=as.data.frame(cbind(unique(as.character(db_ordriscoll$SondeTeau)),
                          unique(coefficient$aa),
                          unique(coefficient$bb)))
colnames(odris) = c("Sondes","intercept","slope")
odris$intercept = as.character(odris$intercept)
odris$intercept = as.numeric(odris$intercept)

odris$slope = as.character(odris$slope)
odris$slope = as.numeric(odris$slope)

regOdris = lm(intercept~slope,data=odris)
summary(regOdris)$adj.r.squared


odris$Sondes = factor(odris$Sondes,
                      levels = odris$Sondes,
                      labels =riv[15:30])

odris$Sondes2 = str_sub(odris$Sondes,-2, -1)
odris$Sondes = str_sub(odris$Sondes,1, -3)
odris$Sondes <- as.factor(odris$Sondes )

odris$intercept2 = regOdris$coefficients[1]
odris$slope2 = regOdris$coefficients[2]



# Odon -----
# ################ #
# Odon
# ################ #

# base pour l'odon (bi-horaire)
db_aci_bih_odon = db_xts_comp_teau_bih %>%
  dplyr::select(c("t", "812", "813", "815", "816"))

db_aci_bih_odon = na.omit(db_aci_bih_odon)


# base pour l'odon (moyenne journalière)
db_aci_moy_odon = db_xts_comp_teau_moy %>%
  dplyr::select(c("date", "812", "813", "815", "816"))

db_aci_moy_odon = na.omit(db_aci_moy_odon)


# Orne -----
# ################ #
# Orne
# ################ #

# base pour l'Orne (bi-horaire)
db_aci_bih_orne = db_xts_comp_teau_bih %>%
  dplyr::select(c("t", "817", "818", "819"))

db_aci_bih_orne = na.omit(db_aci_bih_orne)


# base pour l'Orne (moyenne journalière)
db_aci_moy_orne = db_xts_comp_teau_moy %>%
  dplyr::select(c("date", "817", "818", "819"))

db_aci_moy_orne = na.omit(db_aci_moy_orne)



# Sélune -----
# ################ #
# Sélune
# ################ #

# base pour la Sélune (bi-horaire)
db_aci_bih_selune = db_xts_comp_teau_bih %>%
  dplyr::select(c("t", "820", "821", "823", "824")) # sans la 822

db_aci_bih_selune = na.omit(db_aci_bih_selune)



# base pour la Sélune (moyenne journalière)
db_aci_moy_selune = db_xts_comp_teau_moy %>%
  dplyr::select(c("date", "820", "821", "823", "824")) # sans la 822

db_aci_moy_selune = na.omit(db_aci_moy_selune)


# Touques -----
# ################ #
# Touques
# ################ #

# base pour la Touques (bi-horaire)
db_aci_bih_touques = db_xts_comp_teau_bih %>%
  dplyr::select(c("t", "825", "827", "828", "830"))

db_aci_bih_touques = na.omit(db_aci_bih_touques)
head(db_aci_moy_touques)


# base pour la Touques (moyenne journalière)
db_aci_moy_touques = db_xts_comp_teau_moy %>%
  dplyr::select(c("date", "825", "827", "828", "830"))

db_aci_moy_touques = na.omit(db_aci_moy_touques)







# ACI Odon -----

# preparation pour l'ACI
aci_t = db_aci_moy_odon %>%
  dplyr::select(c("date"))

aci_data = db_aci_moy_odon %>%
  dplyr::select(!c("date"))


dim(aci_t)
dim(aci_data)

# ACI
set.seed(1)
a_odon <- fastICA(aci_data, 3, alg.typ = "parallel", fun = "logcosh", alpha = 1,
                  method = "R", row.norm = FALSE, maxit = 200,
                  tol = 0.0001, verbose = TRUE)


b_odon <- cbind(aci_t, data.frame(a_odon$S))
mat_odon <- a_odon$A

lab_comp = c()
for(i in 1:ncol(aci_data)){
  
  label_i = colnames(aci_data)[i]
  
  b_odon[paste0("comp1_", label_i)]=a_odon$A[1,i]*a_odon$S[,1]
  b_odon[paste0("comp2_", label_i)]=a_odon$A[2,i]*a_odon$S[,2]
  b_odon[paste0("comp3_", label_i)]=a_odon$A[3,i]*a_odon$S[,3]
  
  lab_comp = c(lab_comp, paste0("comp1_", label_i), paste0("comp2_", label_i), paste0("comp3_", label_i))
  
}

# base aci
xts_aci_odon =xts(b_odon[, lab_comp], order.by = b_odon[,"date"])







# ACI Orne -----

# preparation pour l'ACI
aci_t = db_aci_moy_orne %>%
  dplyr::select(c("date"))

aci_data = db_aci_moy_orne %>%
  dplyr::select(!c("date"))



# ACI
set.seed(1)
a_orne <- fastICA(aci_data, 3, alg.typ = "parallel", fun = "logcosh", alpha = 1,
                  method = "R", row.norm = FALSE, maxit = 200,
                  tol = 0.0001, verbose = TRUE)


b_orne <- cbind(aci_t, data.frame(a_orne$S))
mat_orne <- a_orne$A

lab_comp = c()
for(i in 1:ncol(aci_data)){
  
  label_i = colnames(aci_data)[i]
  
  b_orne[paste0("comp1_", label_i)]=a_orne$A[1,i]*a_orne$S[,1]
  b_orne[paste0("comp2_", label_i)]=a_orne$A[2,i]*a_orne$S[,2]
  b_orne[paste0("comp3_", label_i)]=a_orne$A[3,i]*a_orne$S[,3]
  
  lab_comp = c(lab_comp, paste0("comp1_", label_i), paste0("comp2_", label_i), paste0("comp3_", label_i))
  
}

# base aci
xts_aci_orne =xts(b_orne[, lab_comp], order.by = b_orne[,"date"])



# ACI Selune -----

# preparation pour l'ACI
aci_t = db_aci_moy_selune %>%
  dplyr::select(c("date"))

aci_data = db_aci_moy_selune %>%
  dplyr::select(!c("date"))



# ACI
set.seed(1)
a_selune <- fastICA(aci_data, 3, alg.typ = "parallel", fun = "logcosh", alpha = 1,
                    method = "R", row.norm = FALSE, maxit = 200,
                    tol = 0.0001, verbose = TRUE)


b_selune <- cbind(aci_t, data.frame(a_selune$S))
mat_selune <- a_selune$A

lab_comp = c()
for(i in 1:ncol(aci_data)){
  
  label_i = colnames(aci_data)[i]
  
  b_selune[paste0("comp1_", label_i)]=a_selune$A[1,i]*a_selune$S[,1]
  b_selune[paste0("comp2_", label_i)]=a_selune$A[2,i]*a_selune$S[,2]
  b_selune[paste0("comp3_", label_i)]=a_selune$A[3,i]*a_selune$S[,3]
  
  lab_comp = c(lab_comp, paste0("comp1_", label_i), paste0("comp2_", label_i), paste0("comp3_", label_i))
  
}

# base aci
xts_aci_selune =xts(b_selune[, lab_comp], order.by = b_selune[,"date"])





# ACI Touques -----

# preparation pour l'ACI
aci_t = db_aci_moy_touques %>%
  dplyr::select(c("date"))

aci_data = db_aci_moy_touques %>%
  dplyr::select(!c("date"))



# ACI
set.seed(1)
a_touques <- fastICA(aci_data, 3, alg.typ = "parallel", fun = "logcosh", alpha = 1,
                     method = "R", row.norm = FALSE, maxit = 200,
                     tol = 0.0001, verbose = TRUE)


b_touques <- cbind(aci_t, data.frame(a_touques$S))
mat_touques <- a_touques$A

lab_comp = c()
for(i in 1:ncol(aci_data)){
  
  label_i = colnames(aci_data)[i]
  
  b_touques[paste0("comp1_", label_i)]=a_touques$A[1,i]*a_touques$S[,1]
  b_touques[paste0("comp2_", label_i)]=a_touques$A[2,i]*a_touques$S[,2]
  b_touques[paste0("comp3_", label_i)]=a_touques$A[3,i]*a_touques$S[,3]
  
  lab_comp = c(lab_comp, paste0("comp1_", label_i), paste0("comp2_", label_i), paste0("comp3_", label_i))
  
}

# base aci
xts_aci_touques =xts(b_touques[, lab_comp], order.by = b_touques[,"date"])

# ############## #
#    ACIs données diff -----
# ############## #

############
#   Préparation des données
############
db_teau_tair_diff = db_teau_tair2
db_teau_tair_diff = db_teau_tair_diff[,-1]
for (i in 1:(ncol(db_teau_tair_diff)/2)){
  db_teau_tair_diff[[paste0(substr(colnames(db_teau_tair_diff)[i],start=1,stop=3),"diff")]]= db_teau_tair_diff[,i]-db_teau_tair_diff[,i+30]

}
db_teau_tair_diff=db_teau_tair_diff[,-c(31:60)]
db_teau_tair_diff$date=db_teau_tair2$date
colnames(db_teau_tair_diff) = str_replace(colnames(db_teau_tair_diff), "Teau","Diff")

# Touques ----

head(db_teau_tair_diff)




#####################
#   ACPs
####################

########
# Préparation des données
########

####  Touques
db_acp_touques = cbind(aci_t,as.data.frame(xts_aci_touques))
db_acp_touques = merge(db_acp_touques,db_teau_tair2[,
                                                    c("825Teau", "827Teau", "828Teau", "830Teau",
                                                      "825Tair", "827Tair", "828Tair", "830Tair",
                                                      "date")],
                       by="date")

db_acp_touques$Diff825 = db_acp_touques$`825Teau`-db_acp_touques$`825Tair`
db_acp_touques$Diff827 = db_acp_touques$`827Teau`-db_acp_touques$`827Tair`
db_acp_touques$Diff828 = db_acp_touques$`828Teau`-db_acp_touques$`828Tair`
db_acp_touques$Diff830 = db_acp_touques$`830Teau`-db_acp_touques$`830Tair`



db_acp_touques = merge(db_acp_touques, db_pluvio[,c("825","827","828","830","date")],by="date",all.x=T)
colnames(db_acp_touques)[26:29] = c("pluvio_825","pluvio_827","pluvio_828","pluvio_830")

db_acp_touques = merge(db_acp_touques, db_soleil[,c("825","827","828","830","date")],by="date",all.x=T)
colnames(db_acp_touques)[30:33] = c("sol_825","sol_827","sol_828","sol_830")

db_acp_touques = merge(db_acp_touques, piezo_touques,by="date",all.x=T)

acp_Touques_date <- db_acp_touques$date


######
# Préparation acp_sonde_825
######
acp_Touques_825 <- db_acp_touques[,c("comp1_825",  "comp2_825",  "comp3_825",
                                     "825Teau" ,"825Tair","Diff825" ,
                                     "pluvio_825","sol_825" ,"piezo"
                                     )]

colnames(acp_Touques_825) = c("C1","C2","C3","Teau","Tair","Diff","rr","qq","piez")


# Recherche des valeurs manquantes dans la BDD au viveau de la piezo
sum(is.na(acp_Touques_825)) == sum(is.na(acp_Touques_825$piez))

# Imputation de donn?es manquantes ? l'aide de imputePCA(missMDA)
res.comp <- imputePCA(acp_Touques_825)
acp_Touques_825b <- res.comp$completeObs
sum(is.na(acp_Touques_825b[,7])) # Plus de donn?es manquantes dans la variable pi?zo
sum(acp_Touques_825[,1]==acp_Touques_825b[,1])# Les autres donn?es n'ont pas ?t? modifi?es OK !
sum(acp_Touques_825[,2]==acp_Touques_825b[,2])
sum(acp_Touques_825[,3]==acp_Touques_825b[,3])
sum(acp_Touques_825[,4]==acp_Touques_825b[,4])
sum(acp_Touques_825[,5]==acp_Touques_825b[,5])
sum(acp_Touques_825[,6]==acp_Touques_825b[,6])

colnames(acp_Touques_825b)
acp_Touques_825b=as.data.frame(acp_Touques_825b)
acp_Touques_825c <- acp_Touques_825b[,-c(5,6)]
acp_Touques_825c <- acp_Touques_825c[,-3]


res.pca=PCA(acp_Touques_825c, quanti.sup=4:6 )

res.pca$eig
# Kaiser : garder les VPs au dessus de 1 => Dim1 - 2
# Plus de 95% de l'info est conserver avec les DIM 1 - 2
fviz_eig(res.pca, addlabels = TRUE, ylim = c(0, 50))
# Diagramme des ?bouli : coude au niveau de la 3eme DIM, donc on garde les 2
# premi?mes dimentions



res1 <- fviz_pca_var(res.pca,axes = c(1, 2), col.var = "cos2",title ="ACP de la Sonde 825",
                     gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
                     repel = TRUE
)

res1

cor(acp_Touques_825b$C2,acp_Touques_825b$qq)

correlation = matrix(rep(0,ncol(acp_Touques_825b)^2),
  ncol(acp_Touques_825b),ncol(acp_Touques_825b))

for(i in 1:ncol(acp_Touques_825b)){
  for(j in 1:ncol(acp_Touques_825b)){
    correlation[i,j]=round(cor(acp_Touques_825b[,i],acp_Touques_825b[,j]),3)
  }
}
correlation = as.data.frame(correlation)
colnames(correlation) = colnames(acp_Touques_825b)
rownames(correlation)=colnames(acp_Touques_825b)


######
# Préparation acp_sonde_827
######
acp_Touques_827 <- db_acp_touques[,c("comp1_827",  "comp2_827",  "comp3_827",
                                     "827Teau" ,"827Tair","Diff827" ,
                                     "pluvio_827","sol_827" ,"piezo"
)]

colnames(acp_Touques_827) = c("C1","C2","C3","Teau","Tair","Diff","rr","qq","piez")

######
# Préparation acp_sonde_828
######
acp_Touques_828 <- db_acp_touques[,c("comp1_828",  "comp2_828",  "comp3_828",
                                     "828Teau" ,"828Tair","Diff828" ,
                                     "pluvio_828","sol_828" ,"piezo"
)]

colnames(acp_Touques_828) = c("C1","C2","C3","Teau","Tair","Diff","rr","qq","piez")

######
# Préparation acp_sonde_830
######
acp_Touques_830 <- db_acp_touques[,c("comp1_830",  "comp2_830",  "comp3_830",
                                     "830Teau" ,"830Tair","Diff830" ,
                                     "pluvio_830","sol_830" ,"piezo"
)]

colnames(acp_Touques_830) = c("C1","C2","C3","Teau","Tair","Diff","rr","qq","piez")



######
# Préparation acp_sonde_827
######

######
# Préparation acp_sonde_828
######

######
# Préparation acp_sonde_830
######

#### Orne



#### Odon



#### Selune



#############
# Resultats ACPs
#############


## xts_aci_odon, xts_aci_orne, xts_aci_selune, xts_aci_touques  -----
# save(xts_aci_odon, xts_aci_orne, 
#      xts_aci_selune, xts_aci_touques,
#      mat_odon, mat_orne, mat_selune, mat_touques,
#      file = "xts_aci.RData")

# save(b_odon, b_orne, 
#      b_selune, b_touques,
#      mat_odon, mat_orne, mat_selune, mat_touques,
#      file = "db_aci.RData")
############## Enregistrement des données -----

#save(db_stats, db_stats_Touques, dbMM, db2, file="RData/dbA.RData")
#save(db3, pref, prefTouques, file="RData/dbB.RData")
#save(db_Touques_xtsa, db_Touques_xtsb, db_Touques_xtsc, db_Touquesb, file="RData/dbC.RData")
#save(db_Orne_xtsa, db_Orne_xtsb, db_Odon_xtsc, file="RData/dbD.RData")
#save(db_Odon_xtsa, db_Odon_xtsb, db_Odon_xtsc, file="RData/dbE.RData")
#save(db_Selune_xtsa, db_Selune_xtsb, db_Selune_xtsc, file="RData/dbF.RData")
#save(db_Touques_stats_MM30, db_Touques_stats_MM30_mois, db_Touques_stats_MM30_An, file="RData/dbG.RData")
#save(db_xts_comp_teau_moy, db_xts_comp_teau_MM30, db_xts_comp_teau_MM365, db_xts_comp_teau_bih,
#     file="RData/dbH.RData")
#save(db_teau_tair, db_teau_tair2, db_teau_tair3, file="RData/dbI.RData")
#save(CorTeauTair, dataReg, dataRegCoeff, file="RData/dbJ.RData")
#save(dataRegTouques, dataRegTouques825, dataRegTouques827, dataRegTouques828, dataRegTouques830,
#     file="RData/dbK.RData")
#save(db_ordriscoll, coefficient, odris, regOdris, riv, file="RData/dbL.RData")

save(db_stats, db_stats_Touques, dbMM,
     db2, db3, pref, prefTouques,
     db_Touques_xtsa, db_Touques_xtsb, db_Touques_xtsc, db_Touquesb,
     db_Orne_xtsa, db_Orne_xtsb, db_Odon_xtsc,
     db_Odon_xtsa, db_Odon_xtsb, db_Odon_xtsc,
     db_Selune_xtsa, db_Selune_xtsb, db_Selune_xtsc,
     db_Touques_stats_MM30, db_Touques_stats_MM30_mois, db_Touques_stats_MM30_An,
     db_xts_comp_teau_moy, db_xts_comp_teau_MM30, db_xts_comp_teau_MM365, db_xts_comp_teau_bih,
     db_teau_tair, db_teau_tair2, db_teau_tair3,
     CorTeauTair, dataReg, dataRegCoeff,
     dataRegTouques, dataRegTouques825, dataRegTouques827, dataRegTouques828, dataRegTouques830,
     db_ordriscoll, coefficient, odris, regOdris, riv,
     xts_aci_odon, xts_aci_orne, xts_aci_selune, xts_aci_touques,
     file = "RData/treated_data.RData")

