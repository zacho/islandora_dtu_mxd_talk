<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:mxd="http://mx.forskningsdatabasen.dk/ns/mxd/1.2"
    exclude-result-prefixes="mxd"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- 
        This stylesheet transforms certain DDF-MXD 1.2.1 documents to simple Dublin Core
        records, based on a mapping document received from the Danish Technical University
        (Danmarks Tekniske Universitet - DTU).  
        
        The style was tested with a small sample of approximately 150 DDF-MXD records from
        a common source; therefore, caution would be advised when using this transform
        for wider purposes.
        
        Version 1.0     2011-12-12      Zachary Howarth-Schueler <zac@yesguy.biz>
    -->
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="/">
        <xsl:if test="mxd:ddf_doc">
            <oai_dc:dc xsi:schemaLocation="http://www.openarchives.org/OAI/2.0/oai_dc/ http://www.openarchives.org/OAI/2.0/oai_dc.xsd">
                <!-- First, grab some attributes: -->
                <xsl:choose>
                    <xsl:when test="mxd:ddf_doc/attribute::rec_upd">
                        <dc:date><xsl:value-of select="mxd:ddf_doc/attribute::rec_upd"/></dc:date>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::rec_created">
                        <dc:date><xsl:value-of select="mxd:ddf_doc/attribute::rec_created"/></dc:date>
                    </xsl:when>
                </xsl:choose>
                
                <!-- Substitute record type codes -->
                <xsl:choose>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='dja'">
                        <dc:type><xsl:text>Journal article</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='djl'">
                        <dc:type><xsl:text>Journal letter (to the editor)</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='djc'">
                        <dc:type><xsl:text>Journal comment</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='djr'">
                        <dc:type><xsl:text>Journal review article</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='djb'">
                        <dc:type><xsl:text>Journal book review</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='db'">
                        <dc:type><xsl:text>Book</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='dba'">
                        <dc:type><xsl:text>Book chapter</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='dbp'">
                        <dc:type><xsl:text>Book preface, encyclopedia article</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='dct'">
                        <dc:type><xsl:text>Conference talk/presentation</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='dcp'">
                        <dc:type><xsl:text>Conference paper</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='dco'">
                        <dc:type><xsl:text>Conference poster</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='dca'">
                        <dc:type><xsl:text>Conference abstract</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='dna'">
                        <dc:type><xsl:text>Newspaper article</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='dtd'">
                        <dc:type><xsl:text>Thesis Doctoral</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='dtp'">
                        <dc:type><xsl:text>Thesis Ph.D.</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='dtm'">
                        <dc:type><xsl:text>Thesis Master</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='dts'">
                        <dc:type><xsl:text>Student report</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='dr'">
                        <dc:type><xsl:text>Report</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='dra'">
                        <dc:type><xsl:text>Report chapter</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='dr'">
                        <dc:type><xsl:text>Report</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='dra'">
                        <dc:type><xsl:text>Report chapter</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='dl'">
                        <dc:type><xsl:text>Lecture</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='dln'">
                        <dc:type><xsl:text>Lecture notes</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='dw'">
                        <dc:type><xsl:text>Working paper</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='dp'">
                        <dc:type><xsl:text>Patent</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='do'">
                        <dc:type><xsl:text>Other</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='dso'">
                        <dc:type><xsl:text>Software</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='dd'">
                        <dc:type><xsl:text>Data set</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_type='drt'">
                        <dc:type><xsl:text>Radio/TV broadcast</xsl:text></dc:type>
                    </xsl:when>
                    <xsl:otherwise>
                        <dc:type><xsl:value-of select="mxd:ddf_doc/attribute::doc_type"/></dc:type>
                    </xsl:otherwise>
                </xsl:choose>
                
                <!-- ISO 639-3 Language code is okay -->
                <xsl:if test="mxd:ddf_doc/attribute::doc_lang">
                    <dc:language><xsl:value-of select="mxd:ddf_doc/attribute::doc_lang"/></dc:language>
                </xsl:if>
                
                <!-- Substitute Audience types -->
                <xsl:choose>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_level='adm'">
                        <dc:audience><xsl:text>Administrative</xsl:text></dc:audience>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_level='pop'">
                        <dc:audience><xsl:text>Popular</xsl:text></dc:audience>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_level='und'">
                        <dc:audience><xsl:text>Undetermined</xsl:text></dc:audience>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_level='sci'">
                        <dc:audience><xsl:text>Scientific</xsl:text></dc:audience>
                    </xsl:when>
                    <xsl:when test="mxd:ddf_doc/attribute::doc_level='edu'">
                        <dc:audience><xsl:text>Educational</xsl:text></dc:audience>
                    </xsl:when>
                </xsl:choose>
                
                <!-- Apply remaining templates -->
                <xsl:apply-templates/>
            </oai_dc:dc>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="mxd:title">
        <xsl:for-each select="mxd:original">
            <xsl:if test="mxd:main != ''">
                <dc:title>
                    <xsl:value-of select="mxd:main"/>
                    <xsl:for-each select="mxd:sub">
                        <xsl:text>: </xsl:text>
                        <xsl:value-of select="."/>
                    </xsl:for-each>
                    <xsl:for-each select="mxd:part">
                        <xsl:text> (</xsl:text>
                        <xsl:value-of select="."/>
                        <xsl:text>)</xsl:text>
                    </xsl:for-each>
                </dc:title>                
            </xsl:if>
        </xsl:for-each>
        <xsl:for-each select="mxd:translated">
            <xsl:if test="mxd:main != ''">
                <dc:title>
                    <xsl:value-of select="mxd:main/text()"/>
                    <xsl:for-each select="mxd:sub/text()">
                        <xsl:text>: </xsl:text>
                        <xsl:value-of select="./text()"/>
                    </xsl:for-each>
                    <xsl:for-each select="mxd:part/text()">
                        <xsl:text> (</xsl:text>
                        <xsl:value-of select="./text()"/>
                        <xsl:text>)</xsl:text>
                    </xsl:for-each>            
                </dc:title>
            </xsl:if>

        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="mxd:description">
        <xsl:for-each select="mxd:abstract">
            <dc:description>
                <xsl:value-of select="text()"/>
            </dc:description>
        </xsl:for-each>
        <xsl:for-each select="mxd:note">
            <dc:description>
                <xsl:value-of select="text()"/>
            </dc:description>
        </xsl:for-each>
        <xsl:for-each select="mxd:subject/mxd:class">
            <dc:subject>
                <xsl:if test="@class_type">
                    <xsl:value-of select="@class_type"/>
                    <xsl:text>: </xsl:text>
                </xsl:if>
                <xsl:value-of select="text()"/>
            </dc:subject>
        </xsl:for-each>
        <xsl:for-each select="mxd:subject/mxd:keyword">
            <xsl:if test="text() != ''">
                <dc:subject>
<!--                    <xsl:if test="@key_type">
                        <xsl:value-of select="@key_type"/>
                        <xsl:text>: </xsl:text>
                    </xsl:if>-->
                    <xsl:value-of select="text()"/>
                </dc:subject>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="mxd:person">
        <xsl:if test="mxd:name/mxd:first != '' or mxd:name/mxd:last != ''">
            <xsl:choose>
                <xsl:when test="@pers_role='pau' or @pers_role='pa1' or @pers_role='pa2'">
                    <dc:creator>
                        <xsl:value-of select="mxd:name/mxd:last/text()"/>
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="mxd:name/mxd:first/text()"/>
                    </dc:creator>
                </xsl:when>
                <xsl:otherwise> <!--<xsl:when test="@pers_role='ped' or @pers_role='ppu' or @pers_role='ptr' or @pers_role='pil' or @pers_role='inv' or @pers_role='sup'"></xsl:when>-->
                    <dc:contributor>
                        <xsl:value-of select="mxd:name/mxd:last/text()"/>
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="mxd:name/mxd:first/text()"/>
                    </dc:contributor>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="mxd:organisation">
        <xsl:choose>
            <xsl:when test="@org_role='oau'">
                <xsl:if test="mxd:name/mxd:level1 != ''">
                    <dc:creator>
                        <xsl:value-of select="normalize-space(concat(
                            mxd:name/mxd:level1/text(),
                            ' ',
                            mxd:name/mxd:level2/text(),
                            ' ',
                            mxd:name/mxd:level3/text(),
                            ' ',
                            mxd:name/mxd:level4/text(),
                            ' '
                            ))"/>
                    </dc:creator>
                </xsl:if>
            </xsl:when>
            <xsl:when test="@org_role='oaf'"><!-- nada --></xsl:when>
            <xsl:when test="@org_role='opu'">
                <xsl:if test="mxd:name/mxd:level1 != ''">
                    <dc:publisher>
                        <xsl:value-of select="normalize-space(concat(
                            mxd:name/mxd:level1/text(),
                            ' ',
                            mxd:name/mxd:level2/text(),
                            ' ',
                            mxd:name/mxd:level3/text(),
                            ' ',
                            mxd:name/mxd:level4/text(),
                            ' '
                            ))"/>
                    </dc:publisher>                    
                </xsl:if>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!-- over-stepping a bit here... -->
    <xsl:template match="mxd:event">
        <xsl:for-each select="mxd:title/mxd:full">
            <xsl:if test="text() != ''">
                <dc:source>
                    <xsl:value-of select="text()"/>
                </dc:source>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="mxd:publisher">
        <xsl:if test="text() != ''">
            <dc:publisher>
                <xsl:value-of select="text()"/>
            </dc:publisher>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="mxd:publication">
        <xsl:for-each select="*/mxd:isbn">
            <dc:source>
                <xsl:text>ISBN: </xsl:text>
                <xsl:value-of select="text()"/>
            </dc:source>
        </xsl:for-each>
        <xsl:for-each select="*/mxd:issn">
            <dc:source>
                <xsl:text>ISSN: </xsl:text>
                <xsl:value-of select="concat(
                    substring(text(),1,4),
                    '-',
                    substring(text(),5))"/>
            </dc:source>
        </xsl:for-each>
        <xsl:for-each select="*/mxd:publisher">
            <dc:publisher>
                <xsl:value-of select="text()"/>
            </dc:publisher>
        </xsl:for-each>
        <xsl:if test="mxd:patent">
            <xsl:for-each select="mxd:patent/mxd:date">
                <dc:date><xsl:value-of select="text()"/></dc:date>
            </xsl:for-each>
            <xsl:if test="mxd:patent/mxd:country and mxd:patent/mxd:ipc and mxd:patent/mxd:number">
                <dc:source>
                    <xsl:value-of select="concat(
                        mxd:patent/mxd:country/text(),
                        ', ',
                        mxd:patent/mxd:ipc,
                        ', [',
                        mxd:patent/mxd:number,
                        ']'
                    )"/>
                </dc:source>
            </xsl:if>
        </xsl:if>
        <xsl:for-each select="*[@pub_status]">
            <dc:type>
                <xsl:choose>
                    <xsl:when test="@pub_status='a'"><xsl:text>Accepted</xsl:text></xsl:when>
                    <xsl:when test="@pub_status='s'"><xsl:text>Submitted</xsl:text></xsl:when>
                    <xsl:when test="@pub_status='i'"><xsl:text>In press</xsl:text></xsl:when>
                    <xsl:when test="@pub_status='p'"><xsl:text>Published</xsl:text></xsl:when>
                </xsl:choose>
            </dc:type>
        </xsl:for-each>
        <xsl:for-each select="mxd:digital_object/mxd:file[@mime_type]">
            <dc:format><xsl:value-of select="@mime_type"/></dc:format>
        </xsl:for-each>
        <xsl:for-each select="mxd:digital_object/mxd:uri">
            <dc:identifier><xsl:value-of select="text()"/></dc:identifier>
        </xsl:for-each>
        <xsl:for-each select="mxd:in_journal">
            <dc:source>
                <xsl:value-of select="mxd:title"/>
                <xsl:if test="mxd:vol">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mxd:vol/text()"/>
                </xsl:if>
                <xsl:if test="mxd:issue">
                    <xsl:text>(</xsl:text>
                    <xsl:value-of select="mxd:issue/text()"/>
                    <xsl:text>)</xsl:text>
                </xsl:if>
                <xsl:if test="mxd:pages">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="mxd:pages/text()"/>
                </xsl:if>
            </dc:source>
        </xsl:for-each>
        <xsl:for-each select="mxd:in_book">
            <dc:source>
                <xsl:if test="mxd:editor">
                    <xsl:value-of select="mxd:editor/text()"/>
                    <xsl:text>, </xsl:text>
                </xsl:if>
                <xsl:value-of select="mxd:title"/>
                <xsl:if test="mxd:pages">
                    <xsl:text> (</xsl:text>
                    <xsl:value-of select="mxd:pages/text()"/>
                    <xsl:text>)</xsl:text>
                </xsl:if>
                <xsl:text>.</xsl:text>
                <xsl:if test="mxd:place">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="mxd:place/text()"/>
                    <xsl:text>:</xsl:text>
                </xsl:if>
                <xsl:if test="mxd:publisher">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="mxd:publisher/text()"/>
                </xsl:if>
            </dc:source>
        </xsl:for-each>
        <xsl:for-each select="mxd:in_report">
            <dc:source>
                <xsl:if test="mxd:editor">
                    <xsl:value-of select="mxd:editor/text()"/>
                    <xsl:text>. </xsl:text>
                </xsl:if>
                <xsl:if test="mxd:year">
                    <xsl:text>(</xsl:text>
                    <xsl:value-of select="mxd:year/text()"/>
                    <xsl:text>). </xsl:text>
                </xsl:if>
                <xsl:value-of select="mxd:title"/>
                <xsl:if test="mxd:rep_no">
                    <xsl:text> (</xsl:text>
                    <xsl:value-of select="mxd:rep_no/text()"/>
                    <xsl:text>)</xsl:text>
                </xsl:if>
                <xsl:text>.</xsl:text>
                <xsl:if test="mxd:place">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="mxd:place/text()"/>
                    <xsl:text>:</xsl:text>
                </xsl:if>
                <xsl:if test="mxd:publisher">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="mxd:publisher/text()"/>
                </xsl:if>
            </dc:source>
        </xsl:for-each>
        <xsl:if test="mxd:book/mxd:series">
            <dc:source>
                <xsl:value-of select="mxd:book/mxd:series/text()"/>
                <xsl:if test="mxd:book/mxd:pages">
                    <xsl:value-of select="mxd:book/mxd:pages/text()"/>
                </xsl:if>
            </dc:source>
        </xsl:if>
    </xsl:template>
    
    <!-- suppress all else:-->
    <xsl:template match="text()|@*"/>
    
</xsl:stylesheet>