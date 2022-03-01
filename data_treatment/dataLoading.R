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




############## Working Directory -----

# Path to working directory
path = "/Users/julien/Desktop/projetM2/GitHub/data_treatment/"

# Setting working Directory
setwd(path)


############## Ajouter le code qui permet d'avoir db ? -----

# temporaire :
load("RData/db.RData")


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
db_sonde_synthese <- openxlsx::read.xlsx("Bilan activité sondes T.xlsx",sheet=1,
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

#as.character(db_sonde_synthese$id_sonde)
#str(db_sonde_synthese)



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



## db_temp
db_temp = data.frame(id_sonde = db_sonde_synthese$id_sonde, 
                     cours_eau = c("Monne", "Vie", "Taute", "Barge", "Grande Vallee",
                                   "Souleuvre", "See Rousse", "Egrenne", "Durance", "See",
                                   "Berence", "Glanon", "Vieux Ruisseau (Vingt bec)",
                                   "Fontaine au Heron", rep("Odon", 4), rep("Orne", 3),
                                   rep("Selune", 5), rep("Touques", 4)),
                     pos = c(3, 4, 14, 2, 13, 9, 12, 11, 10, 17, 16, 15, 8, 6, 
                             rep(1, 4), rep(7, 3), rep(18, 5), rep(5, 4)))

#Cette base de données te donne la position du cours d'eau dans coursEau2

#db_temp[which(db_temp$id_sonde == 830),]$pos



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
nc_tair = raster::brick(paste0(path,"/nc_files/tg_ens_mean_0.1deg_reg_2011-2021_v24.0e.nc"))


db_Tair_moy = raster::extract(nc_tair, sonde_coord, method = "bilinear")

rownames(db_Tair_moy) = db_sonde_synthese$id_sonde


db_Tair_moy_temp = t(db_Tair_moy)

db_Tair_moy = as.data.frame(db_Tair_moy_temp)
db_Tair_moy$date = ymd(substring(rownames(db_Tair_moy),2))

rownames(db_Tair_moy) = 1:nrow(db_Tair_moy)

rm(db_Tair_moy_temp)


# Pluviométrie
nc_pluvio = raster::brick(paste0(path,"/nc_files/rr_ens_mean_0.1deg_reg_2011-2021_v24.0e.nc"))


db_pluvio = raster::extract(nc_pluvio, sonde_coord, method = "bilinear")

rownames(db_pluvio) = db_sonde_synthese$id_sonde


db_pluvio_temp = t(db_pluvio)

db_pluvio = as.data.frame(db_pluvio_temp)
db_pluvio$date = ymd(substring(rownames(db_pluvio),2))

rownames(db_pluvio) = 1:nrow(db_pluvio)

rm(db_pluvio_temp)


# Température de l'air max
nc_Tair_max = raster::brick(paste0(path,"/nc_files/tx_ens_mean_0.1deg_reg_2011-2021_v24.0e.nc"))


db_Tair_max = raster::extract(nc_Tair_max, sonde_coord, method = "bilinear")

rownames(db_Tair_max) = db_sonde_synthese$id_sonde


db_Tair_max_temp = t(db_Tair_max)

db_Tair_max = as.data.frame(db_Tair_max_temp)
db_Tair_max$date = ymd(substring(rownames(db_Tair_max),2))

rownames(db_Tair_max) = 1:nrow(db_Tair_max)

rm(db_Tair_max_temp)


# Température de l'air min
nc_Tair_min = raster::brick(paste0(path,"/nc_files/tn_ens_mean_0.1deg_reg_2011-2021_v24.0e.nc"))


db_Tair_min = raster::extract(nc_Tair_min, sonde_coord, method = "bilinear")

rownames(db_Tair_min) = db_sonde_synthese$id_sonde


db_Tair_min_temp = t(db_Tair_min)

db_Tair_min = as.data.frame(db_Tair_min_temp)
db_Tair_min$date = ymd(substring(rownames(db_Tair_min),2))

rownames(db_Tair_min) = 1:nrow(db_Tair_min)

rm(db_Tair_min_temp)


# Température éclaircissement 
nc_soleil = raster::brick(paste0(path,"/nc_files/qq_ens_mean_0.1deg_reg_2011-2021_v24.0e.nc"))


db_soleil = raster::extract(nc_soleil, sonde_coord, method = "bilinear")

rownames(db_soleil) = db_sonde_synthese$id_sonde


db_soleil_temp = t(db_soleil)

db_soleil = as.data.frame(db_soleil_temp)
db_soleil$date = ymd(substring(rownames(db_soleil),2))

rownames(db_soleil) = 1:nrow(db_soleil)

rm(db_soleil_temp)



# enregistrement des bases de données

save(db_Tair_moy, db_pluvio, db_Tair_max, db_Tair_min, db_soleil, 
     file = "RData/db_nc_files.RData")












