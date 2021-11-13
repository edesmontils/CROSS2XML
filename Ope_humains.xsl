<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0" >
    <xsl:output method="xml" indent="no"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:variable name="humains" select="document('resultats_humain.xml')/liste-humains"/>

    <xsl:template match="/">
        <secours-en-mer>
            <xsl:copy-of select="secours-en-mer/liste-cross"/>
            <liste-opérations>
                <xsl:apply-templates select="secours-en-mer/liste-opérations/opération"/>
            </liste-opérations>
        </secours-en-mer>
    </xsl:template>
    
    <xsl:template match="opération">
        <xsl:variable name="h" select="$humains/id(concat('humain.',current()/@operation_id))"/> 
        <opération>
            <xsl:copy-of select="@* | node()"/>
            <xsl:if test="exists($h)">
                <bilan-humain catégorie="{replace($h/categorie_personne,' ','_')}" résultat="{$h/resultat_humain}">
                    <xsl:if test="$h/nombre ne '0'"><xsl:attribute name="nombre" select="$h/nombre"></xsl:attribute> </xsl:if>
                    <xsl:if test="$h/dont_nombre_blesse ne '0'"><xsl:attribute name="blessés" select="$h/dont_nombre_blesse"></xsl:attribute> </xsl:if>
                </bilan-humain>
            </xsl:if>
        </opération>
    </xsl:template>

</xsl:stylesheet>