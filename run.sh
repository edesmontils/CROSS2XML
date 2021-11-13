# python /Users/desmontils-e/Programmation/Python/csv2xml/csv2xml.py -i "operation_id" -f operations.csv -n opération -r liste-opérations -k
# python /Users/desmontils-e/Programmation/Python/csv2xml/csv2xml.py -i "operation_id numero_ordre" -f flotteurs.csv -n flotteur -r liste-flotteurs -k -g "opération. operation_id"
# python /Users/desmontils-e/Programmation/Python/csv2xml/csv2xml.py -i "operation_id" -f resultats_humain.csv -n humain -r liste-humains -k
# python /Users/desmontils-e/Programmation/Python/csv2xml/csv2xml.py -i "operation_id" -f operations_stats.csv -n stat -r liste-stats -k

java -jar ./saxon9he.jar -xsl:upOpe.xsl -s:operations.xml > operations2.xml
java -jar ./saxon9he.jar -xsl:Ope_humains.xsl -s:operations2.xml > operations3.xml
rm operations2.xml
java -jar ./saxon9he.jar -xsl:Ope_flotteurs.xsl -s:operations3.xml > operations4.xml
rm operations3.xml
java -jar ./saxon9he.jar -xsl:Ope_stats.xsl -s:operations4.xml > cross.xml
rm operations4.xml
head -n 3006 cross.xml > cross-light.xml
echo '</liste-opérations></secours-en-mer>' >> cross-light.xml