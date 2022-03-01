# Projet-Dreal


- Dossier dashboard consiste en l'outil de data visualisation en R Shiny
- Dossier data_treatment permet la lecture des différentes sources de données ainsi que la création, la manipulation et l'enregistrement des bases de données utiles pour l'application R Shiny

Dossier data_treatment :
- Bilan activité sondes T.xlsx
- dataLoading.R
- dataTreatment.R
- kml_files (données géographiques)
    - BV1.kml
    - cours_eau_projet.kml
    - Sondes T OFB.kml 
- nc_files (données météorologiques E-OBS)
    - qq_ens_mean_0.1deg_reg_2011-2021_v24.0e.nc
    - rr_ens_mean_0.1deg_reg_2011-2021_v24.0e.nc
    - tg_ens_mean_0.1deg_reg_2011-2021_v24.0e.nc
    - tn_ens_mean_0.1deg_reg_2011-2021_v24.0e.nc
    - tx_ens_mean_0.1deg_reg_2011-2021_v24.0e.nc 
- RData (dossier dans lequel les bases de données sont enregistrées sous forme de RData)
- sondes (températures relevées par les différentes sondes .csv)

Les différents fichiers peuvent être mis à jour, il faut cependant veiller à ce qu'il garde le même nom et la même place ou alors changer le nom dans le code (dataLoading.R)

Les données méétéorologiques E-OBS se trouvent ici : https://surfobs.climate.copernicus.eu/dataaccess/access_eobs_chunks.php
(0.1 deg, ensemble mean)
- qq = rayonnement 
- rr = pluviométrie
- tg = température de l'air (moyenne journalière)
- tn = température de l'air (minimum journalier)
- tx = température de l'air (maximum journalier)

Dossier dashboard :
- lectureRData.R
- RData (dossier contenant les .RData)
- server.R
- ui.R
- www
    - photos utilisées pour le R Shiny


Pour récupérer les bases de données utiles pour le R Shiny il faut :
- Éxecuter le fichier R dataLoading.R (permet la lecture des différentes sources de données : csv, kml, nc... + enregistrement des premiers RData dans le sous dossier RData)
- Éxecuter le fichier R dataTreatment.R (permet de créer les bases utiles au R Shiny à partir des données sources dans treated_data.RData dans le sous dossier RData
- Déplacer ou copier les RData dans le sous dossier RData vers le sous dossier RData du dossier dashboard.

Une fois ces premières étapes accomplies, il faut :
- Éxecuter le fichier lectureRData.R (permet de lire les fichiers .RData)
- Éxecuter le fichier server.R et ui.R (lancer l'application)





