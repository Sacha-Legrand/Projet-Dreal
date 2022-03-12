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
path = "D:/Users/Desktop/Cours/M2stat/Projet3/Projet-Dreal-main/data_treatment/"
#path = "/Users/julien/Desktop/projetM2/GitHub/data_treatment/"

# Setting working Directory
setwd(path)


############## Chargement des données -----

load("RData/db_comparaison.RData")
load("RData/db_correlation.RData")
load("RData/db_nc_files.RData")
load("RData/db_piezo.RData")
load("RData/dbG.RData")


# ---------------------------------------------------------------------- # -----
#######################################
# PARTIE ACI ET ACP
#######################################
# bases de données difference Teau-Tair -----

db_teau_tair_diff = db_teau_tair2
db_teau_tair_diff = db_teau_tair_diff[,-1]
for (i in 1:(ncol(db_teau_tair_diff)/2)){
  db_teau_tair_diff[[paste0(substr(colnames(db_teau_tair_diff)[i],start=1,stop=3),"diff")]]= db_teau_tair_diff[,i]-db_teau_tair_diff[,i+30]

}
#db_teau_tair_diff=db_teau_tair_diff[,-c(31:60)]
db_teau_tair_diff$date=db_teau_tair2$date


# ACI sur la Touques (b_touques, mat_touques, b_touques_dif3, mat_touques_dif_3comp) -----

# ########################### #
# ACI MOYENNES JOURNALIERES
# ########################### #

# base pour la Touques
db_aci_moy_touques = db_xts_comp_teau_moy %>%
  dplyr::select(c("date", "825", "827", "828", "830"))

db_aci_moy_touques = na.omit(db_aci_moy_touques)


# preparation des donnees pour l'ACI à deux composantes
aci_t = db_aci_moy_touques %>%
  dplyr::select(c("date"))

aci_data = db_aci_moy_touques %>%
  dplyr::select(!c("date"))


# ACI à deux composantes sur les sondes de la Touques
set.seed(1)
a_touques <- fastICA(aci_data, 2, alg.typ = "parallel", fun = "logcosh", alpha = 1,
                     method = "R", row.norm = FALSE, maxit = 200,
                     tol = 0.0001, verbose = TRUE)


b_touques <- cbind(aci_t, data.frame(a_touques$S))
mat_touques <- a_touques$A

lab_comp = c()
for(i in 1:ncol(aci_data)){

  label_i = colnames(aci_data)[i]

  b_touques[paste0("comp1_", label_i)]=a_touques$A[1,i]*a_touques$S[,1]
  b_touques[paste0("comp2_", label_i)]=a_touques$A[2,i]*a_touques$S[,2]
  # b_touques[paste0("comp3_", label_i)]=a_touques$A[3,i]*a_touques$S[,3]

  lab_comp = c(lab_comp, paste0("comp1_", label_i), paste0("comp2_", label_i))#, paste0("comp3_", label_i))

}



#mat_touques_3comp = mat_touques
colnames(mat_touques)= c("Touques T1","Touques T3","Touques T4","Touques T6")
rownames(mat_touques)= c("Composante 1","Composante 2")#,"Composante 3")



# ########################### #
# ACI DIFFERENCE TEAU-TAIR
# ########################### #

# base pour la difference Teau-Tair de la Touques
db_aci_dif_touques = db_teau_tair_diff %>%
  dplyr::select(c("date", "825diff", "827diff", "828diff", "830diff"))

db_aci_dif_touques = na.omit(db_aci_dif_touques)



# preparation des donnees pour l'ACI à trois composantes
aci_t = db_aci_dif_touques %>%
  dplyr::select(c("date"))

aci_data = db_aci_dif_touques %>%
  dplyr::select(!c("date"))


# ACI à trois composantes sur la difference Teau-Tair des sondes de la Touques
set.seed(1)
a_touques_dif <- fastICA(aci_data, 3, alg.typ = "parallel", fun = "logcosh", alpha = 1,
                         method = "R", row.norm = FALSE, maxit = 200,
                         tol = 0.0001, verbose = TRUE)


b_touques_dif3 <- cbind(aci_t, data.frame(a_touques_dif$S))
mat_touques_dif <- a_touques_dif$A

lab_comp = c()
for(i in 1:ncol(aci_data)){

  label_i = colnames(aci_data)[i]

  b_touques_dif3[paste0("comp1_", label_i)]=a_touques_dif$A[1,i]*a_touques_dif$S[,1]
  b_touques_dif3[paste0("comp2_", label_i)]=a_touques_dif$A[2,i]*a_touques_dif$S[,2]
  b_touques_dif3[paste0("comp3_", label_i)]=a_touques_dif$A[3,i]*a_touques_dif$S[,3]

  lab_comp = c(lab_comp, paste0("comp1_", label_i), paste0("comp2_", label_i), paste0("comp3_", label_i))

}

mat_touques_dif_3comp = mat_touques_dif
colnames(mat_touques_dif_3comp)= c("Touques T1","Touques T3","Touques T4","Touques T6")
colnames(mat_touques_dif_3comp)= c("Touques T1","Touques T3","Touques T4","Touques T6")
rownames(mat_touques_dif_3comp)= c("Composante 1","Composante 2","Composante 3")





# ########################### #
# GRAPHE TEAU TAIR DIFFERENCE
# ########################### #
teau_tair_diff_touques = db_teau_tair_diff[, c("825Teau", "827Teau", "828Teau", "830Teau",
                                               "825Tair", "827Tair", "828Tair", "830Tair",
                                               "825diff", "827diff", "828diff", "830diff",
                                               "date")]
teau_tair_diff_touques = na.omit(teau_tair_diff_touques)




# ACI sur la Selune (b_selune2, mat_selune_2comp) -----


# ########################### #
# ACI DONNEES BRUTES BI-HORAIRE
# ########################### #

# base pour la Selune
db_aci_bih_selune = db_xts_comp_teau_bih %>%
  dplyr::select(c("t",  "824", "821", "823")) # sans la 822,"820",

db_aci_bih_selune = na.omit(db_aci_bih_selune)


# preparation des donnees pour l'ACI à deux composantes
aci_t = db_aci_bih_selune %>%
  dplyr::select(c("t"))

aci_data = db_aci_bih_selune %>%
  dplyr::select(!c("t"))


# ACI à deux composantes sur les sondes de la Touques
set.seed(1)
a_selune <- fastICA(aci_data, 2, alg.typ = "parallel", fun = "logcosh", alpha = 1,
                    method = "R", row.norm = FALSE, maxit = 200,
                    tol = 0.0001, verbose = TRUE)


b_selune2 <- cbind(aci_t, data.frame(a_selune$S))
mat_selune <- a_selune$A

lab_comp = c()
for(i in 1:ncol(aci_data)){

  label_i = colnames(aci_data)[i]

  b_selune2[paste0("comp1_", label_i)]=a_selune$A[1,i]*a_selune$S[,1]
  b_selune2[paste0("comp2_", label_i)]=a_selune$A[2,i]*a_selune$S[,2]

  lab_comp = c(lab_comp, paste0("comp1_", label_i), paste0("comp2_", label_i))

}


mat_selune_2comp = mat_selune
colnames(mat_selune_2comp)= c("Selune T1","Selune T2","Selune T5")
rownames(mat_selune_2comp)= c("Composante 1","Composante 2")



# ACP sur la Touques (res_ACP_825_diff_3comp_C1C2C3, res_ACP_827_diff_3comp_C1C2C3, res_ACP_828_diff_3comp_C1C2C3, res_ACP_830_diff_3comp_C1C2C3) -----

# ####################################### #
# ACP SUR LES 3 COMPOSANTES DE LA TOUQUES
# ####################################### #

# preparation de la base pour l'ACP
db_acp_diff_touques = merge(b_touques_dif3[,-c(2:4)],
                            db_teau_tair_diff[,c("825Teau", "827Teau", "828Teau", "830Teau",
                                                 "825Tair", "827Tair", "828Tair", "830Tair",
                                                 "825diff", "827diff", "828diff", "830diff",
                                                 "date")],
                            by="date")


db_acp_diff_touques = merge(db_acp_diff_touques, db_pluvio[,c("825","827","828","830","date")],by="date",all.x=T)
colnames(db_acp_diff_touques)[26:29] = c("pluvio_825","pluvio_827","pluvio_828","pluvio_830")

db_acp_diff_touques = merge(db_acp_diff_touques, db_soleil[,c("825","827","828","830","date")],by="date",all.x=T)
colnames(db_acp_diff_touques)[30:33] = c("sol_825","sol_827","sol_828","sol_830")

db_acp_diff_touques = merge(db_acp_diff_touques, piezo_touques,by="date",all.x=T)


# Récupération des dates seulement
acp_Touques_date <- db_acp_diff_touques$date


# ######## #
# sonde 825
# ######## #

# Preparation des donnes pour ACP sur sonde 825
acp_diff_Touques_825 <- db_acp_diff_touques[,c("comp1_825diff",  "comp2_825diff",  "comp3_825diff",
                                               "825Teau" ,"825Tair","825diff",
                                               "pluvio_825","sol_825" ,"piezo")]

colnames(acp_diff_Touques_825) = c("C1","C2","C3","Teau","Tair","Diff","rr","qq","piez")


# Recherche des valeurs manquantes dans la BDD au viveau de la piezo
sum(is.na(acp_diff_Touques_825)) == sum(is.na(acp_diff_Touques_825$piez))

# Imputation de donnees manquantes a l'aide de imputePCA(missMDA)
res.comp <- imputePCA(acp_diff_Touques_825)
acp_diff_Touques_825b <- res.comp$completeObs
sum(is.na(acp_diff_Touques_825b[,7])) # Plus de donnees manquantes dans la variable piezo


#colnames(acp_diff_Touques_825b)
acp_diff_Touques_825b=as.data.frame(acp_diff_Touques_825b)
acp_diff_Touques_825_c1c2 <- acp_diff_Touques_825b[,-3]
acp_diff_Touques_825_c1c3 <- acp_diff_Touques_825b[,-2]


# ACP
res.pca=PCA(acp_diff_Touques_825b, quanti.sup=7:9)

res.pca$eig
# Kaiser : garder les VPs au dessus de 1 => Dim1 - 2
# Plus de 95% de l'info est conserver avec les DIM 1 - 2
fviz_eig(res.pca, addlabels = TRUE, ylim = c(0, 50))
# Diagramme des ebouli : coude au niveau de la 3eme DIM, donc on garde les 2
# premiemes dimensions



res_ACP_825_diff_3comp_C1C2C3 <- fviz_pca_var(res.pca,axes = c(1, 3), col.var = "cos2",title ="",
                                              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
                                              repel = TRUE)

#res_ACP_825_diff_3comp_C1C2C3



# ######## #
# sonde 827
# ######## #

# Preparation des donnes pour ACP sur sonde 827
acp_diff_Touques_827 <- db_acp_diff_touques[,c("comp1_827diff",  "comp2_827diff",  "comp3_827diff",
                                               "827Teau" ,"827Tair","827diff",
                                               "pluvio_827","sol_827" ,"piezo")]

colnames(acp_diff_Touques_827) = c("C1","C2","C3","Teau","Tair","Diff","rr","qq","piez")


# Recherche des valeurs manquantes dans la BDD au viveau de la piezo
sum(is.na(acp_diff_Touques_827)) == sum(is.na(acp_diff_Touques_827$piez))

# Imputation de donnees manquantes a l'aide de imputePCA(missMDA)
res.comp <- imputePCA(acp_diff_Touques_827)
acp_diff_Touques_827b <- res.comp$completeObs
sum(is.na(acp_diff_Touques_827b[,7])) # Plus de donnees manquantes dans la variable piezo


colnames(acp_diff_Touques_827b)
acp_diff_Touques_827b=as.data.frame(acp_diff_Touques_827b)
acp_diff_Touques_827_c1c2 <- acp_diff_Touques_827b[,-3]
acp_diff_Touques_827_c1c3 <- acp_diff_Touques_827b[,-2]



# ACP
res.pca=PCA(acp_diff_Touques_827b, quanti.sup=7:9)

res.pca$eig
# Kaiser : garder les VPs au dessus de 1 => Dim1 - 2
# Plus de 95% de l'info est conserver avec les DIM 1 - 2
fviz_eig(res.pca, addlabels = TRUE, ylim = c(0, 50))
# Diagramme des ebouli : coude au niveau de la 3eme DIM, donc on garde les 2
# premiemes dimentions



res_ACP_827_diff_3comp_C1C2C3 <- fviz_pca_var(res.pca,axes = c(1, 2), col.var = "cos2",title ="",
                                              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
                                              repel = TRUE
)

#res_ACP_827_diff_3comp_C1C2C3



# ######## #
# sonde 828
# ######## #

# Preparation des donnes pour ACP sur sonde 828
acp_diff_Touques_828 <- db_acp_diff_touques[,c("comp1_828diff",  "comp2_828diff",  "comp3_828diff",
                                               "828Teau" ,"828Tair","828diff",
                                               "pluvio_828","sol_828" ,"piezo")]

colnames(acp_diff_Touques_828) = c("C1","C2","C3","Teau","Tair","Diff","rr","qq","piez")


# Recherche des valeurs manquantes dans la BDD au viveau de la piezo
sum(is.na(acp_diff_Touques_828)) == sum(is.na(acp_diff_Touques_828$piez))

# Imputation de donnees manquantes a l'aide de imputePCA(missMDA)
res.comp <- imputePCA(acp_diff_Touques_828)
acp_diff_Touques_828b <- res.comp$completeObs
sum(is.na(acp_diff_Touques_828b[,7])) # Plus de donnees manquantes dans la variable piezo


colnames(acp_diff_Touques_828b)
acp_diff_Touques_828b=as.data.frame(acp_diff_Touques_828b)
acp_diff_Touques_828_c1c2 <- acp_diff_Touques_828b[,-3]
acp_diff_Touques_828_c1c3 <- acp_diff_Touques_828b[,-2]



# ACP
res.pca=PCA(acp_diff_Touques_828b, quanti.sup=7:9)

res.pca$eig
# Kaiser : garder les VPs au dessus de 1 => Dim1 - 2
# Plus de 95% de l'info est conserver avec les DIM 1 - 2
fviz_eig(res.pca, addlabels = TRUE, ylim = c(0, 50))
# Diagramme des ebouli : coude au niveau de la 3eme DIM, donc on garde les 2
# premiemes dimensions



res_ACP_828_diff_3comp_C1C2C3 <- fviz_pca_var(res.pca,axes = c(1, 2), col.var = "cos2",title ="",
                                              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
                                              repel = TRUE
)

#res_ACP_828_diff_3comp_C1C2C3





# ######## #
# sonde 830
# ######## #

# Preparation des donnes pour ACP sur sonde 830
acp_diff_Touques_830 <- db_acp_diff_touques[,c("comp1_830diff",  "comp2_830diff",  "comp3_830diff",
                                               "830Teau" ,"830Tair","830diff",
                                               "pluvio_830","sol_830" ,"piezo"
)]

colnames(acp_diff_Touques_830) = c("C1","C2","C3","Teau","Tair","Diff","rr","qq","piez")


# Recherche des valeurs manquantes dans la BDD au viveau de la piezo
sum(is.na(acp_diff_Touques_830)) == sum(is.na(acp_diff_Touques_830$piez))

# Imputation de donnees manquantes a l'aide de imputePCA(missMDA)
res.comp <- imputePCA(acp_diff_Touques_830)
acp_diff_Touques_830b <- res.comp$completeObs
sum(is.na(acp_diff_Touques_830b[,7])) # Plus de donnees manquantes dans la variable piezo


colnames(acp_diff_Touques_830b)
acp_diff_Touques_830b=as.data.frame(acp_diff_Touques_830b)
acp_diff_Touques_830_c1c2 <- acp_diff_Touques_830b[,-3]
acp_diff_Touques_830_c1c3 <- acp_diff_Touques_830b[,-2]



# ACPres.pca=PCA(acp_diff_Touques_830b, quanti.sup=7:9)

res.pca$eig
# Kaiser : garder les VPs au dessus de 1 => Dim1 - 2
# Plus de 95% de l'info est conserver avec les DIM 1 - 2
fviz_eig(res.pca, addlabels = TRUE, ylim = c(0, 50))
# Diagramme des ebouli : coude au niveau de la 3eme DIM, donc on garde les 2
# premiemes dimensions



res_ACP_830_diff_3comp_C1C2C3 <- fviz_pca_var(res.pca,axes = c(1, 2), col.var = "cos2",title ="",
                                              gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
                                              repel = TRUE
)

#res_ACP_830_diff_3comp_C1C2C3



# tableau des correlations (correlation_touques) -----

# ######## #
# sonde 825
# ######## #

# Correlations
correlation_825 = matrix(rep(0,ncol(acp_diff_Touques_825b)^2),
                         ncol(acp_diff_Touques_825b),ncol(acp_diff_Touques_825b))

for(i in 1:ncol(acp_diff_Touques_825b)){
  for(j in 1:ncol(acp_diff_Touques_825b)){
    correlation_825[i,j]=round(cor(acp_diff_Touques_825b[,i],acp_diff_Touques_825b[,j]),3)
  }
}
correlation_825 = as.data.frame(correlation_825)
colnames(correlation_825) = colnames(acp_diff_Touques_825b)
rownames(correlation_825)=colnames(acp_diff_Touques_825b)


correlation_825 = correlation_825[-c(4:nrow(correlation_825)),-c(1:3)]
#correlation_825$Composantes = row.names(correlation_825)
#correlation_825$id_sonde = "825"




# Corrélations test
correlation_test = matrix(rep(0,ncol(acp_diff_Touques_825b)^2),
                          ncol(acp_diff_Touques_825b),ncol(acp_diff_Touques_825b))

for(i in 1:ncol(acp_diff_Touques_825b)){
  for(j in 1:ncol(acp_diff_Touques_825b)){
    correlation_test[i,j]=round(cor.test(acp_diff_Touques_825b[,i],acp_diff_Touques_825b[,j],method = "pearson")$p.value,3)
  }
}
correlation_test = as.data.frame(correlation_test)
colnames(correlation_test) = colnames(acp_diff_Touques_825b)
rownames(correlation_test)=colnames(acp_diff_Touques_825b)



for (i in 1:nrow(correlation_test)){
  for (j in 1:ncol(correlation_test)){
    ifelse(correlation_test[i,j] < 0.001,correlation_test[i,j] <-paste0(correlation_test[i,j], " (***)"),
           ifelse(correlation_test[i,j] < 0.01,correlation_test[i,j] <-paste0(correlation_test[i,j]," (**)"),
                  ifelse(correlation_test[i,j] < 0.05,correlation_test[i,j] <-paste0(correlation_test[i,j]," (*)"),
                         correlation_test[i,j] <- as.character(correlation_test[i,j])
                  )))
  }
}

correlation_test = correlation_test[-c(4:nrow(correlation_test)),-c(1:3)]



for (i in 1:nrow(correlation_825)){
  for (j in 1:ncol(correlation_825)){
    correlation_825[i,j] = paste0(correlation_825[i,j]," [",correlation_test[i,j],"]")

  }

}
correlation_825$Composantes = row.names(correlation_825)
correlation_825$id_sonde = "825"


# ######## #
# sonde 827
# ######## #

# Corrélations
correlation_827 = matrix(rep(0,ncol(acp_diff_Touques_827b)^2),
                         ncol(acp_diff_Touques_827b),ncol(acp_diff_Touques_827b))

for(i in 1:ncol(acp_diff_Touques_827b)){
  for(j in 1:ncol(acp_diff_Touques_827b)){
    correlation_827[i,j]=round(cor(acp_diff_Touques_827b[,i],acp_diff_Touques_827b[,j]),3)
  }
}
correlation_827 = as.data.frame(correlation_827)
colnames(correlation_827) = colnames(acp_diff_Touques_827b)
rownames(correlation_827)=colnames(acp_diff_Touques_827b)


correlation_827 = correlation_827[-c(4:nrow(correlation_827)),-c(1:3)]




# Corrélations test
correlation_test = matrix(rep(0,ncol(acp_diff_Touques_827b)^2),
                          ncol(acp_diff_Touques_827b),ncol(acp_diff_Touques_827b))

for(i in 1:ncol(acp_diff_Touques_827b)){
  for(j in 1:ncol(acp_diff_Touques_827b)){
    correlation_test[i,j]=round(cor.test(acp_diff_Touques_827b[,i],acp_diff_Touques_827b[,j],method = "pearson")$p.value,3)
  }
}
correlation_test = as.data.frame(correlation_test)
colnames(correlation_test) = colnames(acp_diff_Touques_827b)
rownames(correlation_test)=colnames(acp_diff_Touques_827b)



for (i in 1:nrow(correlation_test)){
  for (j in 1:ncol(correlation_test)){
    ifelse(correlation_test[i,j] < 0.001,correlation_test[i,j] <-paste0(correlation_test[i,j], " (***)"),
           ifelse(correlation_test[i,j] < 0.01,correlation_test[i,j] <-paste0(correlation_test[i,j]," (**)"),
                  ifelse(correlation_test[i,j] < 0.05,correlation_test[i,j] <-paste0(correlation_test[i,j]," (*)"),
                         correlation_test[i,j] <- as.character(correlation_test[i,j])
                  )))
  }
}

correlation_test = correlation_test[-c(4:nrow(correlation_test)),-c(1:3)]



for (i in 1:nrow(correlation_827)){
  for (j in 1:ncol(correlation_827)){
    correlation_827[i,j] = paste0(correlation_827[i,j]," [",correlation_test[i,j],"]")

  }

}

correlation_827$Composantes = row.names(correlation_827)
correlation_827$id_sonde = "827"


# ######## #
# sonde 828
# ######## #

correlation_828 = matrix(rep(0,ncol(acp_diff_Touques_828b)^2),
                         ncol(acp_diff_Touques_828b),ncol(acp_diff_Touques_828b))

for(i in 1:ncol(acp_diff_Touques_828b)){
  for(j in 1:ncol(acp_diff_Touques_828b)){
    correlation_828[i,j]=round(cor(acp_diff_Touques_828b[,i],acp_diff_Touques_828b[,j]),3)
  }
}
correlation_828 = as.data.frame(correlation_828)
colnames(correlation_828) = colnames(acp_diff_Touques_828b)
rownames(correlation_828)=colnames(acp_diff_Touques_828b)


correlation_828 = correlation_828[-c(4:nrow(correlation_828)),-c(1:3)]



# Corrélations test
correlation_test = matrix(rep(0,ncol(acp_diff_Touques_828b)^2),
                          ncol(acp_diff_Touques_828b),ncol(acp_diff_Touques_828b))

for(i in 1:ncol(acp_diff_Touques_828b)){
  for(j in 1:ncol(acp_diff_Touques_828b)){
    correlation_test[i,j]=round(cor.test(acp_diff_Touques_828b[,i],acp_diff_Touques_828b[,j],method = "pearson")$p.value,3)
  }
}
correlation_test = as.data.frame(correlation_test)
colnames(correlation_test) = colnames(acp_diff_Touques_828b)
rownames(correlation_test)=colnames(acp_diff_Touques_828b)



for (i in 1:nrow(correlation_test)){
  for (j in 1:ncol(correlation_test)){
    ifelse(correlation_test[i,j] < 0.001,correlation_test[i,j] <-paste0(correlation_test[i,j], " (***)"),
           ifelse(correlation_test[i,j] < 0.01,correlation_test[i,j] <-paste0(correlation_test[i,j]," (**)"),
                  ifelse(correlation_test[i,j] < 0.05,correlation_test[i,j] <-paste0(correlation_test[i,j]," (*)"),
                         correlation_test[i,j] <- as.character(correlation_test[i,j])
                  )))
  }
}

correlation_test = correlation_test[-c(4:nrow(correlation_test)),-c(1:3)]


for (i in 1:nrow(correlation_828)){
  for (j in 1:ncol(correlation_828)){
    correlation_828[i,j] = paste0(correlation_828[i,j]," [",correlation_test[i,j],"]")

  }

}
correlation_828$Composantes = row.names(correlation_828)
correlation_828$id_sonde = "828"


# ######## #
# sonde 830
# ######## #

correlation_830 = matrix(rep(0,ncol(acp_diff_Touques_830b)^2),
                         ncol(acp_diff_Touques_830b),ncol(acp_diff_Touques_830b))

for(i in 1:ncol(acp_diff_Touques_830b)){
  for(j in 1:ncol(acp_diff_Touques_830b)){
    correlation_830[i,j]=round(cor(acp_diff_Touques_830b[,i],acp_diff_Touques_830b[,j]),3)
  }
}
correlation_830 = as.data.frame(correlation_830)
colnames(correlation_830) = colnames(acp_diff_Touques_830b)
rownames(correlation_830)=colnames(acp_diff_Touques_830b)


correlation_830 = correlation_830[-c(4:nrow(correlation_830)),-c(1:3)]



# Corrélations test
correlation_test = matrix(rep(0,ncol(acp_diff_Touques_830b)^2),
                          ncol(acp_diff_Touques_830b),ncol(acp_diff_Touques_830b))

for(i in 1:ncol(acp_diff_Touques_830b)){
  for(j in 1:ncol(acp_diff_Touques_830b)){
    correlation_test[i,j]=round(cor.test(acp_diff_Touques_830b[,i],acp_diff_Touques_830b[,j],method = "pearson")$p.value,3)
  }
}
correlation_test = as.data.frame(correlation_test)
colnames(correlation_test) = colnames(acp_diff_Touques_830b)
rownames(correlation_test)=colnames(acp_diff_Touques_830b)



for (i in 1:nrow(correlation_test)){
  for (j in 1:ncol(correlation_test)){
    ifelse(correlation_test[i,j] < 0.001,correlation_test[i,j] <-paste0(correlation_test[i,j], " (***)"),
           ifelse(correlation_test[i,j] < 0.01,correlation_test[i,j] <-paste0(correlation_test[i,j]," (**)"),
                  ifelse(correlation_test[i,j] < 0.05,correlation_test[i,j] <-paste0(correlation_test[i,j]," (*)"),
                         correlation_test[i,j] <- as.character(correlation_test[i,j])
                  )))
  }
}

correlation_test = correlation_test[-c(4:nrow(correlation_test)),-c(1:3)]
correlation_test$Composantes = row.names(correlation_test)
correlation_test$id_sonde = "830"


for (i in 1:nrow(correlation_830)){
  for (j in 1:ncol(correlation_830)){
    correlation_830[i,j] = paste0(correlation_830[i,j]," [",correlation_test[i,j],"]")

  }

}
correlation_830$Composantes = row.names(correlation_830)
correlation_830$id_sonde = "830"


# ########################### #
# CORRELATIONS TOUQUES
# ########################### #

correlation_touques = rbind(correlation_825,correlation_827,correlation_828,correlation_830)

correlation_touques$id_sonde = as.factor(correlation_touques$id_sonde)
correlation_touques$Sonde = factor(correlation_touques$id_sonde ,
                                   levels =levels(correlation_touques$id_sonde),
                                   labels =riv[27:30]
)
correlation_touques$Composantes  = as.factor(correlation_touques$Composantes )
correlation_touques$Composantes = factor(correlation_touques$Composantes  ,
                                         levels =levels(correlation_touques$Composantes ),
                                         labels =c("Composante 1","Composante 2","Composante 3")
)
correlation_touques = correlation_touques[,-8]

correlation_touques=correlation_touques[,c(8,7,1:6)]
colnames(correlation_touques)
colnames(correlation_touques)=c("Sonde", "Composantes", "Température de l'eau",
                                "Température de l'air","Différence (Teau-Tair)",
                                "Pluviométrie", "Ensoleillement","Piézométrie" )
rm(correlation_825,correlation_827,correlation_828,correlation_830,correlation_test)


#                            ##############
#                            # SAVE RDATA #
#                            ##############
# enregistrement des donnees (RData/db_aci_acp.RData) -----
save(b_touques, mat_touques, b_touques_dif3, mat_touques_dif_3comp,
     b_selune2, mat_selune_2comp,db_aci_moy_touques,db_aci_bih_selune,
     teau_tair_diff_touques,
     res_ACP_825_diff_3comp_C1C2C3, res_ACP_827_diff_3comp_C1C2C3,
     res_ACP_828_diff_3comp_C1C2C3, res_ACP_830_diff_3comp_C1C2C3,
     correlation_touques,
     file = "RData/db_aci_acp.RData")


#######################################
# FIN PARTIE ACI ET ACP
#######################################
# ---------------------------------------------------------------------- # -----
