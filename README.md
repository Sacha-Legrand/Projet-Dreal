# Projet-Dreal


- Dossier dashboard consiste en l'outil de data visualisation en R Shiny
- Dossier data_treatment permet la lecture des différentes sources de données ainsi que la création, la manipulation et l'enregistrement des bases de données utiles pour l'application R Shiny. C’est dans ce dossier que s'effectuent les mises à jour.
- Dossier Rmarkdown, contenant les analyses complémentaires réalisées par rapport à la classification, à l'Analyse Factorielle Indépendante (AFI) notamment.

Pour activer l’application en local : 
Se rendre dans le dossier dashboard 
Ouvrir le fichier “lectureRData.R” et modifier le chemin d’accès par celui correspondant à votre environnement dans le Working Directory
Lancer le fichier “lectureRData”
Ouvrir les fichiers ui et server et lancer l’application

—--------------------------------------------------------------

Architecture du code et organisation des données

Dossier data_treatment :
- Bilan activité sondes T.xlsx
- Description_Variables.ods
- dataLoading.R
- dataTreatment.R
- dataTreatmentAciAcp.R
- kml_files (données géographiques)
    - BV1.kml
    - cours_eau_projet.kml
    - Sondes T OFB.kml
- nc_files (données météorologiques E-OBS)
    - qq_ens_mean_0.1deg_reg_2011-2021_v24.0e.nc
    - rr_ens_mean_0.1deg_reg_2011-2021_v24.0e.nc
    - tg_ens_mean_0.1deg_reg_2011-2021_v24.0e.nc
- piezo : 
    - chroniques (données de piézométrie)
- RData (dossier dans lequel les bases de données sont enregistrées sous forme de RData)
- sondes (températures relevées par les différentes sondes .csv)

Dossier dashboard :
- lectureRData.R
- RData (dossier contenant les .RData)
- server.R
- ui.R
- www (contient les photos utilisées pour le R Shiny)

—--------------------------------------------------------------------------------------------------------------------

Pour la mise à jour des données : 

ATTENTION : Pour un soucis de non reproductibilité des analyses faites sur les ACP ACI, ne pas relancer le code dataTreatmentAciAcp.R

Les différents fichiers peuvent être mis à jour, il faut cependant veiller à ce qu'il garde le même nom et la même place ou alors changer le nom dans le code (dataLoading.R)

Les données météorologiques E-OBS se trouvent ici : https://surfobs.climate.copernicus.eu/dataaccess/access_eobs_chunks.php
(0.1 deg, ensemble mean)
- qq = rayonnement    - [https://knmi-ecad-assets-prd.s3.amazonaws.com/ensembles/data/Grid_0.1deg_reg_ensemble/qq_ens_mean_0.1deg_reg_2011-2021_v24.0e.nc]

- rr = pluviométrie
[https://knmi-ecad-assets-prd.s3.amazonaws.com/ensembles/data/Grid_0.1deg_reg_ensemble/rr_ens_mean_0.1deg_reg_2011-2021_v24.0e.nc]

- tg = température de l'air (moyenne journalière)
[https://knmi-ecad-assets-prd.s3.amazonaws.com/ensembles/data/Grid_0.1deg_reg_ensemble/tg_ens_mean_0.1deg_reg_2011-2021_v24.0e.nc]


Pour récupérer les bases de données utiles pour le R Shiny (RDATA) il faut :
- Éxecuter le fichier R dataLoading.R, (permet la lecture des différentes sources de données : csv, kml, nc... + enregistrement des premiers RData dans le sous dossier RData)
- Éxecuter le fichier R dataTreatment.R (permet de créer les bases utiles au R Shiny à partir des données sources dans treated_data.RData dans le sous dossier RData
- Déplacer ou copier les RData dans le sous dossier RData vers le sous dossier RData du dossier dashboard.

ATTENTION : 
Avant de lancer ces codes, veillez à modifier le chemin d’accès par celui correspondant à votre environnement dans le Working Directory

Une fois ces premières étapes accomplies, il faut :
- Éxecuter le fichier lectureRData.R (permet de lire les fichiers .RData)
- Éxecuter le fichier server.R et ui.R (lancer l'application)


