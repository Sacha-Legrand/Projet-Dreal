
##############################################################################
#           ATTENTION
##############################################################################
# Les données nc (données E-OBS) ne sont pas présents sur le GitHub
# Car trop lourds, il est donc nécessaire de les charger tels qu'indiqué
# dans le README et de les stocker dans le fichier "nc_files" du
# data_treatment

############## Working Directory -----

# Path to working directory
# Path Lucie
path = "D:/Users/Desktop/Cours/M2stat/Projet4/Projet-Dreal-main/data_treatment/"
# Path Julien
#path = "/Users/julien/Desktop/projetM2/GitHub/data_treatment/"

# Setting working Directory
setwd(path)

############# Données nc_files pour mise à jour

temp_air_moy = "nc_files/tg_ens_mean_0.1deg_reg_2011-2021_v24.0e.nc"
pluvio = "nc_files/rr_ens_mean_0.1deg_reg_2011-2021_v24.0e.nc"
soleil = "nc_files/qq_ens_mean_0.1deg_reg_2011-2021_v24.0e.nc"

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
if(!require(readODS)){
  install.packages("readODS")
  #library(readODS)
}
if(!require(stringr)){
  install.packages("stringr")
  library(stringr)
}







##############  Fichier des desciptions de variables ------
Variables = readODS::read_ods(paste0(path,"/Description_Variables.ods"),sheet=1)
save(Variables, file = "RData/Variables.RData")

############## db (regroupement de toutes les donnees) -----

# Chargement et extraction des données des sondes

pathSondes = paste0( path,"sondes")

setwd(pathSondes)

NomF <- list.files()
NomF

sonde109 <- read.csv2(paste0(NomF[1]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde109$id_sonde = 109
sonde768 <- read.csv2(paste0(NomF[2]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde768$id_sonde = 768
sonde765 <- read.csv2(paste0(NomF[3]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde765$id_sonde = 765
sonde764 <- read.csv2(paste0(NomF[4]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde764$id_sonde = 764
sonde811 <- read.csv2(paste0(NomF[5]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde811$id_sonde = 811
sonde769 <- read.csv2(paste0(NomF[6]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde769$id_sonde = 769
sonde104 <- read.csv2(paste0(NomF[7]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde104$id_sonde =104
sonde812 <- read.csv2(paste0(NomF[8]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde812$id_sonde =812
sonde813 <- read.csv2(paste0(NomF[9]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde813$id_sonde =813
sonde815 <- read.csv2(paste0(NomF[10]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde815$id_sonde = 815
sonde816 <- read.csv2(paste0(NomF[11]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde816$id_sonde = 816
sonde817 <- read.csv2(paste0(NomF[12]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde817$id_sonde = 817
# ########## #
# ATTENTION : 2 BDDs qui sont en rapport avec la sonde 818 : Elles sont semblable donc
# suppression de l'une entre elle
# ########## #
sonde818 <- read.csv2(paste0(NomF[13]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde818 <- read.csv2(paste0(NomF[14]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde818$id_sonde = 818
sonde819 <- read.csv2(paste0(NomF[15]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde819$id_sonde = 819
sonde300 <- read.csv2(paste0(NomF[16]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde300$id_sonde = 300
sonde766 <- read.csv2(paste0(NomF[17]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde766$id_sonde = 766
sonde763 <- read.csv2(paste0(NomF[18]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde763$id_sonde = 763
sonde824 <- read.csv2(paste0(NomF[19]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde824$id_sonde = 824
sonde821 <- read.csv2(paste0(NomF[20]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde821$id_sonde = 821
sonde822 <- read.csv2(paste0(NomF[21]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde822$id_sonde = 822
sonde820 <- read.csv2(paste0(NomF[22]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde820$id_sonde = 820
sonde823 <- read.csv2(paste0(NomF[23]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde823$id_sonde = 823
sonde762 <- read.csv2(paste0(NomF[24]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde762$id_sonde = 762
sonde108 <- read.csv2(paste0(NomF[25]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde108$id_sonde = 108
sonde825 <- read.csv2(paste0(NomF[26]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde825$id_sonde = 825
sonde827 <- read.csv2(paste0(NomF[27]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde827$id_sonde = 827
sonde828 <- read.csv2(paste0(NomF[28]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde828$id_sonde = 828
sonde830 <- read.csv2(paste0(NomF[29]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde830$id_sonde = 830
sonde105 <- read.csv2(paste0(NomF[30]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde105$id_sonde = 105
sonde771 <- read.csv2(paste0(NomF[31]),skip=2,sep=";",col.names = c("X","date","heure","Teau"))
sonde771$id_sonde = 771


db = rbind(sonde109,sonde768,sonde765,sonde764,sonde811,sonde769,
           sonde104,sonde812,sonde813,sonde815,sonde816,sonde817,
           sonde818,sonde819,sonde300,sonde766,sonde763,sonde824,
           sonde821,sonde822,sonde820,sonde823,sonde762,sonde108,
           sonde825,sonde827,sonde828,sonde830,sonde105,sonde771)

rm(sonde109,sonde768,sonde765,sonde764,sonde811,sonde769,
   sonde104,sonde812,sonde813,sonde815,sonde816,sonde817,
   sonde818,sonde819,sonde300,sonde766,sonde763,sonde824,
   sonde821,sonde822,sonde820,sonde823,sonde762,sonde108,
   sonde825,sonde827,sonde828,sonde830,sonde105,sonde771)


db = db[,-1]
str(db)
db$date <- as.character(db$date)
db$date = dmy(db$date)
db$t <- paste(as.character(db$date),db$heure,sep=" ")
db$t = ymd_hms(db$t)
db$id_sonde <- as.character(db$id_sonde)


db = db[,-2]


db = db[,c(4,3,2,1)]


rm(NomF,pathSondes)
setwd(path)
# enregistrement des données dans un RData
save(db, file = "RData/db.RData")



############## Fichiers kmls (données géographiques) -----

# lecture des fichiers
SondesOFB = rgdal::readOGR(paste0(path,"kml_files/Sondes T OFB.kml"), "Points")
coursEau2 = rgdal::readOGR(paste0(path,"kml_files/cours_eau_projet.kml"), "cours_eau_projet")
BV1 = rgdal::readOGR(paste0(path,"kml_files/BV1.kml"), "BV1")

# enregistrement des données dans un RData
save(SondesOFB, coursEau2, BV1, file = "RData/KMLs.RData")



############## db_sonde_synthese et db_temp -----


## db_sonde_synthese

# lecture du fichier xlsx
db_sonde_synthese <- openxlsx::read.xlsx("BilanSonde.xlsx",sheet=1,
                                         startRow = 5,colNames=T,rowNames = F)


# traitement de la base de données
db_sonde_synthese <- db_sonde_synthese[,-c(1,6,7,9:ncol(db_sonde_synthese))]

colnames(db_sonde_synthese) <- c("id_sonde","label","latitude","longitude","Altitude")


for (i in 1:nrow(db_sonde_synthese)){
  if (db_sonde_synthese$id_sonde[i] %in% unique(db$id_sonde))
  {
    db_sonde_synthese$id_sonde[i] = db_sonde_synthese$id_sonde[i]
  }
  else{db_sonde_synthese$id_sonde[i] = NA}
}

db_sonde_synthese <- db_sonde_synthese[is.na(db_sonde_synthese$id_sonde)==F,]

db_sonde_synthese$id_sonde <- as.factor(db_sonde_synthese$id_sonde)

modif = db %>%
  group_by(id_sonde)%>%
  mutate(nb_obs = length(id_sonde),
         date_debut = min(date),
         date_fin = max(date),
  )

modif = modif[,-c(1,3,4)]
modif = modif[duplicated(modif$id_sonde)==F,]


db_sonde_synthese = merge(db_sonde_synthese,modif, by="id_sonde")

rm(modif)



# calcul taille des fleuves
Taille=vector()
name=vector()
for (i in 1:dim(coursEau2)[1]){
  lat=vector()
  lng=vector()
  latitude=vector()
  longitude=vector()
  d=vector()
  #taille=vector()
  D=vector()
  longitude2=vector()
  latitude2=vector()

  Name = coursEau2$Name[i]

  coord = coordinates(coursEau2[coursEau2@data$Name == Name,])

  lng <- coord[[1]][[1]][,1]
  longitude = coord[[1]][[1]][,1]
  lat <- coord[[1]][[1]][,2]
  latitude=coord[[1]][[1]][,2]

  longitude2 = longitude*(pi/180)
  latitude2 = latitude*(pi/180)

  for (j in 1:length(latitude)){
    d= (2 * asin( sqrt(
      (sin((latitude2[j]-latitude2[j+1])/2))^2 + cos(latitude2[j])*cos(latitude2[j+1])* ( sin((longitude2[j]-longitude2[j+1])/2)) ^2
    )

    ))*6366

    D=append(D,d)
  }

  taille= sum(D,na.rm=T)
  #print(taille)
  Taille = append(Taille,taille)
  name = append(name,Name)

}
#Taille



Name=coursEau2@data$Name
Name=as.character(Name)
#Name

#cbind(Name,Taille)



# Ajout des distances à la source
db_sonde_synthese$label2 = gsub(" T\\d+","",db_sonde_synthese$label)
coursEau3 <- coursEau2
coursEau3@data$Name <- as.character(coursEau3@data$Name)
coursEau3@data$Name[coursEau3@data$Name == "Fontaine au HÃ©ron"] = "Fontaine au Héron"
coursEau3@data$Name[coursEau3@data$Name == "Grande Vallee"] = "Grande Vallée"
coursEau3@data$Name[coursEau3@data$Name == "Vieux Ruisseau (Vingt bec)"] = "Vingt Bec"

coord_sondes = as.data.frame(cbind(as.character(db_sonde_synthese$id_sonde),
                                   db_sonde_synthese$label2,
                                   db_sonde_synthese$longitude,db_sonde_synthese$latitude))
colnames(coord_sondes)=c("id_sonde","label","longitude","latitude")


coord_sondes$latitude <- as.character(coord_sondes$latitude)
coord_sondes$latitude <- as.numeric(coord_sondes$latitude)
coord_sondes$longitude <- as.character(coord_sondes$longitude)
coord_sondes$longitude <- as.numeric(coord_sondes$longitude)
coord_sondes$dist = NA


for (i in 1:nrow(coord_sondes)){
  print(i)
  c_eau = coursEau3
  c_eau = coordinates(c_eau[c_eau@data$Name == as.character(coord_sondes$label[i]),])
  c_eau$d = NA
  c_eau$di = NA


  longitude = c_eau[[1]][[1]][,1]
  latitude = c_eau[[1]][[1]][,2]

  longitude2 = longitude*(pi/180)
  latitude2 = latitude*(pi/180)

  for (j in 1:length(latitude)){

    c_eau$d[j]= (2 * asin( sqrt(
      (sin((latitude2[j]-latitude2[j+1])/2))^2 + cos(latitude2[j])*cos(latitude2[j+1])* ( sin((longitude2[j]-longitude2[j+1])/2)) ^2
    )

    ))*6366

    c_eau$di[j] = (2 * asin( sqrt(
      (sin((latitude2[j]-(coord_sondes$latitude[i]*(pi/180)))/2))^2 +
        cos(latitude2[j])*cos((coord_sondes$latitude[i]*(pi/180)))*
        ( sin((longitude2[j]-(coord_sondes$longitude[i]*(pi/180)))/2)) ^2
    )
    )
    )*6366

  }
  dist = c_eau$d[1:which(c_eau$di== min(c_eau$di))]
  coord_sondes$dist[i]=sum(dist)
  #print(sum(dist))

}


db_sonde_synthese$distance_source = round(coord_sondes$dist)
db_sonde_synthese = db_sonde_synthese[,-9]

rm(coursEau3)



# db_temp
db_temp = data.frame(id_sonde = db_sonde_synthese$id_sonde,
                     cours_eau = c("Monne", "Vie", "Taute", "Barge", "Grande Vallee",
                                   "Souleuvre", "See Rousse", "Egrenne", "Durance", "See",
                                   "Berence", "Glanon", "Vieux Ruisseau (Vingt bec)",
                                   "Fontaine au Heron", rep("Odon", 4), rep("Orne", 3),
                                   rep("Selune", 5), rep("Touques", 4)),
                     pos = c(3, 4, 14, 2, 13, 9, 12, 11, 10, 17, 16, 15, 8, 6,
                             rep(1, 4), rep(7, 3), rep(18, 5), rep(5, 4)))


#db_sonde_synthese$label

riv=c("La Monne","La Vie","La Taute","La Barges",
      "Ruisseau de la Grande Vallée", "La Souleuvre","La Sée Rousse","L’Egrenne",
      "La Durance","La Sée","La Bérence", "Le Glanon",
      "Ruisseau de Vingt Bec","La Fontaine au Héron","L'Odon T1","L'Odon T2",
      "L'Odon T4","L'Odon T5","L'Orne T1","L'Orne T3","L'Orne T2",
      "La Sélune T4","La Sélune T2","La Sélune T3","La Sélune T5","La Sélune T1",
      "La Touques T1","La Touques T3","La Touques T4","La Touques T6"
)

db_sonde_synthese$label = as.factor(db_sonde_synthese$label)

db_sonde_synthese$label <- factor(db_sonde_synthese$label,
                                  levels = db_sonde_synthese$label,
                                  labels =riv
)
db_sonde_synthese$label <- as.character(db_sonde_synthese$label)



# enregistrement des données dans un RData
save(db_sonde_synthese, db_temp, file = "RData/db_temp_synthese.RData")





############## Fichiers nc (données E-OBS) -----


sonde_lon = db_sonde_synthese$longitude
sonde_lat = db_sonde_synthese$latitude
sonde_coord = cbind(sonde_lon, sonde_lat)


# Température moyenne de l'air
nc_tair = raster::brick(paste0(path,temp_air_moy))


db_Tair_moy = raster::extract(nc_tair, sonde_coord, method = "bilinear")

rownames(db_Tair_moy) = db_sonde_synthese$id_sonde


db_Tair_moy_temp = t(db_Tair_moy)

db_Tair_moy = as.data.frame(db_Tair_moy_temp)
db_Tair_moy$date = ymd(substring(rownames(db_Tair_moy),2))

rownames(db_Tair_moy) = 1:nrow(db_Tair_moy)

rm(db_Tair_moy_temp)


# Pluviométrie
nc_pluvio = raster::brick(paste0(path,pluvio))


db_pluvio = raster::extract(nc_pluvio, sonde_coord, method = "bilinear")

rownames(db_pluvio) = db_sonde_synthese$id_sonde


db_pluvio_temp = t(db_pluvio)

db_pluvio = as.data.frame(db_pluvio_temp)
db_pluvio$date = ymd(substring(rownames(db_pluvio),2))

rownames(db_pluvio) = 1:nrow(db_pluvio)

rm(db_pluvio_temp)


# Température de l'air max
# nc_Tair_max = raster::brick(paste0(path,"nc_files/tx_ens_mean_0.1deg_reg_2011-2021_v24.0e.nc"))
#
#
# db_Tair_max = raster::extract(nc_Tair_max, sonde_coord, method = "bilinear")
#
# rownames(db_Tair_max) = db_sonde_synthese$id_sonde
#
#
# db_Tair_max_temp = t(db_Tair_max)
#
# db_Tair_max = as.data.frame(db_Tair_max_temp)
# db_Tair_max$date = ymd(substring(rownames(db_Tair_max),2))
#
# rownames(db_Tair_max) = 1:nrow(db_Tair_max)
#
# rm(db_Tair_max_temp)


# Température de l'air min
# nc_Tair_min = raster::brick(paste0(path,"nc_files/tn_ens_mean_0.1deg_reg_2011-2021_v24.0e.nc"))
#
#
# db_Tair_min = raster::extract(nc_Tair_min, sonde_coord, method = "bilinear")
#
# rownames(db_Tair_min) = db_sonde_synthese$id_sonde
#
#
# db_Tair_min_temp = t(db_Tair_min)
#
# db_Tair_min = as.data.frame(db_Tair_min_temp)
# db_Tair_min$date = ymd(substring(rownames(db_Tair_min),2))
#
# rownames(db_Tair_min) = 1:nrow(db_Tair_min)
#
# rm(db_Tair_min_temp)


# Température éclaircissement
nc_soleil = raster::brick(paste0(path,soleil))


db_soleil = raster::extract(nc_soleil, sonde_coord, method = "bilinear")

rownames(db_soleil) = db_sonde_synthese$id_sonde


db_soleil_temp = t(db_soleil)

db_soleil = as.data.frame(db_soleil_temp)
db_soleil$date = ymd(substring(rownames(db_soleil),2))

rownames(db_soleil) = 1:nrow(db_soleil)

rm(db_soleil_temp)



# enregistrement des bases de données

save(db_Tair_moy, db_pluvio,  db_soleil,
     file = "RData/db_nc_files.RData")



############## Piezométrie -----

### PiezoTouques
piezo_touques = read.table(paste0(path,"piezo/chroniquesTouques.txt"),
                           sep="|",dec=".",header=F,encoding="UTF_8",skip=1
)

piezo_touques=piezo_touques[,c(5,7)]
colnames(piezo_touques) = c("date","piezo")
piezo_touques$date = str_sub(piezo_touques$date,1, -10)

piezo_touques$date = as.Date(piezo_touques$date,format="%d/%m/%Y")


### PiezoOrne
piezo_orne = read.table(paste0(path,"piezo/chroniquesOrne.txt"),
                        sep="|",dec=".",header=F,encoding="UTF_8",skip=1
)

piezo_orne=piezo_orne[,c(5,7)]
colnames(piezo_orne) = c("date","piezo")
piezo_orne$date = str_sub(piezo_orne$date,1, -10)

piezo_orne$date = as.Date(piezo_orne$date,format="%d/%m/%Y")

# enregistrement des bases de données

save(piezo_orne, piezo_touques,
     file = "RData/db_piezo.RData")

