<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xsd="http://www.w3.org/2001/XMLSchema" version="1.0"
	xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/">
	<xsl:param name="current-date" ></xsl:param>
	<xsl:param name="filename"></xsl:param>
	<xsl:output method="html" indent="yes" omit-xml-declaration="yes"
		media-type="application/xhtml+xml" />



	<xsl:template match="/wsdl:definitions">
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
		<html>
			<head>
				<style type="text/css">
					body, p, h1, h2, h3, h4, table, td, th {
					    font-family: verdana,helvetica,arial,sans-serif;
					    font-size:small;
					}
					table { border-collapse:collapse; border:1px }
					table td { border:1px solid black; padding:5px;}
					table th {
					border:1px solid black; background-color:Silver; font-weight:bold;}
					.simpleType td { border:0px; }
				</style>

				<script src="http://code.jquery.com/jquery-latest.js"></script>

				<script type="text/javascript">

					$(function() {
					$(".TypeLink").click (function() {
					typeName = $(this).text();
					typeView = $('#'+typeName);
					if (typeView.length > 0) {
					typeView.detach;
					$(this).after(typeView);
					$(this).parent().css("padding",
					"0px");
					$(this).hide();
					typeView.show(300);
					}
					return false;
					});
					});

				</script>
			</head>
			<body>
			
			<h1 >
			<xsl:value-of select="@name"></xsl:value-of>
			(<xsl:value-of select="$filename" />)
			</h1>
			<xsl:if test="$current-date" >
			<xsl:text >Generated on: </xsl:text>
			<xsl:value-of select="$current-date" />
			</xsl:if>
			<hr />
				<xsl:apply-templates select="node()" />

			</body>
		</html>

	</xsl:template>
	<xsl:template match="wsdl:portType/wsdl:operation">
		<table>
			<tr>
				<th colspan="2" align="center">
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
					<xsl:variable name="input"
						select="substring-after(wsdl:input/@message, ':')" />
					<a href="#" class="TypeLink">
						<xsl:value-of select="$input" />
					</a>
				</td>
			</tr>
			<tr>
				<td>Output</td>
				<td>
					<xsl:variable name="type"
						select="substring-after(wsdl:output/@message, ':')" />
					<a href="#" class="TypeLink">
						<xsl:value-of select="$type" />
					</a>
				</td>
			</tr>
		</table> <hr />
	</xsl:template>

	<xsl:template match="xsd:complexType">
		<table style="display:none;width:100%">
			<xsl:attribute name="id">
				<xsl:value-of select="@name" />
			</xsl:attribute>
			<tr>
				<th colspan="3" align="center">
					<a>
						<xsl:attribute name="name">
							<xsl:value-of select="@name"></xsl:value-of>
						</xsl:attribute>
					</a>
					<xsl:value-of select="@name"></xsl:value-of>
					<xsl:if test="xsd:documentation">
						<p colspan="3" align="left" style="color: #74B374; font-style: italic">
							<xsl:value-of select="xsd:documentation"></xsl:value-of>
						</p>
					</xsl:if>
				</th>
			</tr>

			<xsl:apply-templates />
		</table>

	</xsl:template>

	<xsl:template match="xsd:complexContent/xsd:extension">
		<tr>
			<td colspan="3">
				<div style="font-style:italic">Base type:</div>
				<xsl:variable name="type" select="substring-after(@base, ':')" />
				<a href="#" class="TypeLink">
					<xsl:value-of select="$type" />
				</a>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="xsd:sequence/xsd:element">
		<tr>
			<td>
				<xsl:value-of select="@name" />
			</td>
			<td>
				<xsl:choose>
					<xsl:when test="@minOccurs = 0">
						O
					</xsl:when>
					<xsl:when test="@minOccurs = 1">
						M
					</xsl:when>
					<xsl:when test="@minOccurs > 1">
						<xsl:value-of select="@minOccurs" />
					</xsl:when>
					<xsl:otherwise>
						M
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="@maxOccurs = 'unbounded'">
						, &#8734;
					</xsl:when>
					<xsl:when test="@maxOccurs > 1">
						,
						<xsl:value-of select="@maxOccurs" />
					</xsl:when>
				</xsl:choose>
			</td>
			<td>
				<xsl:variable name="type" select="substring-after(@type, ':')" />
				<a href="#" class="TypeLink">
					<xsl:value-of select="$type" />
				</a>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="xsd:element">
		<table style="display:none;width:100%">
			<xsl:attribute name="id">
				<xsl:value-of select="@name" />
			</xsl:attribute>
			<tr>
				<td>
					<xsl:value-of select="@name" />
				</td>
				<td>
					<xsl:variable name="type" select="substring-after(@type, ':')" />
					<a href="#" class="TypeLink">
						<xsl:value-of select="$type" />
					</a>
				</td>
			</tr>
		</table>

	</xsl:template>

	<xsl:template match="xsd:simpleType/xsd:restriction[xsd:enumeration]">
		<table style="display:none;width:100%">
			<xsl:attribute name="id">
				<xsl:value-of select="../@name" />
			</xsl:attribute>
			<tr>
				<th colspan="3" align="center">
					<a>
						<xsl:attribute name="name">
							<xsl:value-of select="../@name"></xsl:value-of>
						</xsl:attribute>
					</a>
					<xsl:value-of select="../@name"></xsl:value-of>
					<div><xsl:text>[enum]</xsl:text></div>
					<xsl:if test="xsd:documentation">
						<p colspan="3" align="left" style="color: #74B374; font-style: italic">
							<xsl:value-of select="xsd:documentation"></xsl:value-of>
						</p>
					</xsl:if>
				</th>
			</tr>

			<xsl:apply-templates />
		</table>
	</xsl:template>

	<xsl:template match="xsd:simpleType/xsd:restriction[count(xsd:enumeration) = 0]">

		<table style="display:none;width:100%; border:none" class="simpleType">
			<xsl:attribute name="id">
				<xsl:value-of select="../@name" />
			</xsl:attribute>
<tr><td>

					<a>
						<xsl:attribute name="name">
							<xsl:value-of select="../@name"></xsl:value-of>
						</xsl:attribute>
					</a>
					<xsl:value-of select="../@name"></xsl:value-of>
					</td>
					<td align="right" >
				<xsl:text> : </xsl:text>
				
				<xsl:variable name="type" select="substring-after(@base, ':')" />
				<a href="#" class="TypeLink">
					<xsl:value-of select="$type" />
				</a>
			</td></tr>
			<xsl:if test="xsd:documentation">
			<tr>
						<td colspan="3" align="left" style="color: #74B374; font-style: italic">
							<xsl:value-of select="xsd:documentastion"></xsl:value-of>
						</td>
						</tr>
					</xsl:if>
		</table>
	</xsl:template>
	
	<xsl:template match="xsd:enumeration">
		<tr>
			<td colspan="3">
				<xsl:value-of select="@value" />
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="@*|node()">
		<xsl:apply-templates select="node()" />
	</xsl:template>
	<xsl:template match="xsd:import">
		<xsl:variable name="schema" select="@schemaLocation" />
		<xsl:apply-templates select="document($schema)" />

	</xsl:template>


</xsl:stylesheet>