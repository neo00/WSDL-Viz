<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" version="1.0">
	<xsl:output method="html" indent="yes" omit-xml-declaration="no"
		media-type="application/xhtml+xml" />

	<!-- <xsl:template match="xs:import"> <xsl:variable name="schema" select="@schemaLocation"/> 
		<xsl:apply-templates select="document($schema)"/> </xsl:template> <xsl:template 
		match="node() | @*"> <xsl:copy> <xsl:apply-templates select="node() | @*"/> 
		</xsl:copy> </xsl:template> -->

	<xsl:template match="/">
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
		<html>
			<header>
				<style type="text/css">
					table { border-collapse:collapse; }
					table td, table th { border:1px solid black;padding:5px; }
				</style>
			</header>
			<body>
				<!-- <polygon points="100,10 40,180 190,60 10,60 160,180" style="fill:lime;stroke:purple;stroke-width:5;fill-rule:evenodd;" 
					/> -->
				<xsl:apply-templates select="node()" />

			</body>
		</html>

	</xsl:template>
	<xsl:template match="wsdl:portType/wsdl:operation"
		xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/">
		<table border="1px">
			<tr>
				<td colspan="2" align="center">
					<xsl:value-of select="@name"></xsl:value-of>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="left" style="color: #74B374; font-style: italic">
					<xsl:value-of select="wsdl:documentation"></xsl:value-of>
				</td>
			</tr>
			<tr>
				<td>Input</td>
				<td>
					<xsl:variable name="input" select="wsdl:input/@message" />
					<xsl:value-of select="//wsdl:message/wsdl:part/@type" />
					
				</td>
			</tr>
			<tr> 		
				<td>Output</td>
				<td>
					<xsl:value-of select="wsdl:output/@message"></xsl:value-of>
				</td>
			</tr>
		</table>
	</xsl:template>


	<xsl:template match="@*|node()">
		<xsl:apply-templates select="node()" />
	</xsl:template>

</xsl:stylesheet>