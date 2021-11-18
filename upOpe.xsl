<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="no"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/">
        <secours-en-mer>
            <!-- liste-cross>
                <xsl:for-each
                    select="distinct-values(liste-opérations/opération[exists(est_metropolitain)]/concat(cross, ':', fuseau_horaire, ':', est_metropolitain))">
                    <xsl:element name="cross">
                        <xsl:variable name="l" select="tokenize(., ':')"/>
                        <xsl:attribute name="nom" select="$l[1]"/>
                        <xsl:attribute name="fuseau-horaire" select="$l[2]"/>
                        <xsl:attribute name="xml:id" select="replace($l[1], ' ', '_')"/>
                        <xsl:attribute name="métropolitain" select="$l[3]"/>
                    </xsl:element>
                </xsl:for-each>
            </liste-cross-->
            <liste-cross>
                <cross nom="Antilles-Guyane"
                    fuseau-horaire="America/Cayenne"
                    xml:id="Antilles-Guyane"
                    métropolitain="False"/>
                <cross nom="Mayotte"
                    fuseau-horaire="Indian/Mayotte"
                    xml:id="Mayotte"
                    métropolitain="False"/>
                <cross nom="La Réunion"
                    fuseau-horaire="Indian/Reunion"
                    xml:id="La_Réunion"
                    métropolitain="False"/>
                <cross nom="Polynésie"
                    fuseau-horaire="Pacific/Tahiti"
                    xml:id="Polynésie"
                    métropolitain="False"/>
                <cross nom="Nouvelle-Calédonie"
                    fuseau-horaire="Pacific/Noumea"
                    xml:id="Nouvelle-Calédonie"
                    métropolitain="False"/>
                <cross nom="Gris-Nez"
                    fuseau-horaire="Europe/Paris"
                    xml:id="Gris-Nez"
                    métropolitain="True"/>
                <cross nom="Corsen"
                    fuseau-horaire="Europe/Paris"
                    xml:id="Corsen"
                    métropolitain="True"/>
                <cross nom="Jobourg"
                    fuseau-horaire="Europe/Paris"
                    xml:id="Jobourg"
                    métropolitain="True"/>
                <cross nom="La Garde"
                    fuseau-horaire="Europe/Paris"
                    xml:id="La_Garde"
                    métropolitain="True"/>
                <cross nom="Étel"
                    fuseau-horaire="Europe/Paris"
                    xml:id="Étel"
                    métropolitain="True"/>
                <cross nom="Corse"
                    fuseau-horaire="Europe/Paris"
                    xml:id="Corse"
                    métropolitain="True"/>
                <cross nom="Guyane"
                    fuseau-horaire="America/Guyana"
                    xml:id="Guyane"
                    métropolitain="False"/>
                <cross nom="Martinique"
                    fuseau-horaire="America/Martinique"
                    xml:id="Martinique"
                    métropolitain="False"/>
                <cross nom="Soulac"
                    fuseau-horaire="Europe/Paris"
                    xml:id="Soulac"
                    métropolitain="True"/>
                <cross nom="Adge"
                    fuseau-horaire="Europe/Paris"
                    xml:id="Adge"
                    métropolitain="True"/>
                <cross nom="Guadeloupe"
                    fuseau-horaire="America/Guadeloupe"
                    xml:id="Guadeloupe"
                    métropolitain="False"/>
            </liste-cross>
            <liste-opérations>
                <xsl:apply-templates select="liste-opérations/opération"/>
            </liste-opérations>
        </secours-en-mer>
    </xsl:template>

    <xsl:template match="opération">
        <opération operation_id="{./operation_id}" xml:id="{replace(./cross_sitrep, ' |/', '.')}"
            réception-alerte="{./date_heure_reception_alerte}"
            fin-opération="{./date_heure_fin_operation}" type="{./type_operation}">
            <evenement catégorie="{./categorie_evenement}">
                <xsl:value-of select="evenement"/>
            </evenement>
            <alerte pourquoi="{./pourquoi_alerte}" moyen="{./moyen_alerte}" qui="{./qui_alerte}"
                catégorie="{./categorie_qui_alerte}"/>
            <xsl:if
                test="exists(vent_force) or exists(vent_direction) or exists(vent_direction_categorie)">
                <vent force="{./vent_force}" direction="{./vent_direction}"
                    catégorie="{./vent_direction_categorie}">
                    <xsl:if test="exists(vent_force)">
                        <xsl:attribute name="force" select="vent_force"/>
                    </xsl:if>
                    <xsl:if test="exists(vent_direction)">
                        <xsl:attribute name="direction" select="vent_direction"/>
                    </xsl:if>
                    <xsl:if test="exists(vent_direction_categorie)">
                        <xsl:attribute name="catégorie" select="vent_direction_categorie"/>
                    </xsl:if>
                </vent>
            </xsl:if>
            <xsl:if test="exists(mer_force)">
                <mer force="{./mer_force}"/>
            </xsl:if>
            <situation zone_resposabilité="{./zone_responsabilite}">
                <xsl:if test="exists(departement)">
                    <xsl:attribute name="département" select="departement"/>
                </xsl:if>
                <xsl:if test="exists(latitude)">
                    <xsl:attribute name="latitude" select="latitude"/>
                </xsl:if>
                <xsl:if test="exists(longitude)">
                    <xsl:attribute name="longitude" select="longitude"/>
                </xsl:if>
            </situation>
            <coordination cross="{replace(./cross,' ','_')}" numéro-sitrep="{./numero_sitrep}"
                autorité="{./autorite}" seconde-autorité="{./seconde_autorite}"/>
        </opération>
    </xsl:template>

</xsl:stylesheet>
