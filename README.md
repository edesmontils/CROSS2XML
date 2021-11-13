# CROSS2XML
 Transformations des données de secours en mers vers XML

## Description

Cet outil permet de transformer les données CSV de secours en mer (https://www.data.gouv.fr/fr/datasets/operations-coordonnees-par-les-cross/) depuis 4 fichiers en CSV et un fichier XML. 

## Restrictions

Dans l'état actuel, toutes les informations du document "operations_stats.csv" ne sont pas récupérées.

## Processus

Le processus utilise d'abord l'outils csv2xml (https://github.com/edesmontils/csv2xml) pour transformer les données CSV en XML. Puis, une succession de transformations XSLT permettent d'enrichir "opération.xml" à l'aide des 3 autres documents ("flotteurs.xml", "operations_stats.xml" et "resultats_humains.xml"). Ce processus est décrit par le script SHELL "run.sh" :

```shell
python csv2xml.py -i "operation_id" -f operations.csv -n opération -r liste-opérations -k
python csv2xml.py -i "operation_id numero_ordre" -f flotteurs.csv -n flotteur -r liste-flotteurs -k -g "opération. operation_id"
python csv2xml.py -i "operation_id" -f resultats_humain.csv -n humain -r liste-humains -k
python csv2xml.py -i "operation_id" -f operations_stats.csv -n stat -r liste-stats -k

java -jar ./saxon9he.jar -xsl:upOpe.xsl -s:operations.xml > operations2.xml
java -jar ./saxon9he.jar -xsl:Ope_humains.xsl -s:operations2.xml > operations3.xml
rm operations2.xml
java -jar ./saxon9he.jar -xsl:Ope_flotteurs.xsl -s:operations3.xml > operations4.xml
rm operations3.xml
java -jar ./saxon9he.jar -xsl:Ope_stats.xsl -s:operations4.xml > cross.xml
rm operations4.xml
```

Le résultat du processus permet d'obtenir le document "cross.xml" qui respecte le schéma DTD "operations.dtd".

## Copyright

© E. Desmontils, Université de Nantes, Novembre 2021
