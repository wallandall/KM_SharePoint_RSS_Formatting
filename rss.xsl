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

        <xsl:template name="RSSMainTemplate" xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
            <xsl:variable name="Rows" select="channel/item"/>
            <xsl:variable name="RowCount" select="count($Rows)"/>
<!--Main Container-->
            <div class="slm-layout-main" >
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
<!--Item Container -->
                    <div style="  font-size: 1.5rem;
                                  line-height: 1.6;
                                  font-weight: 400;
                                  font-family: Open Sans, Segoe UI Semilight , Segoe UI, Segoe,Tahoma,Helvetica,Arial,sans-serif;
                    ">
<!-- Item Image -->
                      <div style="width: 100px; height: 100px; float: left; margin:5px;"> <!--Image Container -->

                        <xsl:value-of select="chanel/url"/>
                        <xsl:variable name="ImageURL" select="enclosure/@url" />
                        <img alt="" src="{$ImageURL}" width="100%" height="100%" />
                      </div>


<!-- Item Container -->
                    <div style=" margin-left: 110px; "><!--description-->
<!-- Item Title -->
                      <h2 style="font-size: 2.4rem;
                              color: #000;
                              line-height: 1.25;
                              letter-spacing: -.1rem;
                              font-weight: 300;
                              font-family: Open Sans,Segoe UI Semilight,Segoe UI,Segoe,Tahoma,Helvetica,Arial,sans-serif;
                       ">
                        <a href="{ddwrt:EnsureAllowedProtocol(string(link))}" target="_blank"
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
<!--Call Item Content -->
                                <xsl:call-template name="RSSMainTemplate.description">
                                  <xsl:with-param name="DescriptionStyle" select="string('
                                    margin: 0;
                                    padding: 10px;
                                    border-spacing: 0px;
                                    color: #000;
                                    font-size: 1.5rem;
                                    line-height: 1.6;
                                    font-weight: 400;
                                    brder: dotted 2px green;
                                    font-family: Open Sans,Segoe UI,Segoe,Tahoma,Helvetica,Arial,sans-serif;
                                  ')"/>
                                    <xsl:with-param name="CurrentElement" select="$CurrentElement"/>
                                </xsl:call-template>


                      </div>
                    </div>
                </xsl:if>
            </xsl:for-each>
        </xsl:template>

	<xsl:template name="RSSMainTemplate.description" xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt">
            <xsl:param name="DescriptionStyle"/>
            <xsl:param name="CurrentElement"/>
	    <div id="{$CurrentElement}" class="description" align="{$rss_alignValue}" style="{$DescriptionStyle} text-align:{$rss_alignValue};">
            <p style=" margin:0;">
              <span style="
                float: left;
                color: #8e8e8e;
                font-size: 1.5rem;
                line-height: 1.6;
                font-weight: 400;
                font-family: Open Sans, Segoe UI, Segoe ,Tahoma,Helvetica,Arial,sans-serif;
                margin-right: 5px;
              ">
                <xsl:value-of select="ddwrt:FormatDateTime(string(pubDate), $rss_LCID, 'dddd MMMM d, yyyy')"/>
              </span>

            </p>

              <xsl:if test="string-length(description) &gt; 0">
                  <xsl:variable name="SafeHtml">
                      <xsl:call-template name="GetSafeHtml">
                          <xsl:with-param name="Html" select="description"/>
                      </xsl:call-template>
                  </xsl:variable>
                <xsl:value-of select="substring($SafeHtml, 1, 255)" disable-output-escaping="yes"/> ...
                <!--<xsl:value-of select="$SafeHtml" disable-output-escaping="yes"/> -->
              </xsl:if>

              <div class="description" style="display:block; padding-top: 10px; padding-bottom:10px;">
                  <a style="
                        color: #3385d6;
                        font-size: 1.5rem;
                        line-height: 1.6;
                        font-weight: 400;
                        font-family: Open Sans, Segoe UI, Segoe, Tahoma, Helvetica, Arial, sans-serif;"
                      href="{ddwrt:EnsureAllowedProtocol(string(link))}"
                      target="_blank">
                  > Read More
                  </a>
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
