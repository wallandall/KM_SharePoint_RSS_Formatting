<xsl:stylesheet xmlns:x="http://www.w3.org/2001/XMLSchema"
               version="1.0" exclude-result-prefixes="xsl ddwrt msxsl rssaggwrt"
               xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime"
               xmlns:rssaggwrt="http://schemas.microsoft.com/WebParts/v3/rssagg/runtime"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt"
               xmlns:rssFeed="urn:schemas-microsoft-com:sharepoint:RSSAggregatorWebPart"
               xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:dc="http://purl.org/dc/elements/1.1/"
               xmlns:rss1="http://purl.org/rss/1.0/" xmlns:atom="http://www.w3.org/2005/Atom"
               xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd"
               xmlns:atom2="http://purl.org/atom/ns#">

    <xsl:param name="rss_FeedLimit">5</xsl:param>
    <xsl:param name="rss_ExpandFeed">false</xsl:param>
    <xsl:param name="rss_LCID">1033</xsl:param>
    <xsl:param name="rss_WebPartID">RSS_Viewer_WebPart</xsl:param>
    <xsl:param name="rss_alignValue">left</xsl:param>
    <xsl:param name="rss_IsDesignMode">True</xsl:param>

        <xsl:template match="rss">
            <xsl:call-template name="RSSMainTemplate"/>
        </xsl:template>

        <xsl:template match="rdf:RDF">
            <xsl:call-template name="RDFMainTemplate"/>
        </xsl:template>

        <xsl:template match="atom:feed">
            <xsl:call-template name="ATOMMainTemplate"/>
        </xsl:template>

        <xsl:template match="atom2:feed">
            <xsl:call-template name="ATOM2MainTemplate"/>
        </xsl:template>


<!-- Edit Main Title Main Title -->
        <xsl:template name="RSSMainTemplate" xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
            <xsl:variable name="Rows" select="channel/item"/>
            <xsl:variable name="RowCount" select="count($Rows)"/>
            <div class="slm-layout-main" >
<!--Remove Title
            <div class="groupheader item medium">
                        <a href="{ddwrt:EnsureAllowedProtocol(string(channel/link))}">
                            <xsl:value-of select="channel/title"/>
                        </a>
            </div>
-->
            <xsl:call-template name="RSSMainTemplate.body">
                <xsl:with-param name="Rows" select="$Rows"/>
                <xsl:with-param name="RowCount" select="count($Rows)"/>
            </xsl:call-template>
            </div>
        </xsl:template>

        <xsl:template name="RSSMainTemplate.body" xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
            <xsl:param name="Rows"/>
            <xsl:param name="RowCount"/>
            <xsl:for-each select="$Rows">
                <xsl:variable name="CurPosition" select="position()" />
                <xsl:variable name="RssFeedLink" select="$rss_WebPartID" />
                <xsl:variable name="CurrentElement" select="concat($RssFeedLink,$CurPosition)" />
                <xsl:if test="($CurPosition &lt;= $rss_FeedLimit)">
<!-- Item Styling-->
                    <div style="margin: 0;
                                padding: 0;
                                display: block;
                                border-spacing: 0px;
                                color: #000;
                                font-size: 1.5rem;
                                line-height: 1.6;
                                font-weight: 400;
                                font-family: Open Sans,Segoe UI,Segoe,Tahoma,Helvetica,Arial,sans-serif;
                    ">
  <!-- H2 styling for item text -->
                    <h2 style="margin-bottom: 0;
                              font-size: 2.4rem;
                              padding: 0;
                              margin: 0;
                              color: #000;
                              line-height: 1.25;
                              letter-spacing: -.1rem;
                              font-weight: 300;
                              font-family: Open Sans,Segoe UI Semilight,Segoe UI,Segoe,Tahoma,Helvetica,Arial,sans-serif;
                              border-spacing: 0px;

                    ">
                            <a href="{concat(&quot;javascript:ToggleItemDescription('&quot;,$CurrentElement,&quot;')&quot;)}"
                              style="
                              border-spacing: 0px;
                              font-size: 2.4rem;
                              line-height: 1.25;
                              letter-spacing: -.1rem;
                              font-weight: 300;
                              font-family: Open Sans,Segoe UI Semilight,Segoe UI,Segoe,Tahoma,Helvetica,Arial,sans-serif;
                            ">
                                <xsl:value-of select="title"/>
                            </a>
                  </h2>
<!--Formating for text. If minimised hide content, if expanded set text-->
                            <xsl:if test="$rss_ExpandFeed = true()">
                                <xsl:call-template name="RSSMainTemplate.description">
                                    <xsl:with-param name="DescriptionStyle" select="string('
                                      display:block;
                                      margin: 0;
                                      padding: 10px;
                                      border-spacing: 0px;
                                      color: #000;
                                      font-size: 1.5rem;
                                      line-height: 1.6;
                                      font-weight: 400;
                                      font-family: Open Sans,Segoe UI,Segoe,Tahoma,Helvetica,Arial,sans-serif;
                                    ')"/>
                                    <xsl:with-param name="CurrentElement" select="$CurrentElement"/>
                                </xsl:call-template>
                            </xsl:if>
                            <xsl:if test="$rss_ExpandFeed = false()">
                                <xsl:call-template name="RSSMainTemplate.description">
                                    <xsl:with-param name="DescriptionStyle" select="string('
                                      display:none;
                                      margin: 0;
                                      padding: 10px;
                                      border-spacing: 0px;
                                      color: #000;
                                      font-size: 1.5rem;
                                      line-height: 1.6;
                                      font-weight: 400;
                                      font-family: Open Sans,Segoe UI,Segoe,Tahoma,Helvetica,Arial,sans-serif;
                                    ')"/>
                                    <xsl:with-param name="CurrentElement" select="$CurrentElement"/>
                                </xsl:call-template>
                            </xsl:if>
                    </div>
                    <hr/>
                </xsl:if>

            </xsl:for-each>
        </xsl:template>

	<xsl:template name="RSSMainTemplate.description" xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
            <xsl:param name="DescriptionStyle"/>
            <xsl:param name="CurrentElement"/>
	    <div id="{$CurrentElement}" class="description" align="{$rss_alignValue}" style="{$DescriptionStyle} text-align:{$rss_alignValue};">
                <xsl:choose>
                    <!-- some RSS2.0 contain pubDate tag, some others dc:date -->
                    <xsl:when test="string-length(pubDate) &gt; 0">
                        <xsl:variable name="pubDateLength" select="string-length(pubDate) - 3" />
		        <xsl:value-of select="ddwrt:FormatDate(substring(pubDate,0,$pubDateLength),number($rss_LCID),3)"/>
                    </xsl:when>
                    <xsl:otherwise>
                    	<xsl:value-of select="ddwrt:FormatDate(string(dc:date),number($rss_LCID),3)"/>
                    </xsl:otherwise>
                </xsl:choose>

                <xsl:if test="string-length(description) &gt; 0">
                    <xsl:variable name="SafeHtml">
                        <xsl:call-template name="GetSafeHtml">
                            <xsl:with-param name="Html" select="description"/>
                        </xsl:call-template>
                    </xsl:variable>
  <!--Remove hyphen
                     -
  -->
  <!--SafeHtml: Set disabled-ouput-escaping+"yes" to format html. set to NO to display plain html
-->
<!--Truncate text to 350 Chars
<xsl:value-of select="substring($SafeHtml, 1, 350)" disable-output-escaping="yes"/> [...]
-->
                     <xsl:value-of select="$SafeHtml" disable-output-escaping="yes"/>
                </xsl:if>
		    <div class="description" style="display:block; padding-top: 10px; padding-bottom:10px;">
<!--Comment out default More...		and add KM Formating        <a href="{ddwrt:EnsureAllowedProtocol(string(link))}">More...</a>
<a style="
  font-weight: 700; width:200px;
  background-color: #fc0;
  font-size: 14px;
  padding: 15px 20px;
  border: none;
  box-shadow: 4px 6px 8px rgba(151,125,22,.15);
  display: block;
  color: #000;
  cursor: pointer;
  text-transform: uppercase;
  text-decoration: none"
  href="{ddwrt:EnsureAllowedProtocol(string(link))}"
  target="_blank">Source</a>
-->

	        </div>
        </div>
        </xsl:template>


        <xsl:template name="RDFMainTemplate" xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
            <xsl:variable name="Rows" select="rss1:item"/>
            <xsl:variable name="RowCount" select="count($Rows)"/>
            <div class="slm-layout-main" >
            <div class="groupheader item medium">
                <a href="{ddwrt:EnsureAllowedProtocol(string(rss1:channel/rss1:link))}">
                    <xsl:value-of select="rss1:channel/rss1:title"/>
                </a>
            </div>
            <xsl:call-template name="RDFMainTemplate.body">
                <xsl:with-param name="Rows" select="$Rows"/>
                <xsl:with-param name="RowCount" select="count($Rows)"/>
            </xsl:call-template>
            </div>
        </xsl:template>

        <xsl:template name="RDFMainTemplate.body" xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
            <xsl:param name="Rows"/>
            <xsl:param name="RowCount"/>
            <xsl:for-each select="$Rows">
                <xsl:variable name="CurPosition" select="position()" />
                <xsl:variable name="RssFeedLink" select="$rss_WebPartID" />
                <xsl:variable name="CurrentElement" select="concat($RssFeedLink,$CurPosition)" />
                <xsl:if test="($CurPosition &lt;= $rss_FeedLimit)">
                    <div class="item link-item" >
                        <a href="{concat(&quot;javascript:ToggleItemDescription('&quot;,$CurrentElement,&quot;')&quot;)}" >
                            <xsl:value-of select="rss1:title"/>
                        </a>
                        <xsl:if test="$rss_ExpandFeed = true()">
                                <xsl:call-template name="RDFMainTemplate.description">
                                    <xsl:with-param name="DescriptionStyle" select="string('display:block;')"/>
                                    <xsl:with-param name="CurrentElement" select="$CurrentElement"/>
                                </xsl:call-template>
                        </xsl:if>
                        <xsl:if test="$rss_ExpandFeed = false()">
                                <xsl:call-template name="RDFMainTemplate.description">
                                    <xsl:with-param name="DescriptionStyle" select="string('display:none;')"/>
                                    <xsl:with-param name="CurrentElement" select="$CurrentElement"/>
                                </xsl:call-template>
                        </xsl:if>
                    </div>
		            </xsl:if>
            </xsl:for-each>
      </xsl:template>

	    <xsl:template name="RDFMainTemplate.description" xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
            <xsl:param name="DescriptionStyle"/>
            <xsl:param name="CurrentElement"/>
	    <div id="{$CurrentElement}" class="description" align="{$rss_alignValue}" style="{$DescriptionStyle} text-align:{$rss_alignValue};">
		    <xsl:value-of select="ddwrt:FormatDate(string(dc:date),number($rss_LCID),3)"/>
                <xsl:if test="string-length(rss1:description) &gt; 0">
                    <xsl:variable name="SafeHtml">
                        <xsl:call-template name="GetSafeHtml">
                            <xsl:with-param name="Html" select="rss1:description"/>
                        </xsl:call-template>
                    </xsl:variable>
                     - <xsl:value-of select="$SafeHtml" disable-output-escaping="yes"/>
                </xsl:if>
		            <div class="description">
		                <a href="{ddwrt:EnsureAllowedProtocol(string(rss1:link))}">More...</a>
	              </div>
        </div>
        </xsl:template>


        <xsl:template name="ATOMMainTemplate" xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
            <xsl:variable name="Rows" select="atom:entry"/>
            <xsl:variable name="RowCount" select="count($Rows)"/>
            <div class="slm-layout-main" >
            <div class="groupheader item medium">
                <a href="{ddwrt:EnsureAllowedProtocol(string(atom:link/@href))}">
                    <xsl:value-of select="atom:title"/>
                </a>
            </div>
            <xsl:call-template name="ATOMMainTemplate.body">
                <xsl:with-param name="Rows" select="$Rows"/>
                <xsl:with-param name="RowCount" select="count($Rows)"/>
            </xsl:call-template>
            </div>
        </xsl:template>

        <xsl:template name="ATOMMainTemplate.body" xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
            <xsl:param name="Rows"/>
            <xsl:param name="RowCount"/>
            <xsl:for-each select="$Rows">
                <xsl:variable name="CurPosition" select="position()" />
                <xsl:variable name="RssFeedLink" select="$rss_WebPartID" />
                <xsl:variable name="CurrentElement" select="concat($RssFeedLink,$CurPosition)" />
                <xsl:if test="($CurPosition &lt;= $rss_FeedLimit)">
                            <div class="item link-item" >
                                <a href="{concat(&quot;javascript:ToggleItemDescription('&quot;,$CurrentElement,&quot;')&quot;)}" >
                                    <xsl:value-of select="atom:title"/>
                                </a>
                            <xsl:if test="$rss_ExpandFeed = true()">
                                <xsl:call-template name="ATOMMainTemplate.description">
                                    <xsl:with-param name="DescriptionStyle" select="string('display:block;')"/>
                                    <xsl:with-param name="CurrentElement" select="$CurrentElement"/>
                                </xsl:call-template>
                            </xsl:if>
                            <xsl:if test="$rss_ExpandFeed = false()">
                                <xsl:call-template name="ATOMMainTemplate.description">
                                    <xsl:with-param name="DescriptionStyle" select="string('display:none;')"/>
                                    <xsl:with-param name="CurrentElement" select="$CurrentElement"/>
                                </xsl:call-template>
                            </xsl:if>
                            </div>
		</xsl:if>
            </xsl:for-each>
        </xsl:template>

	<xsl:template name="ATOMMainTemplate.description" xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
            <xsl:param name="DescriptionStyle"/>
            <xsl:param name="CurrentElement"/>
	    <div id="{$CurrentElement}" class="description" align="{$rss_alignValue}" style="{$DescriptionStyle} text-align:{$rss_alignValue};">
		<xsl:value-of select="ddwrt:FormatDate(string(atom:updated),number($rss_LCID),3)"/>
                <xsl:choose>
                    <xsl:when test="string-length(atom:summary) &gt; 0">
                        <xsl:variable name="SafeHtml">
                            <xsl:call-template name="GetSafeHtml">
                                <xsl:with-param name="Html" select="atom:summary"/>
                            </xsl:call-template>
                        </xsl:variable>
                         - <xsl:value-of select="$SafeHtml" disable-output-escaping="yes"/>
                    </xsl:when>
                    <xsl:when test="string-length(atom:content) &gt; 0">
                        <xsl:variable name="SafeHtml">
                            <xsl:call-template name="GetSafeHtml">
                                <xsl:with-param name="Html" select="atom:content"/>
                            </xsl:call-template>
                        </xsl:variable>
                         - <xsl:value-of select="$SafeHtml" disable-output-escaping="yes"/>
                    </xsl:when>
                </xsl:choose>
		    <div class="description">
		        <a href="{ddwrt:EnsureAllowedProtocol(string(atom:link/@href))}">More...</a>
	        </div>
        </div>
        </xsl:template>

        <xsl:template name="ATOM2MainTemplate" xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
            <xsl:variable name="Rows" select="atom2:entry"/>
            <xsl:variable name="RowCount" select="count($Rows)"/>
            <div class="slm-layout-main" >
            <div class="groupheader item medium">
                <a href="{ddwrt:EnsureAllowedProtocol(string(atom2:link/@href))}">
                    <xsl:value-of select="atom2:title"/>
                </a>
            </div>
            <xsl:call-template name="ATOM2MainTemplate.body">
                <xsl:with-param name="Rows" select="$Rows"/>
                <xsl:with-param name="RowCount" select="count($Rows)"/>
            </xsl:call-template>
            </div>
        </xsl:template>

        <xsl:template name="ATOM2MainTemplate.body" xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
            <xsl:param name="Rows"/>
            <xsl:param name="RowCount"/>
            <xsl:for-each select="$Rows">
                <xsl:variable name="CurPosition" select="position()" />
                <xsl:variable name="RssFeedLink" select="$rss_WebPartID" />
                <xsl:variable name="CurrentElement" select="concat($RssFeedLink,$CurPosition)" />
                <xsl:if test="($CurPosition &lt;= $rss_FeedLimit)">
                     <div class="item link-item" >
                                <a href="{concat(&quot;javascript:ToggleItemDescription('&quot;,$CurrentElement,&quot;')&quot;)}" >
                                    <xsl:value-of select="atom2:title"/>
                                </a>
                            <xsl:if test="$rss_ExpandFeed = true()">
                                <xsl:call-template name="ATOM2MainTemplate.description">
                                    <xsl:with-param name="DescriptionStyle" select="string('display:block;')"/>
                                    <xsl:with-param name="CurrentElement" select="$CurrentElement"/>
                                </xsl:call-template>
                            </xsl:if>
                            <xsl:if test="$rss_ExpandFeed = false()">
                                <xsl:call-template name="ATOM2MainTemplate.description">
                                    <xsl:with-param name="DescriptionStyle" select="string('display:none;')"/>
                                    <xsl:with-param name="CurrentElement" select="$CurrentElement"/>
                                </xsl:call-template>
                            </xsl:if>
                    </div>
		</xsl:if>
            </xsl:for-each>
        </xsl:template>

	<xsl:template name="ATOM2MainTemplate.description" xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
            <xsl:param name="DescriptionStyle"/>
            <xsl:param name="CurrentElement"/>
	    <div id="{$CurrentElement}" class="description" align="{$rss_alignValue}" style="{$DescriptionStyle} text-align:{$rss_alignValue};">
		    <xsl:value-of select="ddwrt:FormatDate(string(atom2:updated),number($rss_LCID),3)"/>
                <xsl:choose>
                    <xsl:when test="string-length(atom2:summary) &gt; 0">
                        <xsl:variable name="SafeHtml">
                            <xsl:call-template name="GetSafeHtml">
                                <xsl:with-param name="Html" select="atom2:summary"/>
                            </xsl:call-template>
                        </xsl:variable>
                         - <xsl:value-of select="$SafeHtml" disable-output-escaping="yes"/>
                    </xsl:when>
                    <xsl:when test="string-length(atom2:content) &gt; 0">
                        <xsl:variable name="SafeHtml">
                            <xsl:call-template name="GetSafeHtml">
                                <xsl:with-param name="Html" select="atom2:content"/>
                            </xsl:call-template>
                        </xsl:variable>
                         - <xsl:value-of select="$SafeHtml" disable-output-escaping="yes"/>
                    </xsl:when>
                </xsl:choose>
		    <div class="description">
    		    <a href="{ddwrt:EnsureAllowedProtocol(string(atom2:link/@href))}">More...</a>
	        </div>
        </div>
        </xsl:template>

        <xsl:template name="GetSafeHtml">
            <xsl:param name="Html"/>
            <xsl:choose>
                <xsl:when test="$rss_IsDesignMode = 'True'">
                     <xsl:value-of select="$Html"/>
                </xsl:when>
                <xsl:otherwise>
                     <xsl:value-of select="rssaggwrt:MakeSafe($Html)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:template>

</xsl:stylesheet>
