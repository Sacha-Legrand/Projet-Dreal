



db_sonde_synthese = read.csv2("/Users/julien/Desktop/projetM2/fiche_sonde_synthese/fiche_synthese.csv", sep=";", header=T)
head(db_sonde_synthese)
str(db_sonde_synthese)


# ajouter 
#  - altitude
#  - debit
#  - distance à la source
#  - commentaire du tableau
#  - commentaire du graphe


as.character(db_sonde_synthese$id_sonde)

c("104"="104", "105"="105", "108"="108", "109"="109", "300"="300", 
  "762"="762", "763"="763", "764"="764", "765"="765", "766"="766",
  "768"="768", "769"="769", "771"="771", "811"="811", "812"="812",
  "813"="813", "815"="815", "816"="816", "817"="817", "818"="818",
  "819"="819", "820"="820", "821"="821", "822"="822", "823"="823",
  "824"="824", "825"="825", "827"="827", "828"="828", "830"="830")