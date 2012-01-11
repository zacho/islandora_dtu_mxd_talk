<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:mxd="http://mx.forskningsdatabasen.dk/ns/mxd/1.2"
    exclude-result-prefixes="mxd">
    
    <xsl:output indent="yes" method="xml"/>
    
    <xsl:variable name="BASEURL">
        <xsl:value-of select="$baseUrl"/>
<!--        <xsl:text>http://dgitest.conferences.dtu.dk/</xsl:text> -->
    </xsl:variable>
    <xsl:variable name="PATH">
        <xsl:value-of select="$path"/>
<!--        <xsl:text>a/b/c</xsl:text> -->
    </xsl:variable>
    <xsl:param name="separator" select="' ; '"/>
    <xsl:param name="delineator" select="' : '"/>
    <xsl:param name="doc_type" select="/mxd:ddf_doc/attribute::doc_type"/>
    
    <xsl:template match="/">
        <div class="mxdMetadata">
            <span class="mxdTitle">
                <xsl:value-of select="//mxd:original/mxd:main[1]"/>
            </span>
            <br/>
            <span class="mxdAuthors">
                <xsl:for-each select="//mxd:person">
                    <xsl:if test="mxd:name/mxd:last != ''">
                        <xsl:if test="position() &gt; 1">
                            <xsl:value-of select="$separator" />
                        </xsl:if>
                        <xsl:value-of select="concat(mxd:name/mxd:last/text(),', ',mxd:name/mxd:first/text())"/>
                    </xsl:if>
                </xsl:for-each>
            </span>
            <br/>
            <span class="mxdAffiliation">
                <xsl:for-each select="//mxd:organisation">
                    <xsl:if test="mxd:name/mxd:level1 != ''">
                        <xsl:if test="position() &gt; 1">
                            <xsl:value-of select="$separator"/>
                        </xsl:if>
                        <xsl:value-of select="mxd:name/mxd:level1"/>
                    </xsl:if>
                </xsl:for-each>
            </span>
            <br/>
            <br/>
            <xsl:for-each select="//mxd:event/mxd:title">
                <span class="mxdAdditionalKey">
                    <xsl:text>Conference</xsl:text>
                </span>
                <xsl:value-of select="$delineator"/>
                <span class="mxdAdditionalValue">
                    <xsl:if test="mxd:acronym">
                        <xsl:value-of select="mxd:acronym/text()"/>
                        <xsl:text> = </xsl:text>
                    </xsl:if>
                    <xsl:value-of select="mxd:full/text()"></xsl:value-of>
                </span>
                <br/>
            </xsl:for-each>
            <xsl:for-each select="//mxd:event/mxd:dates">
                <xsl:if test="mxd:start/text() != ''">
                    <span class="mxdAdditionalKey">
                        <xsl:text>Conference Year</xsl:text>
                    </span>
                    <xsl:value-of select="$delineator"/>
                    <span class="mxdAdditionalValue">
                        <xsl:value-of select="substring(mxd:start/text(),1,4)"/>
                    </span>
                    <br/>
                </xsl:if>
            </xsl:for-each>
            <xsl:for-each select="//mxd:local_field">
                <xsl:if test="mxd:data/text() != ''">
                    <span class="mxdAdditionalKey">
                        <xsl:value-of select="mxd:code/text()"/>
                    </span>
                    <xsl:value-of select="$delineator"/>
                    <span class="mxdAdditionalValue">
                        <xsl:value-of select="mxd:data/text()"/>
                    </span>
                    <br/>
                </xsl:if>
            </xsl:for-each>
            <xsl:if test="//mxd:keyword/text()">
                <!-- <xsl:if test=""> -->
                    <span class="mxdAdditionalKey">
                        <xsl:text>Keywords</xsl:text>
                    </span>
                    <xsl:value-of select="$delineator"/>
                    <span class="mxdAdditionalValue">
                        <xsl:for-each select="//mxd:keyword">
                            <xsl:if test="position() &gt; 1">
                                <xsl:value-of select="$separator" />
                            </xsl:if>
                            <xsl:value-of select="text()"/>
                        </xsl:for-each>
                    </span>
                    <br/>
                <!-- </xsl:if> -->
            </xsl:if>
            <xsl:if test="$doc_type">
                <span class="mxdAdditionalKey">
                    <xsl:text>Document Type</xsl:text>
                </span>
                <xsl:value-of select="$delineator"/>
                <span class="mxdAdditionalValue">
                    <xsl:choose>
                        <xsl:when test="$doc_type='dja'">
                            <xsl:text>Journal article</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='djl'">
                            <xsl:text>Journal letter (to the editor)</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='djc'">
                            <xsl:text>Journal comment</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='djr'">
                            <xsl:text>Journal review article</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='djb'">
                            <xsl:text>Journal book review</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='db'">
                            <xsl:text>Book</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='dba'">
                            <xsl:text>Book chapter</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='dbp'">
                            <xsl:text>Book preface, encyclopedia article</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='dct'">
                            <xsl:text>Conference talk/presentation</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='dcp'">
                            <xsl:text>Conference paper</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='dco'">
                            <xsl:text>Conference poster</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='dca'">
                            <xsl:text>Conference abstract</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='dna'">
                            <xsl:text>Newspaper article</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='dtd'">
                            <xsl:text>Thesis Doctoral</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='dtp'">
                            <xsl:text>Thesis Ph.D.</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='dtm'">
                            <xsl:text>Thesis Master</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='dts'">
                            <xsl:text>Student report</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='dr'">
                            <xsl:text>Report</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='dra'">
                            <xsl:text>Report chapter</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='dr'">
                            <xsl:text>Report</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='dra'">
                            <xsl:text>Report chapter</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='dl'">
                            <xsl:text>Lecture</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='dln'">
                            <xsl:text>Lecture notes</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='dw'">
                            <xsl:text>Working paper</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='dp'">
                            <xsl:text>Patent</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='do'">
                            <xsl:text>Other</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='dso'">
                            <xsl:text>Software</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='dd'">
                            <xsl:text>Data set</xsl:text>
                        </xsl:when>
                        <xsl:when test="$doc_type='drt'">
                            <xsl:text>Radio/TV broadcast</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$doc_type"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </span>
                <br/>                
            </xsl:if>
            <xsl:for-each select="//mxd:uri[@access='doi']">
                <span class="mxdAdditionalKey">
                    <xsl:text>DOI</xsl:text>
                </span>
                <xsl:value-of select="$delineator"/>
                <span class="mxdAdditionalValue">
                    <xsl:value-of select="text()"/>
                </span>
                <br/>
            </xsl:for-each>
            <br/>
            <xsl:if test="//mxd:abstract">
                <span class="mxdAbstract">
                    <xsl:value-of select="normalize-space(//mxd:abstract[1])"/>
                </span>
                <br/>
                <br/>
            </xsl:if>
            
            
            <!--
            <xsl:for-each select="/*/*">
                <xsl:variable name="FULLFIELD" select="name()"/>
                <xsl:variable name="FIELD" select="substring-after(name(),':')"/>
                <xsl:variable name="DATA" select="text()"/>
                <xsl:if test="$DATA != ' '">
                    <tr><td><strong><xsl:value-of select="substring-after(name(),':')"/></strong></td><td><xsl:value-of select="text()"/>
                        <xsl:for-each select="*">
                            <div>
                                <xsl:value-of select="substring-after(name(),':')"/> =  <xsl:value-of select="text()"/>
                            </div>
                        </xsl:for-each>
                    </td><td>
                        <a href="{$baseUrl}/search/fedora_repository/dc.{$FIELD}:{$DATA}"><img title="Find Similar by {$FIELD}" src="{$PATH}/images/view.gif" alt="Find Similar by {$FIELD}"
                </xsl:if>
            </xsl:for-each>  -->          
        </div>
    </xsl:template>
    
</xsl:stylesheet>
