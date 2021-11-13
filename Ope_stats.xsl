<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes" doctype-system="operations.dtd"/>
    <xsl:strip-space elements="*"/>

    <xsl:variable name="stats" select="document('operations_stats.xml')/liste-stats"/>

    <xsl:template match="/">
        <secours-en-mer>
            <xsl:copy-of select="secours-en-mer/liste-cross"/>
            <liste-opérations>
                <xsl:apply-templates select="secours-en-mer/liste-opérations/opération"/>
            </liste-opérations>
        </secours-en-mer>
    </xsl:template>

    <xsl:template match="opération">
        <xsl:variable name="s" select="$stats/id(concat('stat.', current()/@operation_id))"/>
        <opération>
            <xsl:copy-of select="@*[not(name() = ('réception-alerte', 'fin-opération'))]"/>
            <jour>
                <xsl:attribute name="date" select="$s/date"/>
                <xsl:attribute name="jour" select="$s/jour_semaine"/>
                <xsl:attribute name="weekend" select="$s/est_weekend"/>
                <xsl:attribute name="jour_ferie" select="$s/est_jour_ferie"/>
                <xsl:if test="exists($s/est_vacances_scolaires)">
                    <xsl:attribute name="vacances_scolaires" select="$s/est_vacances_scolaires"/>
                </xsl:if>
                <xsl:if test="exists($s/phase_journee)">
                    <xsl:attribute name="phase_journee" select="$s/phase_journee"/>
                </xsl:if>
                <xsl:copy-of select="@réception-alerte | @fin-opération"/>
            </jour>
            <xsl:copy-of select="node()[not(name() = ('mer', 'coordination', 'situation'))]"/>
            <xsl:if test="exists($s/maree_coefficient) or exists($s/maree_categorie)">
                <mer>
                    <xsl:if test="exists($s/maree_coefficient)">
                        <xsl:attribute name="coefficient" select="$s/maree_coefficient"/>
                    </xsl:if>
                    <xsl:if test="exists($s/maree_categorie)">
                        <xsl:attribute name="categorie" select="$s/maree_categorie"/>
                    </xsl:if>
                    <xsl:copy-of select="mer/@* | mer/node()"/>
                </mer>
            </xsl:if>
            <coordination>
                <xsl:if test="exists($s/prefecture_maritime)">
                    <xsl:attribute name="prefecture_maritime" select="$s/prefecture_maritime"/>
                </xsl:if>
                <xsl:copy-of select="coordination/@* | coordination/node()"/>
            </coordination>
            <situation>
                <xsl:if test="exists($s/distance_cote_metres)">
                    <xsl:attribute name="distance_cote_metres" select="$s/distance_cote_metres"/>
                </xsl:if>
                <xsl:if test="exists($s/distance_cote_milles_nautiques)">
                    <xsl:attribute name="distance_cote_milles_nautiques"
                        select="$s/distance_cote_milles_nautiques"/>
                </xsl:if>
                <xsl:copy-of select="situation/@* | situation/node()"/>
            </situation>
        </opération>
    </xsl:template>

</xsl:stylesheet>
