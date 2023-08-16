<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:mods="http://www.loc.gov/mods/v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-4.xsd"
    xmlns:functx="http://www.functx.com">

    <xsl:function name="functx:capitalize-first" as="xs:string?"
        xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>

        <xsl:sequence select="
                concat(upper-case(substring($arg, 1, 1)),
                substring($arg, 2))
                "/>
    </xsl:function>

    <xsl:output method="html" encoding="UTF-8"/>

    <xsl:template match="/">

        <div>
            <h1>
                <xsl:if test="mods:mods/mods:titleInfo[not(@type)]/mods:nonSort">
                    <xsl:value-of select="mods:mods/mods:titleInfo[not(@type)]/mods:nonSort"
                    /></xsl:if>
                <xsl:value-of select="mods:mods/mods:titleInfo[not(@type)]/mods:title"/>
                <xsl:if test="mods:mods/mods:titleInfo[not(@type)]/mods:subTitle">
                        :&#160;<xsl:value-of
                        select="mods:mods/mods:titleInfo[not(@type)]/mods:subTitle"/>
                </xsl:if>
            </h1>
        </div>
        <div>
            <table width="80%" align="left">
                <tr>
                    <td width="200px">
                        <b>Title</b>
                    </td>
                    <td>
                        <xsl:if test="mods:mods/mods:titleInfo[not(@type)]/mods:nonSort">
                            <xsl:value-of select="mods:mods/mods:titleInfo[not(@type)]/mods:nonSort"
                            /></xsl:if>
                        <xsl:value-of select="mods:mods/mods:titleInfo[not(@type)]/mods:title"/>
                        <xsl:if test="mods:mods/mods:titleInfo[not(@type)]/mods:subTitle">
                                :&#160;<xsl:value-of
                                select="mods:mods/mods:titleInfo[not(@type)]/mods:subTitle"/>
                        </xsl:if>
                        <xsl:if
                            test="mods:mods/mods:note[contains(@type, 'statementOfResponsibility')]"
                            >&#160;/&#160;<xsl:value-of
                                select="mods:mods/mods:note[@type = 'statementOfResponsibility']"
                            />
                        </xsl:if>
                    </td>
                </tr>
                <xsl:if test="mods:mods/mods:titleInfo[not(@type)]/mods:partNumber">
                    <tr>
                        <td>
                            <b>Part</b>
                        </td>
                        <td>
                            <xsl:value-of
                                select="mods:mods/mods:titleInfo[not(@type)]/mods:partNumber"/>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="mods:mods/mods:titleInfo[not(@type)]/mods:partName">
                    <tr>
                        <td>
                            <b>Part</b>
                        </td>
                        <td>
                            <xsl:value-of
                                select="mods:mods/mods:titleInfo[not(@type)]/mods:partName"/>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="mods:mods/mods:titleInfo[contains(@type, 'uniform')]">
                    <tr>
                        <td>
                            <b>Uniform Title</b>
                        </td>
                        <td>
                            <xsl:if
                                test="mods:mods/mods:titleInfo[contains(@type, 'uniform')]/mods:nonSort">
                                <xsl:value-of
                                    select="mods:mods/mods:titleInfo[contains(@type, 'uniform')]/mods:nonSort"
                                />&#160;</xsl:if>
                            <xsl:value-of
                                select="mods:mods/mods:titleInfo[contains(@type, 'uniform')]/mods:title"
                            />
                        </td>
                    </tr>
                    <xsl:if
                        test="mods:mods/mods:titleInfo[contains(@type, 'uniform')]/mods:partNumber"/>
                    <tr>
                        <td>
                            <b>Part</b>
                        </td>
                        <td>
                            <xsl:value-of
                                select="mods:mods/mods:titleInfo[contains(@type, 'uniform')]/mods:partNumber"
                            />
                        </td>
                    </tr>
                    <xsl:if
                        test="mods:mods/mods:titleInfo[contains(@type, 'uniform')]/mods:partName"/>
                    <tr>
                        <td>
                            <b>Part</b>
                        </td>
                        <td>
                            <xsl:value-of
                                select="mods:mods/mods:titleInfo[contains(@type, 'uniform')]/mods:partName"
                            />
                        </td>
                    </tr>
                </xsl:if>
                <xsl:for-each select="mods:mods/mods:part/mods:detail">
                    <tr>
                        <td>
                            <b>
                                <xsl:value-of select="functx:capitalize-first(mods:caption)"/>
                            </b>
                        </td>
                        <td>
                            <xsl:value-of select="mods:number"/>
                        </td>
                    </tr>
                </xsl:for-each>
                <xsl:for-each select="mods:mods/mods:name">
                    <tr>
                        <td>
                            <b>Creator</b>
                        </td>
                        <td>
                            <xsl:value-of select="mods:namePart[not(@type)]"/>, <xsl:if
                                test="mods:namePart[contains(@type, 'date')]">
                                <xsl:value-of select="mods:namePart[contains(@type, 'date')]"/>, </xsl:if>
                            <xsl:value-of select="mods:role/mods:roleTerm"/>
                            <xsl:if test="@valueURI">&#160;<a href="{@valueURI}">(link)</a></xsl:if>
                        </td>
                    </tr>
                </xsl:for-each>
                <tr>
                    <td>
                        <b>Publisher</b>
                    </td>
                    <td>
                        <xsl:if test="mods:mods/mods:originInfo/mods:place/mods:placeTerm">
                            <xsl:value-of
                                select="mods:mods/mods:originInfo/mods:place/mods:placeTerm[contains(@type, 'text')]"
                            /> : </xsl:if>
                        <xsl:if test="mods:mods/mods:originInfo/mods:publisher">
                            <xsl:value-of select="mods:mods/mods:originInfo/mods:publisher"/>, </xsl:if>
                        <xsl:if test="mods:mods/mods:originInfo/mods:dateIssued">
                            <xsl:value-of select="mods:mods/mods:originInfo/mods:dateIssued"/>
                        </xsl:if>
                    </td>
                </tr>
                <xsl:if test="mods:mods/mods:originInfo/mods:dateCaptured">
                    <tr>
                        <td>
                            <b>Digitized</b>
                        </td>
                        <td>
                            <xsl:value-of select="mods:mods/mods:originInfo/mods:dateCaptured"/>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="mods:mods/mods:location/mods:physicalLocation">
                    <tr>
                        <td>
                            <b>Physical Location</b>
                        </td>
                        <td>
                            <xsl:value-of select="mods:mods/mods:location/mods:physicalLocation"/>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="mods:mods/mods:location/mods:url">
                    <tr>
                        <td>
                            <b>URL</b>
                        </td>
                        <td>
                            <xsl:value-of select="mods:mods/mods:location/mods:url"/>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="mods:mods/mods:location/mods:shelfLocator">
                    <tr>
                        <td>
                            <b>Call Number</b>
                        </td>
                        <td>
                            <xsl:value-of select="."/>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="mods:mods/mods:identifier">
                    <tr>
                        <td>
                            <b>Identifier</b>
                        </td>
                        <td>
                            <xsl:value-of select="mods:mods/mods:identifier"/>
                        </td>
                    </tr>
                </xsl:if>
                <tr>
                    <td>
                        <b>Description</b>
                    </td>
                    <td>
                        <xsl:value-of select="mods:mods/mods:physicalDescription/mods:extent"/>
                    </td>
                </tr>

                <xsl:for-each select="mods:mods/mods:note[not(@type)]">
                    <tr>
                        <td>
                            <b>Note</b>
                        </td>
                        <td>
                            <xsl:value-of select="."/>
                        </td>
                    </tr>
                </xsl:for-each>
                
                <xsl:if test="mods:mods/mods:note[contains(@type, 'bibliography')]">
                    <tr>
                        <td>
                            <b>Bibliographical Note</b>
                        </td>
                        <td>                            
                            <xsl:value-of select="mods:mods/mods:note[contains(@type, 'bibliography')]"/>                            
                        </td>
                    </tr>                
                </xsl:if>
                
                <xsl:if test="mods:mods/mods:note[contains(@type, 'thesis')]">
                    <tr>
                        <td>
                            <b>Dissertation Note</b>
                        </td>
                        <td>                            
                            <xsl:value-of select="mods:mods/mods:note[contains(@type, 'thesis')]"/>                            
                        </td>
                    </tr>                
                </xsl:if>

                <xsl:for-each select="mods:mods/mods:abstract">
                    <tr>
                        <td>
                            <b>Abstract</b>
                        </td>
                        <td>
                            <xsl:value-of select="."/>
                        </td>
                    </tr>
                </xsl:for-each>
                <xsl:for-each select="mods:mods/mods:tableOfContents">
                    <tr>
                        <td>
                            <b>Table of Contents</b>
                        </td>
                        <td>
                            <xsl:value-of select="."/>
                        </td>
                    </tr>
                </xsl:for-each>                
                
                <xsl:for-each select="mods:mods/mods:subject">
                    <tr>
                        <td colspan="2">
                            <b>Subject</b>
                            <xsl:if test="@valueURI">&#160;<a href="{@valueURI}">(link)</a></xsl:if>
                        </td>
                    </tr>
                    <xsl:apply-templates select="mods:topic"/>
                    <xsl:apply-templates select="mods:geographic"/>
                    <xsl:apply-templates select="mods:genre"/>
                    <xsl:apply-templates select="mods:name"/>
                    <xsl:apply-templates select="mods:temporal"/>
                    <xsl:apply-templates select="mods:titleInfo"></xsl:apply-templates>
                </xsl:for-each>

                <xsl:for-each select="mods:mods/mods:accessCondition">
                    <tr>
                        <td>
                            <b>Access Condition</b>
                        </td>
                        <td>
                            <xsl:value-of select="."/>
                        </td>
                    </tr>
                </xsl:for-each>
                
                <xsl:if test="mods:mods/mods:note[contains(@type, 'restrictionOnAccess')]">
                    <tr>
                        <td>
                            <b>Access Note</b>
                        </td>
                        <td>                            
                            <xsl:value-of select="mods:mods/mods:note[contains(@type, 'restrictionOnAccess')]"/>                            
                        </td>
                    </tr>                
                </xsl:if>

                <xsl:for-each select="mods:mods/mods:relatedItem[@type = 'series']">
                    <tr>
                        <td>
                            <b>Series</b>
                        </td>
                        <td>
                            <xsl:if test="mods:titleInfo/mods:nonSort">
                                <xsl:value-of select="mods:titleInfo/mods:nonSort"/>&#160;</xsl:if>
                            <xsl:value-of select="mods:titleInfo/mods:title"/>
                            <xsl:if test="mods:identifier">,&#160;<xsl:value-of
                                    select="mods:identifier"/></xsl:if>
                        </td>
                    </tr>
                </xsl:for-each>


                <xsl:for-each select="mods:mods/mods:relatedItem[not(@type = 'series')]">
                    <tr>
                        <td>
                            <b>Related Item</b>
                        </td>
                        <td>
                            <xsl:if test="mods:titleInfo/mods:nonSort">
                                <xsl:value-of select="mods:titleInfo/mods:nonSort"/>&#160;</xsl:if>
                            <xsl:value-of select="mods:titleInfo/mods:title"/>
                            <xsl:if test="mods:name/mods:namePart">,&#160;<xsl:value-of
                                    select="mods:name/mods:namePart"/></xsl:if>
                            <xsl:if test="mods:originInfo/mods:dateIssued">,&#160;<xsl:value-of
                                    select="mods:originInfo/mods:dateIssued"/></xsl:if>
                            <xsl:if test="mods:originInfo/mods:publisher">,&#160;<xsl:value-of
                                    select="mods:originInfo/mods:publisher"/></xsl:if>
                            <xsl:if test="mods:identifier">,&#160;<xsl:value-of
                                    select="mods:identifier"/></xsl:if>
                            <xsl:if test="mods:location/mods:url">&#160;<a
                                    href="{mods:location/mods:url}">(link)</a></xsl:if>
                        </td>
                    </tr>
                </xsl:for-each>


            </table>
        </div>
    </xsl:template>

    <xsl:template match="mods:topic">
        <tr>
            <td>
                <b>- Subject (Topic)</b>
            </td>
            <td>
                <xsl:value-of select="."/>
                <xsl:if test="@valueURI">&#160;<a href="{@valueURI}">(link)</a></xsl:if>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="mods:geographic">
        <tr>
            <td>
                <b>- Subject (Geographic)</b>
            </td>
            <td>
                <xsl:value-of select="."/>
                <xsl:if test="@valueURI">&#160;<a href="{@valueURI}">(link)</a></xsl:if>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="mods:genre">
        <tr>
            <td>
                <b>- Subject (Genre)</b>
            </td>
            <td>
                <xsl:value-of select="."/>
                <xsl:if test="@valueURI">&#160;<a href="{@valueURI}">(link)</a></xsl:if>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="mods:name">
        <tr>
            <td>
                <b>- Subject (Name)</b>
            </td>
            <td>
                <xsl:value-of select="mods:namePart[not(@type)]"/>
                <xsl:if test="mods:namePart[contains(@type, 'date')]">, <xsl:value-of
                        select="mods:namePart[contains(@type, 'date')]"/></xsl:if>
                <xsl:if test="@valueURI">&#160;<a href="{@valueURI}">(link)</a></xsl:if>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="mods:temporal">
        <tr>
            <td>
                <b>- Subject (Temporal)</b>
            </td>
            <td>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="mods:titleInfo">
        <tr>
            <td>
                <b>- Subject (Title)</b>
            </td>
            <td>
                <xsl:value-of select="."/>                
            </td>
        </tr>
    </xsl:template>



</xsl:stylesheet>
