<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xsd="http://www.w3.org/2001/XMLSchema" version="1.0"
	xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/">
	<xsl:output method="html" indent="yes" omit-xml-declaration="no"
		media-type="application/xhtml+xml" />



	<xsl:template match="/wsdl:definitions" >
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
		<html>
			<header>
				<style type="text/css">
					table { border-collapse:collapse; }
					table td { border:1px solid black; padding:5px;}
					table th { border:1px solid black; background-color:Silver; font-weight:bold;}
				</style>
				
				<script src="http://code.jquery.com/jquery-latest.js"></script>

				<script type="text/javascript">

				$(function() {
						$(".TypeLink").click (function() {
						type = $(this).text();
						table = $('#'+type);
						if (table.length > 0) {
							table.detach;
							$(this).after(table);
							$(this).parent().css("padding", "0px");
							$(this).hide();
							table.show(300);
						}
						return false;
					});
				});

				</script>
			</header>
			<body>
				<!-- <polygon points="100,10 40,180 190,60 10,60 160,180" style="fill:lime;stroke:purple;stroke-width:5;fill-rule:evenodd;" 
					/> -->
				<xsl:apply-templates select="node()" />

			</body>
		</html>

	</xsl:template>
	<xsl:template match="wsdl:portType/wsdl:operation" >
		<table border="1px">
			<tr>
				<th colspan="2" align="center" >
					<xsl:value-of select="@name"></xsl:value-of>
				</th>
			</tr>
			<tr>
				<td colspan="2" align="left" style="color: #74B374; font-style: italic">
					<xsl:value-of select="wsdl:documentation"></xsl:value-of>
				</td>
			</tr>
			<tr>
				<td>Input</td>
				<td>
					<xsl:variable name="input" select="substring-after(wsdl:input/@message, ':')" />
					<a href ="#" class="TypeLink">
						<xsl:value-of select="$input" />
					</a>
				</td>
			</tr>
			<tr>
				<td>Output</td>
				<td>
					<xsl:variable name="type" select="substring-after(wsdl:output/@message, ':')" />
					<a href ="#" class="TypeLink">
						<xsl:value-of select="$type" />
					</a>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template match="xsd:complexType">
		<table border="1px" style="display:none;width:100%">
			<xsl:attribute name="id">
				<xsl:value-of select="@name"/>
			</xsl:attribute>
			<tr>
				<th colspan="3" align="center">
					<a >
						<xsl:attribute name="name">
							<xsl:value-of select="@name"></xsl:value-of>
						</xsl:attribute>
					</a>
					<xsl:value-of select="@name"></xsl:value-of>
				</th>
			</tr>
			<xsl:if test="xsd:documentation" >
				<p colspan="3" align="left" style="color: #74B374; font-style: italic">
					<xsl:value-of select="xsd:documentation"></xsl:value-of>
				</p>
			</xsl:if>
			<xsl:apply-templates />
		</table>
		
	</xsl:template>

	<xsl:template match="xsd:complexContent/xsd:extension" >
		<tr >
			<td colspan="3">
				<div style="font-style:italic">Base type:</div>
				<xsl:variable name="type" select="substring-after(@base, ':')" />
				<a href ="#" class="TypeLink">
					<xsl:value-of select="$type" />
				</a>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="xsd:sequence/xsd:element" >
		<tr>
			<td>
				<xsl:value-of select="@name"/>
			</td>
			<td>
				<xsl:choose  >
					<xsl:when test="@minOccurs = 0">O</xsl:when>
					<xsl:when test="@minOccurs = 1">M</xsl:when>
					<xsl:when test="@minOccurs > 1">
						<xsl:value-of select="@minOccurs"/>
					</xsl:when>
					<xsl:otherwise>M</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="@maxOccurs = 'unbounded'">, &#8734;</xsl:when>
					<xsl:when test="@maxOccurs > 1" >
						, <xsl:value-of select="@maxOccurs"/>
					</xsl:when>
				</xsl:choose>
			</td>
			<td>
				<xsl:variable name="type" select="substring-after(@type, ':')" />
				<a href ="#" class="TypeLink">
					<xsl:value-of select="$type" />
				</a>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="xsd:element">
		<table border="1px" style="display:none;width:100%">
			<xsl:attribute name="id">
				<xsl:value-of select="@name"/>
			</xsl:attribute>
			<tr>
				<td>
					<xsl:value-of select="@name"/>
				</td>
				<td >
					<xsl:variable name="type" select="substring-after(@type, ':')" />
					<a href ="#" class="TypeLink">
						<xsl:value-of select="$type" />
					</a>
				</td>
			</tr>
		</table>
		
	</xsl:template>

	<xsl:template match="@*|node()">
		<xsl:apply-templates select="node()" />
	</xsl:template>
	<xsl:template match="xsd:import">
		<xsl:variable name="schema" select="@schemaLocation"/>
		<xsl:apply-templates select="document($schema)"/>
		
	</xsl:template>

	
</xsl:stylesheet>