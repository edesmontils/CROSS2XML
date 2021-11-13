<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0" >
    <xsl:output method="xml" indent="no"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:variable name="flotteurs" select="document('flotteurs.xml')/liste-flotteurs"/>

    <xsl:template match="/">
        <secours-en-mer>
            <xsl:copy-of select="secours-en-mer/liste-cross"/>
            <liste-opérations>
                <xsl:apply-templates select="secours-en-mer/liste-opérations/opération"/>
            </liste-opérations>
        </secours-en-mer>
    </xsl:template>
    
    <xsl:template match="opération">
        <opération>
            <xsl:copy-of select="@* | node()"/>
            <liste-flotteurs>
                <xsl:apply-templates select="$flotteurs/id(concat('opération.',current()/@operation_id))/flotteur"/>
            </liste-flotteurs>
        </opération>
    </xsl:template>

    <xsl:template match="flotteur">
        <flotteur no="{./numero_ordre}" résultat="{replace(replace(replace(./resultat_flotteur,' ','_'),',', '_'),'/','_')}" 
            type="{./type_flotteur}" catégorie="{replace(./categorie_flotteur,' ','_')}">
            <xsl:if test="exists(numero_immatriculation)"><xsl:attribute name="immatriculation" select="./numero_immatriculation"></xsl:attribute></xsl:if>
            <xsl:if test="exists(pavillon)"><xsl:attribute name="pavillon" select="./pavillon"></xsl:attribute></xsl:if>
        </flotteur>
    </xsl:template>

</xsl:stylesheet>