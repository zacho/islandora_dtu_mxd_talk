<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sparql="http://www.w3.org/2001/sw/DataAccess/rf1/result"
    exclude-result-prefixes="sparql">
    
    <xsl:output indent="yes" method="xml"/>
    
    <xsl:variable name="BASEURL">
        <xsl:value-of select="$baseUrl"/>
<!--                <xsl:text>http://dgitest.conferences.dtu.dk/</xsl:text> -->
    </xsl:variable>
    <xsl:variable name="PID">
        <xsl:value-of select="$pid"/>
<!--                <xsl:text>cdio:23</xsl:text> -->
    </xsl:variable>
    <xsl:variable name="LABEL">
        <xsl:value-of select="$label"/>
<!--                <xsl:text>This is an example of a label</xsl:text> -->
    </xsl:variable>
    <xsl:variable name="PATH">
        <xsl:value-of select="$path"/>
<!--                <xsl:text>a/b/c</xsl:text> -->
    </xsl:variable>
    <xsl:variable name="RENDERPATH">
        <xsl:value-of select="$renderPath"/>
<!--                <xsl:text>a/b/c</xsl:text> -->
    </xsl:variable>
    <xsl:variable name="PAPEROBJ">
        <xsl:value-of select="$paperObj"/>
<!--                <xsl:text>fedora/repository/dtu:34/OBJ/x3%20paper%200.pdf</xsl:text> -->
    </xsl:variable>
    <xsl:variable name="PAPERIMG">
        <xsl:value-of select="$paperImg"/>
<!--                <xsl:text>sites/all/modules/islandora_dtu_mxd_talk/images/Crystal_Clear_mimetype_document_32.png</xsl:text> -->
    </xsl:variable>
    <xsl:variable name="SLIDEIMG">
        <xsl:value-of select="$slideImg"/>
<!--                <xsl:text>sites/all/modules/islandora_dtu_mxd_talk/images/Crystal_Clear_mimetype_pdf_32.png</xsl:text> -->
    </xsl:variable>
    <xsl:variable name="VIDEOIMG">
        <xsl:value-of select="$videoImg"/>
<!--                <xsl:text>sites/all/modules/islandora_dtu_mxd_talk/images/Crystal_noatun_32.png</xsl:text> -->
    </xsl:variable>
    
    <xsl:param name="separator" select="' ; '"/>
    <xsl:param name="delineator" select="' : '"/>
    
    <xsl:template match="/">
        <td class="solr-cell dtu-video mxdVideo">
            <xsl:if test="//sparql:result/sparql:content[@uri='info:fedora/islandora:dtu_dc_video_cmodel']">
                <xsl:variable name="VIDEOPATH">
                    <xsl:value-of select="$BASEURL"/>
                    <xsl:text>/fedora/repository/</xsl:text>
                    <xsl:value-of 
                        select="substring-after(//sparql:result/sparql:content[@uri='info:fedora/islandora:dtu_dc_video_cmodel']/parent::node()/sparql:object/attribute::uri,'info:fedora/')"/>
                    <xsl:value-of select="concat('/OBJ/',$LABEL,'.mp4')"/>
                </xsl:variable>
                <a href="{$VIDEOPATH}" rel="shadowbox;player=flv;height=480;width=640;content={$VIDEOPATH}&amp;image={$PATH}/images/ColorBars.gif&amp;controlbar=over&amp;autostart=false"><img alt="Play Video" src="{$VIDEOIMG}"/></a>
            </xsl:if>
        </td>
        <td class="solr-cell dtu-slides mxdSlides">
            <xsl:if test="//sparql:result/sparql:content[@uri='info:fedora/islandora:dtu_dc_slide_cmodel']">
                <xsl:variable name="SLIDEPID">
                    <xsl:value-of 
                        select="substring-after(//sparql:result/sparql:content[@uri='info:fedora/islandora:dtu_dc_slide_cmodel']/parent::node()/sparql:object/attribute::uri,'info:fedora/')"/>
                </xsl:variable>
                <xsl:variable name="SLIDEPATH">
                    <xsl:value-of select="$RENDERPATH"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$SLIDEPID"/>
                    <!-- <xsl:text>/OBJ/slide.pdf</xsl:text> -->
                </xsl:variable>
                <a href="{concat($BASEURL,'/fedora/repository/',$SLIDEPID,'/OBJ/',$LABEL,'_slide.pdf')}" onclick="Shadowbox.open({{ content: '{$SLIDEPATH}', player:'iframe'}}); return false;"><img alt="View Slides" src="{$SLIDEIMG}"/></a>
            </xsl:if>
        </td>
        <td class="solr-cell dtu-paper mxdPaper">
            <xsl:if test="$PAPEROBJ != ''">
                <!-- <a href="{concat($RENDERPATH,'/',$PID)}" onClick="location.href='http://www.google.ca/'"><img alt="View Paper" src="{$PAPERIMG}"/></a> -->
                <a href="{concat($BASEURL,'/fedora/repository/',$PID,'/OBJ/',$LABEL,'.pdf')}" onclick="Shadowbox.open({{ content: '{concat($RENDERPATH,'/',$PID)}', player:'iframe'}}); return false;"><img alt="View Paper" src="{$PAPERIMG}"/></a> 
                <!-- <a href="{concat($RENDERPATH,'/',$PID)}" rel="shadowbox" onClick="location.href='http://www.google.ca/'"><img alt="View Paper" src="{$PAPERIMG}"/></a> -->
            </xsl:if>
        </td>
    </xsl:template>
    
</xsl:stylesheet>
