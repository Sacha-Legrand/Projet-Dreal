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
if(!require(rsconnect)){
  install.packages("rsconnect")
  library(rsconnect)
}
if(!require(stringr)){
  install.packages("stringr")
  library(stringr)
}


############## Working Directory -----

# Path to working directory
#path = "D:/Users/Desktop/Cours/M2stat/Projet2/Projet-Dreal-main/dashboard/"
path = "/Users/julien/Desktop/projetM2/GitHub/dashboard/"

# Setting working Directory
setwd(path)


############## Lecture RData -----



#load("db_aci.RData")

load("RData/db.RData")
load("RData/KMLs.RData")
load("RData/db_temp_synthese.RData")
load("RData/db_nc_files.RData")
load("RData/db_piezo.RData")


load("RData/Variables.RData")

load("RData/db_aci_acp.RData")
load("RData/db_comparaison.RData")
load("RData/db_correlation.RData")
load("RData/db_cours_eau.RData")
load("RData/db_odriscoll.RData")
load("RData/db_stats_cours_eau.RData")
load("RData/dbG.RData")
