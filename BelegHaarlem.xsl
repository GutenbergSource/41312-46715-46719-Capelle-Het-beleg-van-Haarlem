<!DOCTYPE xsl:stylesheet [

    <!ENTITY ccedil "&#x00e7;">
    <!ENTITY mdash "&#x2014;">
    <!ENTITY ndash "&#x2013;">

]>
<xsl:transform
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:f="urn:stylesheet-functions"
    exclude-result-prefixes="f xs"
    version="2.0">


<xsl:include href="../../../../../Tools/tei2html/merge-documents.xsl"/>


<xsl:variable name="volume1" select="f:import-document('Deel 1/Processed/BelegHaarlem1.xml', /, 'v1', 'v2 v3')"/>
<xsl:variable name="volume2" select="f:import-document('Deel 2/Processed/BelegHaarlem2.xml', /, 'v2', 'v1 v3')"/>
<xsl:variable name="volume3" select="f:import-document('Deel 3/Processed/BelegHaarlem3.xml', /, 'v3', 'v1 v2')"/>


<xsl:template match="/">
    <TEI.2 lang="nl-1900">
    <teiHeader>
        <fileDesc>
            <titleStmt>
                <title>Het beleg en de verdediging van Haarlem in 1572&ndash;1573</title>
                <author>J. van de Capelle [Pseud. van Jacques Fran&ccedil;ois Bosdijk] (1812&ndash;1850)</author>
                <respStmt><resp>Transcription</resp> <name>Jeroen Hellingman</name></respStmt>
                <respStmt><resp>Transcription</resp> <name>Project Gutenberg Distributed Proofreaders</name></respStmt>
            </titleStmt>
            <publicationStmt>
                <publisher>Project Gutenberg</publisher>
                <pubPlace>Urbana, Illinois, USA.</pubPlace>
                <idno type="LCCN">#####</idno>
                <idno type="OLW">#####</idno>
                <idno type="OCLC">#####</idno>
                <idno type="PGclearance">20100824140912capelle</idno>
                <idno type="epub-id">urn:uuid:d9be08a7-0709-46c2-b181-04d4b71d0983</idno>
                <idno type="PGSrc">41312-46715-46719-Capelle-Het-beleg-van-Haarlem</idno>
                <idno type="PGnum">#####</idno>
                <date>#####</date>

                <xsl:apply-templates select="$volume1//teiHeader/fileDesc/publicationStmt/availability"/>

            </publicationStmt>
            <sourceDesc>
                <bibl>
                <author>J. van de Capelle</author>
                <title>Het beleg en de verdediging van Haarlem in 1572&ndash;1573</title>
                <date>1886</date>
                </bibl>
            </sourceDesc>
        </fileDesc>

        <xsl:apply-templates select="$volume1//teiHeader/encodingDesc"/>
        <xsl:apply-templates select="$volume1//teiHeader/profileDesc"/>

        <revisionDesc>
            <list type="simple">
                <item>2014-03-04 Started.</item>
            </list>
        </revisionDesc>
    </teiHeader>
    <text rend="stylesheet(style/classic.css)">
        <front id="frontmatter">
            <div1 id="cover" type="Cover">
                <p>
                    <figure id="cover-image" rend="image(images/cover.jpg))">
                        <figDesc>Oorspronkelijke voorkant.</figDesc>
                    </figure>
                </p>
            </div1>

            <xsl:apply-templates select="$volume1//front/div1[@id='v1titlepage']"/>
            <xsl:apply-templates select="$volume1//front/titlePage"/>

        </front>
        <body>
            <div0 id="pt1">
                <head>EERSTE DEEL.</head>
                <xsl:apply-templates select="$volume1//body/*"/>
            </div0>

            <div0 id="pt2">
                <head>TWEEDE DEEL.</head>
                <xsl:apply-templates select="$volume2//body/*"/>
            </div0>

            <div0 id="pt3">
                <head>DERDE DEEL.</head>
                <xsl:apply-templates select="$volume3//body/*"/>
            </div0>
        </body>
        <back id="backmatter">
            <xsl:apply-templates select="$volume3//back/div1"/>

            <div1 id="toc">
                <divGen id="genToc" type="toc"/>
            </div1>

            <divGen type="Colophon"/>
        </back>
    </text>
    </TEI.2>
</xsl:template>


<!-- Resolve cross-volume links encoded as external links to Project Gutenberg numbers -->
<xsl:template match="xref">
    <xsl:choose>
        <xsl:when test="starts-with(@url, 'pg:999991#')">
            <xsl:variable name="targetId" select="concat('v1', substring-after(@url, '#'))"/>
            <ref target="$targetId"><xsl:apply-templates/></ref>
        </xsl:when>
        <xsl:otherwise>
            <xsl:copy-of select="."/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>


<!-- Drop volume indication on title page -->
<xsl:template match="ab[@id='v1volumetitle']"/>


<xsl:template match="node()|@*">
    <xsl:copy>
        <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
</xsl:template>


</xsl:transform>
